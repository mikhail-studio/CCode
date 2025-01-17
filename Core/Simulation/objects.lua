local CALC = require 'Core.Simulation.calc'
local M = {}

M['cloneObject'] = function(params)
end

M['newObject'] = function(params, isLevel)
    local name = CALC(params[1])
    local link = #params == 3 and name or CALC(params[2])
    local posX = '(SET_X(' .. CALC(#params == 3 and params[2] or params[3]) .. '))'
    local posY = '(SET_Y(' .. CALC(#params == 3 and params[3] or params[4]) .. '))'

    if isLevel then
        name = 'object.name'
        link = '{CURRENT_LINK .. \'/Images/\' .. object.type[2], object.type[3]}'
        posX = '(SET_X(object.x))'
        posY = '(SET_Y(object.y))'
    end

    GAME.lua = GAME.lua .. '\n pcall(function() local _link = ' .. link .. ' local name = ' .. (#params == 3 and '_link' or name)
    GAME.lua = GAME.lua .. '\n local link, filter if _G.type(_link) == \'table\' then link, filter = _link[1], _link[2]'
    GAME.lua = GAME.lua .. '\n else link, filter = other.getImage(_link) end pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:removeSelf() GAME_objects[name] = nil end)'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n local image, sheetParams = display.newImage(link, system.DocumentsDirectory), {link, system.DocumentsDirectory}'
    GAME.lua = GAME.lua .. '\n if filter == \'vector\' then local index = #GAME.group.textures + 1'
    GAME.lua = GAME.lua .. '\n GAME.group.textures[index] = SVG.newTexture({filename = link, baseDir = system.DocumentsDirectory})'
    GAME.lua = GAME.lua .. '\n sheetParams = {GAME.group.textures[index].filename, GAME.group.textures[index].baseDir}'
    GAME.lua = GAME.lua .. '\n local imageSheet = graphics.newImageSheet(sheetParams[1], sheetParams[2],'
    GAME.lua = GAME.lua .. '\n {width = image.width, height = image.height, numFrames = 1}) image:removeSelf() image = nil'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newSprite(GAME.group, imageSheet, {name = \'\', frames = {1}})'
    GAME.lua = GAME.lua .. '\n else image:removeSelf() image = nil'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newImage(GAME.group, link, system.DocumentsDirectory) end'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].x, GAME_objects[name].y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = link GAME_objects[name]._name = _link'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'

    if isLevel then
        GAME.lua = GAME.lua .. '\n pcall(function() local obj = GAME_objects[object.name]'
        GAME.lua = GAME.lua .. '\n obj.width = object.width obj.height = object.height'
        GAME.lua = GAME.lua .. '\n obj.rotation = object.rotation obj._density = object.density'
        GAME.lua = GAME.lua .. '\n obj._friction = object.friction obj._gravity = object.gravity'
        GAME.lua = GAME.lua .. '\n obj._bounce = object.bounce obj.isSensor = object.isSensor'
        GAME.lua = GAME.lua .. '\n obj.isFixedRotation = object.isFixedRotation obj._body = object.body if object.body ~= \'\' then'
        require('Core.Simulation.events').BLOCKS['setBody']({}, true) GAME.lua = GAME.lua .. '\n end end)'
    end
end

M['newSprite'] = function(params)
    local name, link = CALC(params[1]), CALC(params[2])
    local width, height = CALC(params[3]), CALC(params[4])
    local count, animations = CALC(params[5]), CALC(params[6], '{}')
    local posX = '(SET_X(' .. CALC(params[7]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[8]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local _link, name, count = ' .. link .. ', ' .. name .. ', ' .. count
    GAME.lua = GAME.lua .. '\n local link, filter = other.getImage(_link) local animations = {}'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]:removeSelf() GAME_objects[name] = nil end)'
    GAME.lua = GAME.lua .. '\n pcall(function() local anims = ' .. animations
    GAME.lua = GAME.lua .. '\n if type(anims) ~= \'table\' then animations = GAME_animations[anims]'
    GAME.lua = GAME.lua .. '\n elseif #anims == 0 then animations = {name = \'\', start = 1, count = count}'
    GAME.lua = GAME.lua .. '\n elseif #anims == 1 then animations = GAME_animations[anims[1]]'
    GAME.lua = GAME.lua .. '\n else for _, v in ipairs(anims) do table.insert(animations, GAME_animations[v]) end end'
    GAME.lua = GAME.lua .. '\n if not animations or IS_ZERO_TABLE(animations) then animations = {name = \'\', start = 1, count = count} end end)'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n local sheetParams = {link, system.DocumentsDirectory}'
    GAME.lua = GAME.lua .. '\n if filter == \'vector\' then local index = #GAME.group.textures + 1'
    GAME.lua = GAME.lua .. '\n GAME.group.textures[index] = SVG.newTexture({filename = link, baseDir = system.DocumentsDirectory})'
    GAME.lua = GAME.lua .. '\n sheetParams = {GAME.group.textures[index].filename, GAME.group.textures[index].baseDir} end'
    GAME.lua = GAME.lua .. '\n local imageSheet = graphics.newImageSheet(sheetParams[1], sheetParams[2],'
    GAME.lua = GAME.lua .. '\n {width = ' .. width .. ', height = ' .. height .. ', numFrames = count})'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newSprite(GAME.group, imageSheet, animations)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].x, GAME_objects[name].y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = link GAME_objects[name]._name = _link'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['newGif'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])
    local posX = '(SET_X(' .. CALC(params[3]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local _link = ' .. link .. ' local name = ' .. name
    GAME.lua = GAME.lua .. '\n local link, filter = other.getImage(_link) local width, height, count ='
    GAME.lua = GAME.lua .. '\n GANIN.convert(DOC_DIR .. \'/\' .. link, system.pathForFile(\'gif.png\', system.TemporaryDirectory))'
    GAME.lua = GAME.lua .. '\n width, height, count = unpack(GET_SIZE(link, system.TemporaryDirectory, width, height, count))'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]:removeSelf() GAME_objects[name] = nil end)'
    GAME.lua = GAME.lua .. '\n local animations = {name = \'\', start = 1, count = count}'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n local imageSheet = graphics.newImageSheet(\'gif.png\', system.TemporaryDirectory,'
    GAME.lua = GAME.lua .. '\n {width = width, height = height, numFrames = count})'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newSprite(GAME.group, imageSheet, animations)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].x, GAME_objects[name].y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = link GAME_objects[name]._name = _link'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.TemporaryDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['setPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(SET_X(' .. CALC(params[2]) .. ', GAME_objects[name]))'
    local posY = '(SET_Y(' .. CALC(params[3]) .. ', GAME_objects[name]))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].x = ' .. posX
    GAME.lua = GAME.lua .. '\n GAME_objects[name].y = ' .. posY .. ' end)'
end

M['setPosX'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' GAME_objects[name].x ='
    GAME.lua = GAME.lua .. '\n SET_X(' .. CALC(params[2]) .. ', GAME_objects[name]) end)'
end

M['setPosY'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' GAME_objects[name].y ='
    GAME.lua = GAME.lua .. '\n SET_Y(' .. CALC(params[2]) .. ', GAME_objects[name]) end)'
end

M['setWidth'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' if GAME_objects[name]._radius then'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].path.radius = ' .. width .. ' else'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].width = ' .. width .. ' end end)'
end

M['setHeight'] = function(params)
    local name = CALC(params[1])
    local height = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' if GAME_objects[name]._radius then'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].path.radius = ' .. height .. ' else'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].height = ' .. height .. ' end end)'
end

M['setSize'] = function(params)
    local name = CALC(params[1])
    local size = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() local name, size = ' .. name .. ', ' .. size .. ' if GAME_objects[name]._radius then'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].path.radius = GAME_objects[name]._radius * size'
    GAME.lua = GAME.lua .. '\n else GAME_objects[name].width = GAME_objects[name]._width * size'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].height = GAME_objects[name]._height * size'
    GAME.lua = GAME.lua .. '\n end GAME_objects[name]._size = size end)'
end

M['setRotation'] = function(params)
    local name = CALC(params[1])
    local rotation = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. name .. '].rotation = ' .. rotation .. ' end)'
end

M['setRotationTo'] = function(params)
    local name1 = CALC(params[1])
    local name2 = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local obj1, obj2 = GAME_objects[' .. name1 .. '], GAME_objects[' .. name2 .. ']'
    GAME.lua = GAME.lua .. '\n obj1.rotation = math.atan2(obj2.y - obj1.y, obj2.x - obj1.x) end)'
end

M['setAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. name .. '].alpha = ' .. alpha .. ' end)'
end

M['setAnchor'] = function(params)
    local name = CALC(params[1])
    local anchorX = CALC(params[2], '50') .. '/ 100'
    local anchorY = CALC(params[3], '50') .. '/ 100'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].anchorX = ' .. anchorX
    GAME.lua = GAME.lua .. '\n GAME_objects[name].anchorY = ' .. anchorY .. ' end)'
