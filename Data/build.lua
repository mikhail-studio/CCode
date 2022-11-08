return ' ' .. UTF8.trimFull([[
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

        COPY_TABLE_FP = function(t)
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

        WIDGET.setTheme('widget_theme_android_holo_dark')
        display.setStatusBar(display.HiddenStatusBar) math.randomseed(os.time())
        math.factorial = function(num) if num == 0 then return 1 else return num * math.factorial(num - 1) end end
        math.hex = function(hex) local r, g, b = hex:match('(..)(..)(..)') return {tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)} end
        UTF8.trim = function(s) return UTF8.gsub(UTF8.gsub(s, '^%s+', ''), '%s+$', '') end
        UTF8.trimLeft = function(s) return UTF8.gsub(s, '^%s+', '') end
        UTF8.trimRight = function(s) return UTF8.gsub(s, '%s+$', '') end
        UTF8.trimFull = function(s) return UTF8.trim(UTF8.gsub(s, '%s+', ' ')) end
        timer.new = function(sec, rep, lis) return timer.performWithDelay(sec, lis, rep) end
        math.sum = function(...) local args, num = {...}, 0 for i = 1, #args do num = num + args[i] end return num end
        math.round = function(num, exp)
            if not exp then
                return tonumber(string.match(tostring(num), '(.*)%.')) or num
            else
                if not tonumber(num) then return 0 end if not tonumber(exp) then exp = 0 end
                return tonumber(string.format('%.' .. exp .. 'f', tonumber(num)))
            end
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
                collectgarbage = _G.collectgarbage, getmetatable = _G.getmetatable, error = _G.error, MAIN = _G.MAIN
            }
        end
    end getGlobal()

    local function getDevice()
        local M = {}

        M['device_id'] = function()
            return system.getInfo('deviceID')
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
            return TOP_HEIGHT
        end

        M['height_bottom'] = function()
            return BOTTOM_HEIGHT
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
            return GAME.group.texts[name or '0'] and GAME.group.texts[name or '0'].text or 'nil'
        end

        M['read_save'] = function(key)
            return GET_GAME_SAVE(CURRENT_LINK)[tostring(key)]
        end

        M['random_str'] = function(...)
            local args = {...}

            if #args > 0 then
                return args[math.random(1, #args)]
            else
                return 'nil'
            end
        end

        M['concat'] = function(...)
            local args, str = {...}, ''

            for i = 1, #args do
                str = str .. args[i]
            end

            return str
        end

        M['tonumber'] = function(str)
            return tonumber(str) or 0
        end

        M['tostring'] = function(any)
            return tostring(any)
        end

        M['totable'] = function(str)
            return JSON.decode(str)
        end

        M['encode'] = function(t, prettify)
            return JSON[prettify and 'prettify' or 'encode'](t)
        end

        M['gsub'] = function(str, pattern, replace, n)
            return UTF8.gsub(str, pattern, replace, n)
        end

        M['sub'] = function(str, i, j)
            return UTF8.sub(str, i, j)
        end

        M['len'] = function(str)
            return UTF8.len(str)
        end

        M['find'] = function(str, pattern, i, plain)
            return UTF8.find(str, pattern, i, plain)
        end

        M['match'] = function(str, pattern, i)
            return UTF8.match(str, pattern, i)
        end

        M['color_pixel'] = function(x, y)
            local x = x or 0
            local y = y or 0
            local colors = {0, 0, 0, 0}

            if coroutine.status(GAME.CO) ~= 'running' then
                display.colorSample(CENTER_X + x, CENTER_Y - y, function(e)
                    colors = {math.round(e.r * 255), math.round(e.g * 255), math.round(e.b * 255), math.round(e.a * 255)}
                end)
            end

            return colors
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

        M.randomseed = math.randomseed
        M.factorial = math.factorial
        M.random = math.random
        M.radical = math.sqrt
        M.log10 = math.log10
        M.module = math.abs
        M.power = math.pow
        M.exp = math.exp
        M.sum = math.sum
        M.log = math.log
        M.max = math.max
        M.min = math.min
        M.pi = math.pi

        M['round'] = function(num, count)
            return tonumber(string.format('%.' .. (count or '0') .. 'f', tostring(num))) or num
        end

        M['remainder'] = function(num, count)
            return num % count
        end

        M['asin'] = function(num)
            return asin(num * M.pi / 180)
        end

        M['acos'] = function(num)
            return acos(num * M.pi / 180)
        end

        M['atan'] = function(num)
            return atan(num * M.pi / 180)
        end

        M['atan2'] = function(num)
            return atan2(num * M.pi / 180)
        end

        M['sin'] = function(num)
            return sin(num * M.pi / 180)
        end

        M['cos'] = function(num)
            return cos(num * M.pi / 180)
        end

        M['tan'] = function(num)
            return tan(num * M.pi / 180)
        end

        M['ctan'] = function(num)
            return 1 / tan(num * M.pi / 180)
        end

        return M
    end

    local function getProp()
        local M = {}

        M['touch'] = function(name)
            return GAME.group.objects[name]._touch
        end

        M['tag'] = function(name)
            return GAME.group.objects[name]._tag
        end

        M['pos_x'] = function(name)
            return select(1, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
        end

        M['pos_y'] = function(name)
            return 0 - select(2, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
        end

        M['width'] = function(name)
            return GAME.group.objects[name]._radius and GAME.group.objects[name].radius or GAME.group.objects[name].width
        end

        M['height'] = function(name)
            return GAME.group.objects[name]._radius and GAME.group.objects[name].radius or GAME.group.objects[name].height
        end

        M['rotation'] = function(name)
            return GAME.group.objects[name].rotation
        end

        M['alpha'] = function(name)
            return GAME.group.objects[name].alpha * 100
        end

        M['name_texture'] = function(name)
            return GAME.group.objects[name]._name
        end

        M['velocity_x'] = function(name)
            return GAME.group.objects[name]._body ~= '' and select(1, GAME.group.objects[name]:getLinearVelocity()) or 0
        end

        M['velocity_y'] = function(name)
            return GAME.group.objects[name]._body ~= '' and 0 - select(2, GAME.group.objects[name]:getLinearVelocity()) or 0
        end

        M['angular_velocity'] = function(name)
            return GAME.group.objects[name]._body ~= '' and GAME.group.objects[name].angularVelocity or 0
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

                GAME.group.bitmaps[name]:setPixel(x, y,
                        args[1] / 255,
                        args[2] / 255,
                        args[3] / 255
                    )

                x = x == width and 1 or x + 1
                y = x == 1 and y + 1 or y
            end

            GAME.group.bitmaps[name]:invalidate()
        end

        M.getPhysicsParams = function(friction, bounce, density, hitbox)
            local params = {friction = friction, bounce = bounce, density = density}

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
