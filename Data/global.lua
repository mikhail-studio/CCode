LANG, STR, MAIN = {}, {}, display.newGroup()

RESIZE = require 'Core.Modules.app-resize'
INPUT = require 'Core.Modules.interface-input'
WINDOW = require 'Core.Modules.interface-window'
EXITS = require 'Core.Interfaces.exits'
FILE = require 'plugin.cnkFileManager'
EXPORT = require 'plugin.exportFile'
ORIENTATION = require 'plugin.orientation'
ADMOB = require 'plugin.admob'
SVG = require 'plugin.nanosvg'
UTF8 = require 'plugin.utf8'
ZIP = require 'plugin.zip'
JSON = require 'json'
LFS = require 'lfs'
WIDGET = require 'widget'
CRYPTO = require 'crypto'

LOCAL = require 'Data.local'
LANG.en = require 'Strings.en'
LANG.ru = require 'Strings.ru'
LANGS = {'en', 'ru'}

for i = 1, #LANGS do
    if LANGS[i] == LOCAL.lang then
        break
    elseif i == #LANGS then
        LOCAL.lang = 'en'
    end
end

if system.getInfo('deviceID') == '7274f48c57dc5cec' then
    display.safeActualContentHeight = display.actualContentHeight - 90
end

BUILD = 1147
ALERT = true
CENTER_Z = 0
TOP_WIDTH = 0
INDEX_LIST = 0
MORE_LIST = true
ADMOB_HEIGHT = 0
LAST_CHECKBOX = 0
ORIENTATION.init()
CURRENT_SCRIPT = 0
GAME_GROUP_OPEN = ''
CURRENT_LINK = 'App1'
STR = LANG[LOCAL.lang]
CURRENT_ORIENTATION = 'portrait'
CENTER_X = display.contentCenterX
CENTER_Y = display.contentCenterY
DISPLAY_WIDTH = display.actualContentWidth
DISPLAY_HEIGHT = display.actualContentHeight
DOC_DIR = system.pathForFile('', system.DocumentsDirectory)
MY_PATH = '/data/data/' .. tostring(system.getInfo('androidAppPackageName')) .. '/files/ganin'
RES_PATH = '/data/data/' .. tostring(system.getInfo('androidAppPackageName')) .. '/files/coronaResources'
TOP_HEIGHT = system.getInfo 'environment' ~= 'simulator' and display.topStatusBarContentHeight or 0
BOTTOM_HEIGHT = DISPLAY_HEIGHT - display.safeActualContentHeight
BOTTOM_WIDTH = DISPLAY_WIDTH - display.safeActualContentWidth
ZERO_X = CENTER_X - DISPLAY_WIDTH / 2
ZERO_Y = CENTER_Y - DISPLAY_HEIGHT / 2 + TOP_HEIGHT
MAX_X = CENTER_X + DISPLAY_WIDTH / 2
MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT

pcall(function()
    if system.getInfo 'environment' ~= 'simulator' then
        require('Core.Share.build').reset()
        GANIN = require 'plugin.ganin'
    end
end)

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

NEW_DATA = function()
    local file = io.open(system.pathForFile('local.json', system.DocumentsDirectory), 'w')
    file:write(JSON.encode(LOCAL))
    io.close(file)
end

GET_GAME_CODE = function(link)
    local path = DOC_DIR .. '/' .. link .. '/game.json'
    local file, data = io.open(path, 'r'), {}

    if file then
        data = JSON.decode(file:read('*a'))
        io.close(file)
    end

    return data
end

SET_GAME_CODE = function(link, data)
    local path = DOC_DIR .. '/' .. link .. '/game.json'
    local file = io.open(path, 'w')

    if file then
        file:write(JSON.encode(data))
        io.close(file)
    end
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

OS_REMOVE = function(link, recur)
    if system.getInfo 'environment' == 'simulator' then
        link = UTF8.gsub(link, '/', '\\')
        if recur then os.execute('rd /s /q "' .. link .. '"')
        else os.execute('del /q "' .. link .. '"') end
    else
        os.execute('rm -' .. (recur and 'rf' or 'f') .. ' "' .. link .. '"')
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