end

M['updPosX'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].x ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].x + ' .. posX .. ' end)'
end

M['updPosY'] = function(params)
    local name = CALC(params[1])
    local posY = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].y ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].y - ' .. posY .. ' end)'
end

M['updSize'] = function(params)
    local name = CALC(params[1])
    local size = '((' .. CALC(params[2]) .. ') / 100 + GAME_objects[name]._size)'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local size = ' .. size .. ' if GAME_objects[name]._radius'
    GAME.lua = GAME.lua .. '\n then GAME_objects[name].path.radius = GAME_objects[name]._radius * size'
    GAME.lua = GAME.lua .. '\n else GAME_objects[name].width = GAME_objects[name]._width * size'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].height = GAME_objects[name]._height * size'
    GAME.lua = GAME.lua .. '\n end GAME_objects[name]._size = size end)'
end

M['updRotation'] = function(params)
    local name = CALC(params[1])
    local rotation = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].rotation ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].rotation + ' .. rotation .. ' end)'
end

M['updAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].alpha ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].alpha + ' .. alpha .. ' end)'
end

M['updWidth'] = function(params)
    local name = CALC(params[1])
    local width = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].width ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].width + ' .. width .. ' end)'
end

M['updHeight'] = function(params)
    local name = CALC(params[1])
    local height = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].height ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].height + ' .. height .. ' end)'
end

M['hideObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isVisible = false end)'
end

M['showObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isVisible = true end)'
end

M['removeObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:removeSelf() GAME_objects[name] = nil end)'
end

M['frontObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. ']:toFront() end)'
end

M['backObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. ']:toBack() end)'
end

return M
