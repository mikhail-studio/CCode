LANG, STR = {}, {}

PARTICLE = require 'Emitter.particleDesigner'
RESIZE = require 'Core.Modules.app-resize'
INPUT = require 'Core.Modules.interface-input'
WINDOW = require 'Core.Modules.interface-window'
EXITS = require 'Core.Interfaces.exits'
BITMAP = require 'plugin.memoryBitmap'
FILE = require 'plugin.cnkFileManager'
EXPORT = require 'plugin.exportFile'
PASTEBOARD = require 'plugin.pasteboard'
ORIENTATION = require 'plugin.orientation'
-- ADMOB = require 'plugin.admob'
IMPACK = require 'plugin.impack'
SVG = require 'plugin.nanosvg'
UTF8 = require 'plugin.utf8'
ZIP = require 'plugin.zip'
PHYSICS = require 'physics'
JSON = require 'json'
LFS = require 'lfs'
WIDGET = require 'widget'
CRYPTO = require 'crypto'

SIZE = 1.0
LIVE = false
BUILD = 1188
ALERT = true
INDEX_LIST = 0
MORE_LIST = true
ADMOB_HEIGHT = 0
LAST_CHECKBOX = 0
ORIENTATION.init()
CURRENT_SCRIPT = 0
GAME_GROUP_OPEN = ''
CURRENT_LINK = 'App1'
LAST_CURRENT_SCRIPT = 0
DEVICE_ID = 'qwertyuiop12345'
CURRENT_ORIENTATION = 'portrait'
CENTER_X = display.contentCenterX
CENTER_Y = display.contentCenterY
DISPLAY_WIDTH = display.actualContentWidth
DISPLAY_HEIGHT = display.actualContentHeight
IS_WIN = system.getInfo 'platform' ~= 'android'
IS_SIM = system.getInfo 'environment' == 'simulator'
DOC_DIR = system.pathForFile('', system.DocumentsDirectory)
MY_PATH = '/data/data/' .. tostring(system.getInfo('androidAppPackageName')) .. '/files/ganin'
RES_PATH = '/data/data/' .. tostring(system.getInfo('androidAppPackageName')) .. '/files/coronaResources'
TOP_HEIGHT, LEFT_HEIGHT, BOTTOM_HEIGHT, RIGHT_HEIGHT = display.getSafeAreaInsets()
ZERO_X = CENTER_X - DISPLAY_WIDTH / 2 + LEFT_HEIGHT
ZERO_Y = CENTER_Y - DISPLAY_HEIGHT / 2 + TOP_HEIGHT
MAX_X = CENTER_X + DISPLAY_WIDTH / 2 - RIGHT_HEIGHT
MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT
MASK = graphics.newMask('Sprites/mask.png')
SOLAR = _G.B .. _G.D .. _G.A .. _G.C
KEYORDER = {
    'build', 'version', 'package', 'orientation', 'title', 'link', 'resources', 'scripts',
    'settings', 'fonts', 'videos', 'sounds', 'images', 'funs', 'tables', 'len',
    'vars', 'name', 'custom', 'event', 'nested', 'comment', 'params'
} for i = 10000, 1, -1 do table.insert(KEYORDER, 1, tostring(i)) end

pcall(function()
    if IS_SIM or IS_WIN then
        FILEPICKER = require 'plugin.tinyfiledialogs'

        FILE.pickFile = function(path, listener, file, p1, mime)
            local filter_patterns = mime == 'image/*' and {'*.png', '*.jpg', '*.jpeg'} or mime == 'audio/*' and {'*.wav', '*.mp3', '*.ogg'}
            or mime == 'ccode/*' and {'*.ccode', '*.zip'} or mime == 'text/x-lua' and {'*.lua', '*.txt'}
            or mime == 'video/*' and {'*.mov', '*.mp4', '*.m4v', '*.3gp'} or nil
            local pathToFile, path = path .. '/' .. file, FILEPICKER.openFileDialog({filter_patterns = filter_patterns})
            if path then OS_COPY(path, pathToFile) end listener({done = path and 'ok' or 'error'})
        end

        EXPORT.export = function(config)
            local path, listener, name = config.path, config.listener, config.name
            local pathToFile = FILEPICKER.saveFileDialog({filter_patterns = {'*.ccode'}})
            if path then OS_COPY(path, pathToFile) end listener()
        end
    end
end)

