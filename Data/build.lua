return ' ' .. UTF8.trimFull([[
    local SERVER = (function()
        local crypto = require 'crypto'
        local socket = require 'socket'
        local json = require 'json'
        local mime = require 'mime'
        local M = {}

        M.getOnline = function()
            local isNetworkAvailable = false
            if not M.online then M.online = socket.tcp() M.online:settimeout(0) end
            local con, err = M.online:connect('www.google.com', 80)
            isNetworkAvailable = con ~= nil or err == 'already connected'
            return isNetworkAvailable
        end

        M.getIP = function()
            local s = socket.udp()
            s:setpeername('74.125.115.104', 80)
            return select(1, s:getsockname())
        end

        M.createServer = function(port, serverListener)
            if not M.serverIsCreated then
                local serverListener = serverListener or (function() return {} end)
                local tcp, err = socket.bind(M.getIP(), port) tcp:settimeout(0)
                local clientList, clientBuffer = {}, {} M.serverIsCreated = true

                local function sPulse()
                    pcall(function()
                        local newClientList = {}

                        repeat
                            local client = tcp:accept()
                            if client then
                                client:settimeout(0)
                                newClientList[#newClientList + 1] = client
                            end
                        until not client

                        local ready, writeReady, err = socket.select(clientList, clientList, 0)
                        if err == nil then
                            for i = 1, #ready do
                                local client, sess_hash = ready[i]
                                local data, err = client:receive()

                                if data then
                                    data = json.decode(data)

                                    if data._sess_hash and clientBuffer[data._sess_hash] then
                                        sess_hash = data._sess_hash
                                    end
                                else
                                    for key, buffer in pairs(clientBuffer) do
                                        if buffer[2] == client then
                                            sess_hash = key
                                            break
                                        end
                                    end data = {}
                                end

                                local _data = serverListener(data)

                                if sess_hash then
                                    clientBuffer[sess_hash][1] = json.encode2(type(_data) == 'table' and _data or {})
                                    clientBuffer[sess_hash][3] = _data
                                end
                            end

                            for _, buffer in pairs(clientBuffer) do
                                buffer[2]:send(buffer[1] .. '\n')
                                buffer[1] = '{}\n'
                            end
                        end

                        if #newClientList > 0 then
                            local _ready, _writeReady, _err = socket.select(newClientList, newClientList, 0)
                            if _err == nil then
                                for i = 1, #_ready do
                                    local client = _ready[i]
                                    local data, err = client:receive()

                                    if data then
                                        local _data = json.decode(data)

                                        if _data._sess_hash then
                                            if clientBuffer[_data._sess_hash] then
                                                local index = table.indexOf(clientList, clientBuffer[_data._sess_hash][2])
                                                if index then table.remove(clientList, index) end

                                                clientList[#clientList + 1] = client
                                                clientBuffer[_data._sess_hash][2] = client
                                            end
                                        else
                                            local ip = client:getpeername()
                                            local encodedData = crypto.hmac(crypto.md5, ip .. ':' .. math.random(111111, 999999), '?.сс_ode')

                                            clientList[#clientList + 1] = client
                                            clientBuffer[encodedData] = {json.encode2({_sess_hash = encodedData}) .. '\n', client, {}}
                                        end
                                    else
                                        local ip = client:getpeername()
                                        local encodedData = crypto.hmac(crypto.md5, ip .. ':' .. math.random(111111, 999999), '?.сс_ode')

                                        clientList[#clientList + 1] = client
                                        clientBuffer[encodedData] = {json.encode2({_sess_hash = encodedData}), client, {}}
                                    end
                                end

                                for _, buffer in pairs(clientBuffer) do
                                    buffer[2]:send(buffer[1] .. '\n')
                                    buffer[1] = '{}\n'
                                end
                            end
                        end
                    end)
                end

                local serverPulse = timer.performWithDelay(100, sPulse, 0)

                local function stopServer()
                    timer.cancel(serverPulse)
                    tcp:close() M.serverIsCreated = nil
                    if M.online then M.online:close() end
                    for i, v in pairs(clientList) do
                        v:close()
                    end
                end

                return stopServer
            end
        end

        return M
    end)()

    local CLIENT = (function()
        local socket = require 'socket'
        local json = require 'json'
        local mime = require 'mime'
        local M = {}

        M.createClientLoop = function(ip, port, clientListener)
            local clientListener = clientListener or (function() return {} end)
            local sock, clientTable, clientPulse = M.connectToServer(ip, port), {}

            local function cPulse()
                if SERVER.getOnline() then
                    local data, err = sock:receive()

                    if err == 'closed' and clientPulse then
                        sock = M.connectToServer(ip, port, clientTable._sess_hash)
                        local data = sock and sock:receive() or nil
                    end

                    if data then
                        data = json.decode(data)

                        if data._sess_hash and not clientTable._sess_hash then
                            clientTable._sess_hash = data._sess_hash
                        elseif not data._sess_hash and clientTable._sess_hash then
                            data._sess_hash = clientTable._sess_hash
                        end data._device_id = DEVICE_ID or system.getInfo('deviceID')
                    else
                        data = {}
                    end

                    local _data = clientListener(data)

                    if type(_data) == 'table' then
                        if clientTable._sess_hash then
                            _data._sess_hash = clientTable._sess_hash
                        end _data._device_id = DEVICE_ID or system.getInfo('deviceID')
                    end

                    local msg = json.encode2(type(_data) == 'table' and _data or {}) .. '\n'

                    local data, err = sock:send(msg)
                    if err == 'closed' and clientPulse then
                        sock = M.connectToServer(ip, port, clientTable._sess_hash)
                        if sock then sock:send(msg) end
                    end
                end
            end


            clientPulse = timer.performWithDelay(100, cPulse, 0)

            local function stopClient()
                timer.cancel(clientPulse) clientPulse = nil sock:close()
                if SERVER.online then SERVER.online:close() end
            end

            return stopClient
        end

        M.connectToServer = function(ip, port, sess_hash)
            local sock = socket.connect(ip, port)
            if sock == nil then return false end

            sock:settimeout(0)
            sock:setoption('tcp-nodelay', true)
            sock:send(json.encode2({_sess_hash = sess_hash}) .. '\n')

            return sock
        end

        return M
    end)()

    local function getGlobal()
        local function appResize(type)
            if CURRENT_ORIENTATION ~= type then
                CENTER_X, CENTER_Y = CENTER_Y, CENTER_X
                DISPLAY_WIDTH, DISPLAY_HEIGHT = DISPLAY_HEIGHT, DISPLAY_WIDTH
                TOP_HEIGHT, LEFT_HEIGHT = LEFT_HEIGHT, TOP_HEIGHT
                BOTTOM_HEIGHT, RIGHT_HEIGHT = RIGHT_HEIGHT, BOTTOM_HEIGHT

                ZERO_X = CENTER_X - DISPLAY_WIDTH / 2 + LEFT_HEIGHT
                ZERO_Y = CENTER_Y - DISPLAY_HEIGHT / 2 + TOP_HEIGHT
                MAX_X = CENTER_X + DISPLAY_WIDTH / 2 - RIGHT_HEIGHT
                MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT
            end

            CURRENT_ORIENTATION = type
            ORIENTATION.lock(CURRENT_ORIENTATION)
        end

        function setOrientationApp(event)
            appResize(event.type)
        end

        BITMAP = require 'plugin.memoryBitmap'
        FILE = require 'plugin.cnkFileManager'
        EXPORT = require 'plugin.exportFile'
        ORIENTATION = require 'plugin.orientation'
        IMPACK = require 'plugin.impack'
        SVG = require 'plugin.nanosvg'
        ZIP = require 'plugin.zip'
        PHYSICS = require 'physics'
        JSON = require 'json'
        WIDGET = require 'widget'
        CRYPTO = require 'crypto'

        ORIENTATION.init()
        CURRENT_LINK = 'App'
        CURRENT_ORIENTATION = 'portrait'
        CENTER_X = display.contentCenterX
        CENTER_Y = display.contentCenterY
        DISPLAY_WIDTH = display.actualContentWidth
        DISPLAY_HEIGHT = display.actualContentHeight
        TOP_HEIGHT, LEFT_HEIGHT, BOTTOM_HEIGHT, RIGHT_HEIGHT = display.getSafeAreaInsets()
        ZERO_X = CENTER_X - DISPLAY_WIDTH / 2 + LEFT_HEIGHT
        ZERO_Y = CENTER_Y - DISPLAY_HEIGHT / 2 + TOP_HEIGHT
        MAX_X = CENTER_X + DISPLAY_WIDTH / 2 - RIGHT_HEIGHT
        MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT

        IS_ZERO_TABLE = function(t)
            local result = true

            pcall(function()
                for key, value in pairs(t) do
                    result = false
                    break
                end
            end)

            return result
        end

        COPY_TABLE = function(t)
            local result = {}

            pcall(function() if t then
                for key, value in pairs(t) do
                    if type(value) == 'table' then
                        result[key] = COPY_TABLE(value)
                    else
                        result[key] = value
                    end
                end
            end end)

            return result
        end

        COPY_TABLE_P = function(t)
            local result = {}

            pcall(function()
                if type(t[1]) == 'table' and #t == 1 then
                    result = COPY_TABLE(t[1])
                else
                    result = COPY_TABLE(t)
                end
            end)

            return result
        end

        GET_X = function(x)
            return type(x) == 'number' and x - CENTER_X or 0
        end

        GET_Y = function(y)
            return type(y) == 'number' and CENTER_Y - y or 0
        end

        GET_GAME_SAVE = function(link)
            local path = DOC_DIR .. '/' .. link .. '/save.json'
            local file, data = io.open(path, 'r'), {}

            if file then
                data = JSON.decode(file:read('*a'))
                io.close(file)
            end

            return data
        end

        SET_GAME_SAVE = function(link, data)
            local path = DOC_DIR .. '/' .. link .. '/save.json'
            local file = io.open(path, 'w')

            if file then
                file:write(JSON.encode(data))
                io.close(file)
            end
        end

        OS_MOVE = function(link, link2)
            if system.getInfo 'environment' == 'simulator' then
                link = UTF8.gsub(link, '/', '\\')
                link2 = UTF8.gsub(link2, '/', '\\')
                os.execute('move /y "' .. link .. '" "' .. link2 .. '"')
            else
                os.execute('mv -f "' .. link .. '" "' .. link2 .. '"')
            end
        end

        PHYSICS.setAverageCollisionPositions(true)
        WIDGET.setTheme('widget_theme_android_holo_dark')
        PHYSICS.setReportCollisionsInContentCoordinates(true)
        display.setStatusBar(display.HiddenStatusBar) math.randomseed(os.time())
        JSON.decode2, JSON.decode = JSON.decode, function(str) return type(str) == 'string' and (JSON.decode2(str) or {}) or nil end
        math.factorial = function(num) if num == 0 then return 1 else return num * math.factorial(num - 1) end end
        math.hex = function(hex) local r, g, b = hex:match('(..)(..)(..)') return {tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)} end
        UTF8.split = function(text, sep) local result = {} for s in text:gmatch('[^' .. sep .. ']+') do result[#result + 1] = s end return result end
        UTF8.trim = function(s) return UTF8.gsub(UTF8.gsub(s, '^%s+', ''), '%s+$', '') end
        UTF8.trimLeft = function(s) return UTF8.gsub(s, '^%s+', '') end
        UTF8.trimRight = function(s) return UTF8.gsub(s, '%s+$', '') end
        UTF8.trimFull = function(s) return UTF8.trim(UTF8.gsub(s, '%s+', ' ')) end
        timer.new = function(sec, rep, lis) return timer.performWithDelay(sec, lis, rep) end
        math.sum = function(...) local args, num = {...}, 0 for i = 1, #args do num = num + args[i] end return num end
        math.getMaskBits = function(t) local s = 0 for j = 1, #t do s = s + math.getBit(t[j]) end return s end
        math.getBit = function(i) return 2 ^ (i-1) end
        table.len, math.round, table.merge = function(t)
            return type(t) == 'table' and ((type(#t) == 'number' and #t > 0) and #t
            or (function() local i = 0 for k in pairs(t) do i = i + 1 end return i end)()) or 0
        end, function(num, exp)
            if (not exp) or (not tonumber(exp)) then return tonumber(string.match(tostring(num), '(.*)%.')) or num
            else local exps, factor = string.match(tostring(num), '%.(.*)'), tonumber(exp) == 0 and '0.' or '0.0' if not exps then
            return num end for i = 1, tonumber(exp) - 1 do factor = factor .. '0' end factor = factor .. '5' num = tonumber(num) and num + factor
            or 0 exp = string.match(tostring(num), '%.(.*)') and string.match(tostring(num), '%.(.*)'):sub(1, tonumber(exp)) or '0'
            num = string.match(tostring(num), '(.*)%.') or tostring(num) return tonumber(num .. '.' .. exp) end
        end, function(t1, t2)
            for k, v in pairs(t2) do if (type(v) == 'table') and (type(t1[k] or false) == 'table')
            then merge(t1[k], t2[k]) else t1[k] = v end end return t1
        end

        GET_GLOBAL_TABLE = function()
            return {
                sendLaunchAnalytics = _G.sendLaunchAnalytics, transition = _G.transition, tostring = _G.tostring,
                tonumber = _G.tonumber, gcinfo = _G.gcinfo, assert = _G.assert, debug = _G.debug, GAME = _G.GAME,
                io = _G.io, os = _G.os, display = _G.display, load = _G.load, module = _G.module, media = _G.media,
                native = _G.native, coroutine = _G.coroutine, CENTER_X = _G.CENTER_X, CENTER_Y = _G.CENTER_Y, ipairs = _G.ipairs,
                TOP_HEIGHT = _G.TOP_HEIGHT, network = _G.network, LFS = _G.lfs, _network_pathForFile = _G._network_pathForFile,
                pcall = _G.pcall, BUILD = _G.BUILD, MAX_Y = _G.MAX_Y, MAX_X = _G.MAX_X, string = _G.string,
                xpcall = _G.xpcall, ZERO_Y = _G.ZERO_Y, ZERO_X = _G.ZERO_X, package = _G.package, print = _G.print,
                table = _G.table, lpeg = _G.lpeg, COPY_TABLE = _G.COPY_TABLE, DISPLAY_HEIGHT = _G.DISPLAY_HEIGHT,
                unpack = _G.unpack, require = _G.require, setmetatable = _G.setmetatable, next = _G.next,
                RIGHT_HEIGHT = _G.RIGHT_HEIGHT, graphics = _G.graphics, system = _G.system, rawequal = _G.rawequal,
                timer = _G.timer, BOTTOM_HEIGHT = _G.BOTTOM_HEIGHT, newproxy = _G.newproxy, metatable = _G.metatable,
                al = _G.al, rawset = _G.rawset, easing = _G.easing, coronabaselib = _G.coronabaselib, math = _G.math,
                LEFT_HEIGHT = _G.LEFT_HEIGHT, cloneArray = _G.cloneArray, DISPLAY_WIDTH = _G.DISPLAY_WIDTH, type = _G.type,
                audio = _G.audio, pairs = _G.pairs, select = _G.select, rawget = _G.rawget, Runtime = _G.Runtime,
                collectgarbage = _G.collectgarbage, getmetatable = _G.getmetatable, error = _G.error
            }
        end
    end getGlobal()

    local function getDevice()
        local M = {}

        M['device_id'] = function()
            return DEVICE_ID
        end

        M['width_screen'] = function()
            return DISPLAY_WIDTH
        end

        M['height_screen'] = function()
            return DISPLAY_HEIGHT
        end

        M['top_point_screen'] = function()
            return DISPLAY_HEIGHT / 2
        end

        M['bottom_point_screen'] = function()
            return -DISPLAY_HEIGHT / 2
        end

        M['right_point_screen'] = function()
            return DISPLAY_WIDTH / 2
        end

        M['left_point_screen'] = function()
            return -DISPLAY_WIDTH / 2
        end

        M['height_top'] = function()
            return TOP_HEIGHT == 0 and display.topStatusBarContentHeight or TOP_HEIGHT
        end

        M['height_bottom'] = function()
            local _, _, bottom_height = display.getSafeAreaInsets()
            return bottom_height
        end

        M['finger_touching_screen'] = function()
            return GAME.group.const.touch
        end

        M['finger_touching_screen_x'] = function()
            return GAME.group.const.touch_x - CENTER_X
        end

        M['finger_touching_screen_y'] = function()
            return CENTER_Y - GAME.group.const.touch_y
        end

        M['fps'] = function()
            return M.FPS
        end

        M.start = function()
            M.FPS, M._FPS = 60, 0 timer.performWithDelay(0, function() M._FPS = M._FPS + 1 end, 0)
            timer.performWithDelay(1000, function() M.FPS, M._FPS = M._FPS > 60 and 60 or M._FPS, 0 end, 0)
        end

        return M
    end

    local function getFun()
        local M = {}

        M['get_text'] = function(name)
            local isComplete, result = pcall(function()
                return GAME.group.texts[name or '0'] and GAME.group.texts[name or '0'].text or ''
            end) return isComplete and result or ''
        end

        M['read_save'] = function(key)
            local isComplete, result = pcall(function()
                return GET_GAME_SAVE(CURRENT_LINK)[tostring(key)]
            end) return isComplete and result or nil
        end

        M['random_str'] = function(...)
            local args = {...}

            local isComplete, result = pcall(function()
                if #args > 0 then
                    return args[math.random(1, #args)]
                else
                    return nil
                end
            end) return isComplete and result or ''
        end

        M['concat'] = function(...)
            local args, str = {...}, ''

            local isComplete, result = pcall(function()
                for i = 1, #args do
                    str = str .. args[i]
                end

                return str
            end) return isComplete and result or ''
        end

        M['tonumber'] = function(str)
            local isComplete, result = pcall(function()
                return tonumber(str) or 0
            end) return isComplete and result or 0
        end

        M['tostring'] = function(any)
            return tostring(any)
        end

        M['totable'] = function(str)
            return JSON.decode(str)
        end

        M['len_table'] = function(t)
            return table.len(t)
        end

        M['encode'] = function(t, prettify)
            local isComplete, result = pcall(function()
                return JSON[prettify and 'prettify' or 'encode'](t)
            end) return isComplete and result or '{}'
        end

        M['gsub'] = function(str, pattern, replace, n)
            local isComplete, result = pcall(function()
                return UTF8.gsub(str, pattern, replace, n)
            end) return isComplete and result or str
        end

        M['sub'] = function(str, i, j)
            local isComplete, result = pcall(function()
                return UTF8.sub(str, i, j)
            end) return isComplete and result or str
        end

        M['len'] = function(str)
            local isComplete, result = pcall(function()
                return UTF8.len(str)
            end) return isComplete and result or 0
        end

        M['find'] = function(str, pattern, i, plain)
            local isComplete, result = pcall(function()
                return UTF8.find(str, pattern, i, plain)
            end) return isComplete and result or str
        end

        M['split'] = function(str, sep)
            local isComplete, result = pcall(function()
                return UTF8.split(str, sep)
            end) return isComplete and result or {}
        end

        M['match'] = function(str, pattern, i)
            local isComplete, result = pcall(function()
                return UTF8.match(str, pattern, i)
            end) return isComplete and result or str
        end

        M['get_ip'] = function(any)
            local isComplete, result = pcall(function()
                return SERVER.getIP()
            end) return isComplete and result or nil
        end

        M['color_pixel'] = function(x, y)
            local isComplete, result = pcall(function()
                local x = x or 0
                local y = y or 0
                local colors = {0, 0, 0, 0}

                if coroutine.status(GAME.CO) ~= 'running' then
                    display.colorSample(CENTER_X + x, CENTER_Y - y, function(e)
                        colors = {math.round(e.r * 255), math.round(e.g * 255), math.round(e.b * 255), math.round(e.a * 255)}
                    end)
                end

                return colors
            end) return isComplete and result or {0, 0, 0, 0}
        end

        M['unix_time'] = function()
            return os.time()
        end

        return M
    end

    local function getMath()
        local M = {}

        local sin = math.sin
        local cos = math.cos
        local tan = math.tan
        local asin = math.asin
        local acos = math.acos
        local atan = math.atan
        local atan2 = math.atan2

        M.getMaskBits = math.getMaskBits
        M.randomseed = math.randomseed
        M.factorial = math.factorial
        M.random = math.random
        M.getBit = math.getBit
        M.radical = math.sqrt
        M.log10 = math.log10
        M.round = math.round
        M.module = math.abs
        M.power = math.pow
        M.log0 = math.log
        M.hex = math.hex
        M.exp = math.exp
        M.sum = math.sum
        M.max = math.max
        M.min = math.min
        M.pi = math.pi

        M['remainder'] = function(num, count)
            local isComplete, result = pcall(function()
                return num % count
            end) return isComplete and result or 0
        end

        M['asin'] = function(num)
            local isComplete, result = pcall(function()
                return asin(num) * 180 / M.pi
            end) return isComplete and result or 0
        end

        M['acos'] = function(num)
            local isComplete, result = pcall(function()
                return acos(num) * 180 / M.pi
            end) return isComplete and result or 0
        end

        M['atan'] = function(num)
            local isComplete, result = pcall(function()
                return atan(num) * 180 / M.pi
            end) return isComplete and result or 0
        end

        M['atan2'] = function(y, x)
            local isComplete, result = pcall(function()
                return atan2(y, x) * 180 / M.pi
            end) return isComplete and result or 0
        end

        M['sin'] = function(num)
            local isComplete, result = pcall(function()
                return tonumber(string.format('%.4f', sin(num * M.pi / 180)))
            end) return isComplete and result or 0
        end

        M['cos'] = function(num)
            local isComplete, result = pcall(function()
                return tonumber(string.format('%.4f', cos(num * M.pi / 180)))
            end) return isComplete and result or 0
        end

        M['tan'] = function(num)
            local isComplete, result = pcall(function()
                return tonumber(string.format('%.4f', tan(num * M.pi / 180)))
            end) return isComplete and result or 0
        end

        M['ctan'] = function(num)
            local isComplete, result = pcall(function()
                return tonumber(string.format('%.4f', 1 / tan(num * M.pi / 180)))
            end) return isComplete and result or 0
        end

        return M
    end

    local function getProp()
        local M = {}

        if 'Объект' then
            M['obj.touch'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name]._touch or false
                end) return isComplete and result
            end

            M['obj.var'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name]._data or {}
                end) return isComplete and result or {}
            end

            M['obj.tag'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name]._tag or ''
                end) return isComplete and result or ''
            end

            M['obj.pos_x'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name].x - CENTER_X or 0
                end) return isComplete and result or 0
            end

            M['obj.pos_y'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and 0 - GAME.group.objects[name].y + CENTER_Y or 0
                end) return isComplete and result or 0
            end

            M['obj.width'] = function(name)
                local isComplete, result = pcall(function()
                    return (GAME.group.objects[name] and GAME.group.objects[name]._radius)
                    and (GAME.group.objects[name].path.radius or 0) or (GAME.group.objects[name] and GAME.group.objects[name].width or 0)
                end) return isComplete and result or 0
            end

            M['obj.height'] = function(name)
                local isComplete, result = pcall(function()
                    return (GAME.group.objects[name] and GAME.group.objects[name]._radius)
                    and (GAME.group.objects[name].path.radius or 0) or (GAME.group.objects[name] and GAME.group.objects[name].height or 0)
                end) return isComplete and result or 0
            end

            M['obj.rotation'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name].rotation or 0
                end) return isComplete and result or 0
            end

            M['obj.alpha'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name].alpha * 100 or 100
                end) return isComplete and result or 100
            end

            M['obj.name_texture'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name] and GAME.group.objects[name]._name or ''
                end) return isComplete and result or ''
            end

            M['obj.velocity_x'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name]._body ~= '' and select(1, GAME.group.objects[name]:getLinearVelocity()) or 0
                end) return isComplete and result or 0
            end

            M['obj.velocity_y'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name]._body ~= '' and 0 - select(2, GAME.group.objects[name]:getLinearVelocity()) or 0
                end) return isComplete and result or 0
            end

            M['obj.angular_velocity'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.objects[name]._body ~= '' and GAME.group.objects[name].angularVelocity or 0
                end) return isComplete and result or 0
            end
        end

        if 'Текст' then
            M['text.tag'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name]._tag or ''
                end) return isComplete and result or ''
            end

            M['text.pos_x'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name].x - CENTER_X or 0
                end) return isComplete and result or 0
            end

            M['text.pos_y'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and 0 - GAME.group.texts[name].y + CENTER_Y or 0
                end) return isComplete and result or 0
            end

            M['text.width'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name].width or 0
                end) return isComplete and result or 0
            end

            M['text.height'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name].height or 0
                end) return isComplete and result or 0
            end

            M['text.rotation'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name].rotation or 0
                end) return isComplete and result or 0
            end

            M['text.alpha'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.texts[name] and GAME.group.texts[name].alpha * 100 or 100
                end) return isComplete and result or 100
            end
        end

        if 'Группа' then
            M['group.tag'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name]._tag or ''
                end) return isComplete and result or ''
            end

            M['group.pos_x'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name].x or 0
                end) return isComplete and result or 0
            end

            M['group.pos_y'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and 0 - GAME.group.groups[name].y or 0
                end) return isComplete and result or 0
            end

            M['group.width'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name].width or 0
                end) return isComplete and result or 0
            end

            M['group.height'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name].height or 0
                end) return isComplete and result or 0
            end

            M['group.rotation'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name].rotation or 0
                end) return isComplete and result or 0
            end

            M['group.alpha'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.groups[name] and GAME.group.groups[name].alpha * 100 or 100
                end) return isComplete and result or 100
            end
        end

        if 'Виджет' then
            M['widget.tag'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and GAME.group.widgets[name]._tag or ''
                end) return isComplete and result or ''
            end

            M['widget.pos_x'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and GAME.group.widgets[name].x - CENTER_X or 0
                end) return isComplete and result or 0
            end

            M['widget.pos_y'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and 0 - GAME.group.widgets[name].y + CENTER_Y or 0
                end) return isComplete and result or 0
            end

            M['widget.value'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'slider' and GAME.group.widgets[name].value or 0) or 50
                end) return isComplete and result or 50
            end

            M['widget.text'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'field' and GAME.group.widgets[name].text or '') or ''
                end) return isComplete and result or ''
            end

            M['widget.link'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'webview' and GAME.group.widgets[name].url or '') or ''
                end) return isComplete and result or ''
            end
        end

        if 'Медиа' then
            M['media.current_time'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.media[name] and GAME.group.media[name].currentTime or 0
                end) return isComplete and result or 0
            end

            M['media.total_time'] = function(name)
                local isComplete, result = pcall(function()
                    return GAME.group.media[name] and GAME.group.media[name].totalTime or 0
                end) return isComplete and result or 0
            end

            M['media.sound_volume'] = function(name)
                local isComplete, result = pcall(function()
                    return audio.getVolume((GAME.group.media[name] and GAME.group.media[name][2]) and {channel=GAME.group.media[name][2]} or nil)
                end) return isComplete and result or 0
            end

            M['media.sound_total_time'] = function(name)
                local isComplete, result = pcall(function()
                    return (GAME.group.media[name] and GAME.group.media[name][1]) and audio.getDuration(GAME.group.media[name][1]) or 0
                end) return isComplete and result or 0
            end

            M['media.sound_pause'] = function(name)
                local isComplete, result = pcall(function()
                    return (GAME.group.media[name] and GAME.group.media[name][2]) and audio.isChannelPaused(GAME.group.media[name][2]) or nil
                end) return isComplete and result or nil
            end

            M['media.sound_play'] = function(name)
                local isComplete, result = pcall(function()
                    return (GAME.group.media[name] and GAME.group.media[name][2]) and audio.isChannelPlaying(GAME.group.media[name][2]) or nil
                end) return isComplete and result or nil
            end
        end

        return M
    end

    local function getSelect()
        local M = {}

        M['dynamic'] = function()
            return 'dynamic'
        end

        M['static'] = function()
            return 'static'
        end

        M['forward'] = function()
            return 'forward'
        end

        M['bounce'] = function()
            return 'bounce'
        end

        M['backgroundTrue'] = function()
            return true
        end

        M['backgroundFalse'] = function()
            return false
        end

        M['ruleTrue'] = function()
            return true
        end

        M['ruleFalse'] = function()
            return false
        end

        M['alignLeft'] = function()
            return 'left'
        end

        M['alignRight'] = function()
            return 'right'
        end

        M['alignCenter'] = function()
            return 'center'
        end

        M['inputDefault'] = function()
            return 'default'
        end

        M['inputNumber'] = function()
            return 'number'
        end

        M['inputDecimal'] = function()
            return 'decimal'
        end

        M['inputPhone'] = function()
            return 'phone'
        end

        M['inputUrl'] = function()
            return 'url'
        end

        M['inputEmail'] = function()
            return 'email'
        end

        M['inputNoEmoji'] = function()
            return 'noemoji'
        end

        M['obj'] = function()
            return 'objects'
        end

        M['text'] = function()
            return 'texts'
        end

        M['group'] = function()
            return 'groups'
        end

        M['widget'] = function()
            return 'widgets'
        end

        M['tag'] = function()
            return 'tags'
        end

        return M
    end

    local function getOther()
        local M = {}

        M.getBitmapTexture = function(link, name)
            local data, width, height = IMPACK.image.load(link, system.DocumentsDirectory, {req_comp = 3})
            local x, y, size = 1, 1, width * height

            GAME.group.bitmaps[name] = BITMAP.newTexture({width = width, height = height})

            for i = 1, size do
                local args = {data:byte(i * 3 - 2, i * 3)}
                GAME.group.bitmaps[name]:setPixel(x, y, args[1] / 255, args[2] / 255, args[3] / 255, 1)
                x = x == width and 1 or x + 1
                y = x == 1 and y + 1 or y
            end

            GAME.group.bitmaps[name]:invalidate()
        end

        M.getPhysicsParams = function(friction, bounce, density, hitbox, filter)
            local params = {friction = friction, bounce = bounce, density = density}

            if filter[1] and filter[2] then
                params.filter = {
                    categoryBits = math.getBit(filter[1]),
                    maskBits = math.getMaskBits(filter[2])
                }
            end

            if hitbox.type == 'box' then
                params.box = {
                    halfWidth = hitbox.halfWidth, halfHeight = hitbox.halfHeight,
                    x = hitbox.offsetX, y = hitbox.offsetY, angle = hitbox.rotation
                }
            elseif hitbox.type == 'circle' then
                params.radius = hitbox.radius
            elseif hitbox.type == 'mesh' then
                params.outline = hitbox.outline
            elseif hitbox.type == 'polygon' then
                params.shape = hitbox.shape
            end

            return params
        end

        M.getSound = function(link)
            for i = 1, #GAME.RESOURCES.sounds do
                if GAME.RESOURCES.sounds[i][1] == link then
                    return CURRENT_LINK .. '/Sounds/' .. GAME.RESOURCES.sounds[i][2]
                end
            end
        end

        M.getVideo = function(link)
            for i = 1, #GAME.RESOURCES.videos do
                if GAME.RESOURCES.videos[i][1] == link then
                    return CURRENT_LINK .. '/Videos/' .. GAME.RESOURCES.videos[i][2]
                end
            end
        end

        M.getImage = function(link)
            for i = 1, #GAME.RESOURCES.images do
                if GAME.RESOURCES.images[i][1] == link then
                    return CURRENT_LINK .. '/Images/' .. GAME.RESOURCES.images[i][3], GAME.RESOURCES.images[i][2] or 'nearest'
                end
            end
        end

        M.getFont = function(font)
            for i = 1, #GAME.RESOURCES.fonts do
                if GAME.RESOURCES.fonts[i][1] == font then
                    if CURRENT_LINK ~= 'App' then
                        local new_font = io.open(DOC_DIR .. '/' .. CURRENT_LINK .. '/Fonts/' .. GAME.RESOURCES.fonts[i][2], 'rb')
                        local main_font = io.open(RES_PATH .. '/' .. GAME.RESOURCES.fonts[i][2], 'wb')

                        if new_font and main_font then
                            main_font:write(new_font:read('*a'))
                            io.close(main_font)
                            io.close(new_font)
                        end
                    end

                    return GAME.RESOURCES.fonts[i][2]
                end
            end

            return font
        end

        return M
    end

    local fun, device, other, select, math, prop = getFun(), getDevice(), getOther(), getSelect(), getMath(), getProp()
]])