OS_COPY = function(link, link2)
    if system.getInfo 'environment' == 'simulator' then
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
    if event.phase == 'init' then
        ADMOB.load('banner', {adUnitId='ca-app-pub-3712284233366817/8879724699', childSafe = true})
    elseif event.phase == 'loaded' and event.type == 'banner' and LOCAL.show_ads then
        ADMOB.show('banner', {bgColor = '#0f0f11', y = LOCAL.pos_top_ads and 'top' or 'bottom'})
    elseif event.phase == 'displayed' or event.phase == 'hidden' then
        -- ADMOB_HEIGHT = event.phase == 'hidden' and 0 or ADMOB.height() / 2
        -- setOrientationApp({type = CURRENT_ORIENTATION})
    end
end

WIDGET.setTheme('widget_theme_android_holo_dark')
display.setDefault('background', 0.15, 0.15, 0.17)
display.setStatusBar(display.HiddenStatusBar)
DEVELOPERS = JSON.decode(READ_FILE(system.pathForFile('Emitter/developers.json')))
math.round = function(num) return tonumber(string.match(tostring(num), '(.*)%.')) or num end
math.hex = function(hex) local r, g, b = hex:match('(..)(..)(..)') return {tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)} end
UTF8.trim = function(s) return UTF8.gsub(UTF8.gsub(s, '^%s+', ''), '%s+$', '') end
UTF8.trimLeft = function(s) return UTF8.gsub(s, '^%s+', '') end
UTF8.trimRight = function(s) return UTF8.gsub(s, '%s+$', '') end
timer.new = function(sec, rep, lis) return timer.performWithDelay(sec, lis, rep) end
if system.getInfo 'environment' == 'simulator' then JSON.encode, JSON.encode2 = JSON.prettify, JSON.encode
else ADMOB.init(adListener, {appId="ca-app-pub-3712284233366817~8085200542", testMode = true}) end
if LOCAL.orientation == 'landscape' then setOrientationApp({type = 'landscape'}) end
-- Runtime:addEventListener('unhandledError', function(event) return true end)

GET_GLOBAL_TABLE = function()
    return {
        sendLaunchAnalytics = _G.sendLaunchAnalytics, transition = _G.transition, tostring = _G.tostring,
        tonumber = _G.tonumber, gcinfo = _G.gcinfo, assert = _G.assert, debug = _G.debug, GAME = _G.GAME,
        io = _G.io, os = _G.os, display = _G.display, load = _G.load, module = _G.module, media = _G.media,
        native = _G.native, coroutine = _G.coroutine, CENTER_X = _G.CENTER_X, CENTER_Y = _G.CENTER_Y, CENTER_Z = _G.CENTER_Z,
        TOP_HEIGHT = _G.TOP_HEIGHT, network = _G.network, LFS = _G.lfs, _network_pathForFile = _G._network_pathForFile,
        pcall = _G.pcall, BUILD = _G.BUILD, MAX_Y = _G.MAX_Y, MAX_X = _G.MAX_X, string = _G.string,
        xpcall = _G.xpcall, ZERO_Y = _G.ZERO_Y, ZERO_X = _G.ZERO_X, package = _G.package, print = _G.print,
        table = _G.table, lpeg = _G.lpeg, COPY_TABLE = _G.COPY_TABLE, DISPLAY_HEIGHT = _G.DISPLAY_HEIGHT,
        unpack = _G.unpack, require = _G.require, setmetatable = _G.setmetatable, next = _G.next,
        graphics = _G.graphics, ipairs = _G.ipairs, system = _G.system, rawequal = _G.rawequal,
        timer = _G.timer, BOTTOM_HEIGHT = _G.BOTTOM_HEIGHT, newproxy = _G.newproxy, metatable = _G.metatable,
        al = _G.al, rawset = _G.rawset, easing = _G.easing, coronabaselib = _G.coronabaselib, math = _G.math,
        BOTTOM_WIDTH = _G.BOTTOM_WIDTH, cloneArray = _G.cloneArray, DISPLAY_WIDTH = _G.DISPLAY_WIDTH, type = _G.type,
        audio = _G.audio, pairs = _G.pairs, select = _G.select, rawget = _G.rawget, Runtime = _G.Runtime,
        collectgarbage = _G.collectgarbage, getmetatable = _G.getmetatable, error = _G.error, MAIN = _G.MAIN
    }
end