pcall(function()
    if not IS_SIM then
        require('Core.Share.build').reset()
        GANIN = require 'plugin.ganin'
    end
end)

GET_NESTED_DATA = function(data, nestedInfo, INFO)
    local data = COPY_TABLE(data)

    for i = #nestedInfo, 1, -1 do
        local current_params = nestedInfo[i][1]
        local current_script = nestedInfo[i][2]

        if data.scripts[current_script].params[current_params].event then
            local fixIndex = current_params + 1

            for j = fixIndex, #data.scripts[current_script].params do
                if data.scripts[current_script].params[fixIndex].event then break end
                table.insert(data.scripts[current_script].params[current_params].nested, data.scripts[current_script].params[fixIndex])
                table.remove(data.scripts[current_script].params, fixIndex)
            end
        elseif INFO.listNested[data.scripts[current_script].params[current_params].name] then
            local endIndex = #INFO.listNested[data.scripts[current_script].params[current_params].name]
            local fixIndex = current_params + 1
            local nestedEndIndex = 1

            for j = fixIndex, #data.scripts[current_script].params do
                if not data.scripts[current_script].params[fixIndex].event then
                    local name = data.scripts[current_script].params[fixIndex].name
                    local notNested = not (data.scripts[current_script].params[fixIndex].nested
                    and #data.scripts[current_script].params[fixIndex].nested > 0)
                    table.insert(data.scripts[current_script].params[current_params].nested, data.scripts[current_script].params[fixIndex])
                    table.remove(data.scripts[current_script].params, fixIndex)

                    if name == data.scripts[current_script].params[current_params].name and notNested then
                        nestedEndIndex = nestedEndIndex + 1
                    elseif name == INFO.listNested[data.scripts[current_script].params[current_params].name][endIndex] then
                        nestedEndIndex = nestedEndIndex - 1
                        if nestedEndIndex == 0 then break end
                    end
                else
                    fixIndex = fixIndex + 1
                end
            end
        end
    end

    return data
end

GET_FULL_DATA = function(data)
    local data, nestedInfo = COPY_TABLE(data), {}

    for i = 1, #data.scripts do
        local blockIndex = 0

        while blockIndex < #data.scripts[i].params do
            blockIndex = blockIndex + 1

            if data.scripts[i].params[blockIndex].nested and #data.scripts[i].params[blockIndex].nested > 0 then
                table.insert(nestedInfo, {blockIndex, i})

                for j = 1, #data.scripts[i].params[blockIndex].nested do
                    local blockIndex, blockData = blockIndex + j, data.scripts[i].params[blockIndex].nested[j]
                    table.insert(data.scripts[i].params, blockIndex, blockData)
                end

                data.scripts[i].params[blockIndex].nested = {}
            end
        end
    end

    return data, nestedInfo
end

GET_SCROLL_HEIGHT = function(group)
    if not (group and #group.blocks > 0) then return 0 end

    local b1 = group.blocks[1].y - group.blocks[1].block.height / 2
    local b2 = group.blocks[#group.blocks].y + group.blocks[#group.blocks].block.height / 2

    return math.abs(b1 - b2) + 100
end

READ_FILE = function(path, bin)
    local file, data = io.open(path, bin and 'rb' or 'r'), nil

    if file then
        data = file:read('*a')
        io.close(file)
    end

    return data
end

WRITE_FILE = function(path, data, bin)
    local file = io.open(path, bin and 'wb' or 'w')

    if file then
        file:write(tostring(data))
        io.close(file)
    end
end

IS_IMAGE = function(path)
    local test_image = display.newImage(path, system.DocumentsDirectory, 10000, 10000)
    local is_image = test_image and test_image.width and test_image.height

    pcall(function() test_image:removeSelf() end) test_image = nil

    return is_image
end

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
            if type(value) == 'table' and key ~= '_class' then
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

NEW_DATA = function()
    WRITE_FILE(system.pathForFile('local.json', system.DocumentsDirectory), JSON.encode(LOCAL))
end

GET_GAME_CODE = function(link)
    return JSON.decode(READ_FILE(DOC_DIR .. '/' .. link .. '/game.json'))
end

SET_GAME_CODE = function(link, data)
    WRITE_FILE(DOC_DIR .. '/' .. link .. '/game.json', JSON.encode3(data, {keyorder = KEYORDER}))
end

GET_GAME_CUSTOM = function()
    return JSON.decode(READ_FILE(DOC_DIR .. '/custom.json'))
end

SET_GAME_CUSTOM = function(data)
    WRITE_FILE(DOC_DIR .. '/custom.json', JSON.encode3(data, {keyorder = KEYORDER}))
end

GET_GAME_SAVE = function(link)
    return JSON.decode(READ_FILE(DOC_DIR .. '/' .. link .. '/save.json'))
end

SET_GAME_SAVE = function(link, data)
    WRITE_FILE(DOC_DIR .. '/' .. link .. '/save.json', JSON.encode(data))
end

OS_REMOVE = function(link, recur)
    if IS_SIM or IS_WIN then
        link = UTF8.gsub(link, '/', '\\')
        if recur then os.execute('rd /s /q "' .. link .. '"')
        else os.execute('del /q "' .. link .. '"') end
    else
        os.execute('rm -' .. (recur and 'rf' or 'f') .. ' "' .. link .. '"')
    end
end

OS_MOVE = function(link, link2)
    if IS_SIM or IS_WIN then
        link = UTF8.gsub(link, '/', '\\')
        link2 = UTF8.gsub(link2, '/', '\\')
        os.execute('move /y "' .. link .. '" "' .. link2 .. '"')
    else
        os.execute('mv -f "' .. link .. '" "' .. link2 .. '"')
    end
end

OS_COPY = function(link, link2)
    if IS_SIM or IS_WIN then
        link = UTF8.gsub(link, '/', '\\')
        link2 = UTF8.gsub(link2, '/', '\\')
        os.execute('copy /y "' .. link .. '" "' .. link2 .. '"')
    else
        os.execute('cp -f "' .. link .. '" "' .. link2 .. '"')
    end
end

NEW_APP_CODE = function(title, link)
    return {
        build = tostring(BUILD),
        title = title,
        link = link,
        tables = {},
        vars = {},
        funs = {},
        settings = {
            build = 1,
            version = '1.0',
            package = 'com.example.app',
            orientation = 'portrait'
        },
        resources = {
            images = {},
            sounds = {},
            videos = {},
            fonts = {}
        },
        scripts = {}
    }
end

local function adListener(event)
    if event.phase == 'init' and LOCAL.show_ads then
        -- ADMOB.load('banner', {adUnitId='ca-app-pub-3712284233366817/8879724699', childSafe = true})
    elseif event.phase == 'loaded' and event.type == 'banner' and LOCAL.show_ads then
        -- ADMOB.show('banner', {bgColor = '#0f0f11', y = LOCAL.pos_top_ads and 'top' or 'bottom'})
    elseif event.phase == 'displayed' or event.phase == 'hidden' then
        -- ADMOB_HEIGHT = event.phase == 'hidden' and 0 or ADMOB.height() / 2
        -- setOrientationApp({type = CURRENT_ORIENTATION})
    end
end

WIDGET.setTheme('widget_theme_android_holo_dark')
display.setDefault('background', 0.15, 0.15, 0.17)
display.setStatusBar(display.HiddenStatusBar) math.randomseed(os.time())
DEVELOPERS = {['Ganin'] = true, ['Danil Nik'] = true, ['Terra'] = true}

JSON.encode3 = require('Data.json').encode
JSON.decode2, JSON.decode = JSON.decode, function(str) return type(str) == 'string' and JSON.decode2(str) or nil end
math.factorial = function(num) if num == 0 then return 1 else return num * math.factorial(num - 1) end end
math.hex = function(hex) local r, g, b = hex:match('(..)(..)(..)') return {tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)} end
UTF8.trim = function(s) return UTF8.gsub(UTF8.gsub(s, '^%s+', ''), '%s+$', '') end
UTF8.trimLeft = function(s) return UTF8.gsub(s, '^%s+', '') end
UTF8.trimRight = function(s) return UTF8.gsub(s, '%s+$', '') end
UTF8.trimFull = function(s) return UTF8.trim(UTF8.gsub(s, '%s+', ' ')) end
timer.new = function(sec, rep, lis) return timer.performWithDelay(sec, lis, rep) end
math.sum = function(...) local args, num = {...}, 0 for i = 1, #args do num = num + args[i] end return num end
table.len, math.round, table.merge = function(t)
    return type(t) == 'table' and ((type(#t) == 'number' and #t > 0) and #t
    or (function() local i = 0 for k in pairs(t) do i = i + 1 end return i end)()) or 0
end, function(num, exp)
    if not exp then return tonumber(string.match(tostring(num), '(.*)%.')) or num
    else local exps = string.match(tostring(num), '%.(.*)') num = tonumber(num) and num + 0.5 or 0
    num = string.match(tostring(num), '(.*)%.') or tostring(num) exp = (exps and tonumber(exp) and tonumber(exp) > 0)
    and exps:sub(1, tonumber(exp)) or '0' return tonumber(num .. '.' .. exp) end
end, function(t1, t2)
    for k, v in pairs(t2) do if (type(v) == 'table') and (type(t1[k] or false) == 'table')
    then merge(t1[k], t2[k]) else t1[k] = v end end return t1
end

LOCAL = require 'Data.local'
LANG.en = require 'Strings.en'
LANG.ru = require 'Strings.ru'
LANGS = {'en', 'ru'}

for i = 1, #LANGS do if LANGS[i] == LOCAL.lang then break elseif i == #LANGS then LOCAL.lang = 'en' end end
STR = LANG[LOCAL.lang] for k, v in pairs(LANG.ru) do if not STR[k] then STR[k] = v end end

if IS_SIM then
    JSON.encode, JSON.encode2, JSON.encode4 = JSON.prettify, JSON.encode, JSON.encode3
    JSON.encode3 = function(s, opt) local opt = opt or {} opt.indent = opt.indent == nil and true or opt.indent return JSON.encode4(s, opt) end
else
    -- ADMOB.init(adListener, {appId="ca-app-pub-3712284233366817~8085200542", testMode = true})
end

require('Core.Modules.custom-block').getBlocks()
if LOCAL.orientation == 'landscape' then setOrientationApp({type = 'landscape'}) end
-- Runtime:addEventListener('unhandledError', function(event) return true end)

GET_GLOBAL_TABLE = function()
    return {
        sendLaunchAnalytics = sendLaunchAnalytics, transition = transition, tostring = tostring, tonumber = tonumber,
        gcinfo = gcinfo, assert = assert, debug = debug, GAME = GAME, collectgarbage = collectgarbage,
        io = io, os = os, display = display, dofile = dofile, module = module, media = media, OS_REMOVE = OS_REMOVE,
        native = native, coroutine = coroutine, CENTER_X = CENTER_X, CENTER_Y = CENTER_Y, ipairs = ipairs,
        TOP_HEIGHT = TOP_HEIGHT, network = network, LFS = lfs, _network_pathForFile = _network_pathForFile,
        pcall = pcall, BUILD = BUILD, MAX_Y = MAX_Y, MAX_X = MAX_X, string = string, SIZE = SIZE, READ_FILE = READ_FILE,
        xpcall = xpcall, ZERO_Y = ZERO_Y, ZERO_X = ZERO_X, package = package, print = print, OS_MOVE = OS_MOVE,
        table = table, lpeg = lpeg, COPY_TABLE = COPY_TABLE, DISPLAY_HEIGHT = DISPLAY_HEIGHT, OS_COPY = OS_COPY,
        unpack = unpack, require = require, setmetatable = setmetatable, next = next, RIGHT_HEIGHT = RIGHT_HEIGHT,
        graphics = graphics, system = system, rawequal = rawequal,  getmetatable = getmetatable, WRITE_FILE = WRITE_FILE,
        timer = timer, BOTTOM_HEIGHT = BOTTOM_HEIGHT, newproxy = newproxy, metatable = metatable,
        al = al, rawset = rawset, easing = easing, coronabaselib = coronabaselib, math = math, DOC_DIR = DOC_DIR,
        LEFT_HEIGHT = LEFT_HEIGHT, cloneArray = cloneArray, DISPLAY_WIDTH = DISPLAY_WIDTH, type = type,
        audio = audio, pairs = pairs, select = select, rawget = rawget, Runtime = Runtime, error = error
    }
end
