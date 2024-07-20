local EVENTS = require 'Core.Simulation.events'
local CALC = require 'Core.Simulation.calc'
local M = {}

M['newGifNoob'] = function(params)
    local name = CALC(params[1])
    local time = '(' .. CALC(params[2], '0') .. ') * 1000'
    local posX = '(SET_X(' .. CALC(params[3]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local _link = ' .. name .. ' local name = _link'
    GAME.lua = GAME.lua .. ' local link, filter = other.getImage(_link) local width, height, count ='
    GAME.lua = GAME.lua .. ' GANIN.convert(DOC_DIR .. \'/\' .. link, system.pathForFile(\'gif.png\', system.TemporaryDirectory))'
    GAME.lua = GAME.lua .. ' width, height, count = unpack(GET_SIZE(link, system.TemporaryDirectory, width, height, count))'
    GAME.lua = GAME.lua .. ' pcall(function() GAME_objects[name]:removeSelf() GAME_objects[name] = nil end)'
    GAME.lua = GAME.lua .. ' local animations = {name = \'\', start = 1, count = count, time = ' .. time .. '}'
    GAME.lua = GAME.lua .. ' display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. ' display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. ' local imageSheet = graphics.newImageSheet(\'gif.png\', system.TemporaryDirectory,'
    GAME.lua = GAME.lua .. ' {width = width, height = height, numFrames = count})'
    GAME.lua = GAME.lua .. ' GAME_objects[name] = display.newSprite(GAME.group, imageSheet, animations)'
    GAME.lua = GAME.lua .. ' GAME_objects[name].x, GAME_objects[name].y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. ' GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._link = link GAME_objects[name]._name = _link'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.TemporaryDirectory'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._listeners = {} GAME_objects[name]._gif = true GAME_objects[name]:play()'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['setSizeNoob'] = function(params)
    local name = CALC(params[1])
    local size = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() local name, size = ' .. name .. ', ' .. size .. ' if GAME_objects[name]._radius then'
    GAME.lua = GAME.lua .. ' GAME_objects[name].path.radius = GAME_objects[name]._radius * size elseif'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._gif then GAME_objects[name].xScale = size GAME_objects[name].yScale = size'
    GAME.lua = GAME.lua .. ' else GAME_objects[name].width = GAME_objects[name]._width * size'
    GAME.lua = GAME.lua .. ' GAME_objects[name].height = GAME_objects[name]._height * size'
    GAME.lua = GAME.lua .. ' end GAME_objects[name]._size = size end)'
end

M['updSizeNoob'] = function(params)
    local name = CALC(params[1])
    local size = '((' .. CALC(params[2]) .. ') / 100 + GAME_objects[name]._size)'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local size = ' .. size .. ' if GAME_objects[name]._radius'
    GAME.lua = GAME.lua .. ' then GAME_objects[name].path.radius = GAME_objects[name]._radius * size elseif'
    GAME.lua = GAME.lua .. ' GAME_objects[name]._gif then GAME_objects[name].xScale = size GAME_objects[name].yScale = size'
    GAME.lua = GAME.lua .. ' else GAME_objects[name].width = GAME_objects[name]._width * size'
    GAME.lua = GAME.lua .. ' GAME_objects[name].height = GAME_objects[name]._height * size'
    GAME.lua = GAME.lua .. ' end GAME_objects[name]._size = size end)'
end

M['newObjectNoob'] = EVENTS.BLOCKS['newObject']
M['setPosNoob'] = EVENTS.BLOCKS['setPos']
M['setPosXNoob'] = EVENTS.BLOCKS['setPosX']
M['setPosYNoob'] = EVENTS.BLOCKS['setPosY']
M['setWidthNoob'] = EVENTS.BLOCKS['setWidth']
M['setHeightNoob'] = EVENTS.BLOCKS['setHeight']
M['setRotationNoob'] = EVENTS.BLOCKS['setRotation']
M['setRotationToNoob'] = EVENTS.BLOCKS['setRotationTo']
M['setAlphaNoob'] = EVENTS.BLOCKS['setAlpha']
M['updPosXNoob'] = EVENTS.BLOCKS['updPosX']
M['updPosYNoob'] = EVENTS.BLOCKS['updPosY']
M['updRotationNoob'] = EVENTS.BLOCKS['updRotation']
M['updAlphaNoob'] = EVENTS.BLOCKS['updAlpha']
M['updWidthNoob'] = EVENTS.BLOCKS['updWidth']
M['updHeightNoob'] = EVENTS.BLOCKS['updHeight']

return M
