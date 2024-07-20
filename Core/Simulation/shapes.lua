local CALC = require 'Core.Simulation.calc'
local M = {}

M['setSprite'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local _link, name = ' .. link .. ', ' .. name
    GAME.lua = GAME.lua .. '\n local link, filter = other.getImage(_link)'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n local image = {} pcall(function() image = display.newImage(tostring(link), system.DocumentsDirectory) end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]._width = image.width or 0 end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]._height = image.height or 0 end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]._link = tostring(link) end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]._baseDir = system.DocumentsDirectory end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]._name = _link end)'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name].fill = {type = \'image\', filename = tostring(link),'
    GAME.lua = GAME.lua .. '\n baseDir = system.DocumentsDirectory} end) image:removeSelf() image = nil end)'
end

M['newRect'] = function(params)
    local name, colors = CALC(params[1]), CALC(params[2], '{255, 255, 255}')
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(SET_X(' .. CALC(params[5]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local colors, name = ' .. colors .. ', ' .. name
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newRect(GAME.group, ' .. posX .. ', ' .. posY .. ', '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = \'\' GAME_objects[name]._name = \'SHAPE\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['newRoundedRect'] = function(params)
    local name, radius = CALC(params[1]), CALC(params[2])
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(SET_X(' .. CALC(params[5]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_objects[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newRoundedRect(GAME.group, ' .. posX .. ', ' .. posY .. ', '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ', ' .. radius .. ')'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = \'\' GAME_objects[name]._name = \'SHAPE\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['newCircle'] = function(params)
    local name, radius = CALC(params[1]), CALC(params[2])
    local posX = '(SET_X(' .. CALC(params[3]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_objects[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newCircle(GAME.group, ' .. posX .. ', ' .. posY .. ', ' .. radius .. ')'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._radius = GAME_objects[name].path.radius'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = \'\' GAME_objects[name]._name = \'SHAPE\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['newPolygon'] = function(params)
    local name, coords = CALC(params[1]), CALC(params[2], '{0,110,27,35,105,35,43,-16,65,-90,0,-45,-65,-90,-43,-15,-105,35,-27,35}')
    local posX = '(SET_X(' .. CALC(params[3]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local coords, name = COPY_TABLE(' .. coords .. '), ' .. name .. ' for i = 1, #coords do'
    GAME.lua = GAME.lua .. '\n if i % 2 == 0 then coords[i] = -coords[i] end end pcall(function() GAME_objects[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newPolygon(GAME.group, ' .. posX .. ', ' .. posY .. ', coords)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = \'\' GAME_objects[name]._name = \'SHAPE\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['newLine'] = function(params)
    local name, colors = CALC(params[1]), CALC(params[2], '{255, 255, 255}')
    local posX1 = '(SET_X(' .. CALC(params[3], '0') .. '))'
    local posY1 = '(SET_Y(' .. CALC(params[4], '200') .. '))'
    local posX2 = '(SET_X(' .. CALC(params[5], '0') .. '))'
    local posY2 = '(SET_Y(' .. CALC(params[6], '-200') .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local x1, y1, x2, y2 = ' .. posX1 .. ', ' .. posY1 .. ', ' .. posX2 .. ', ' .. posY2
    GAME.lua = GAME.lua .. '\n local name = ' .. name .. ' pcall(function() GAME_objects[name]:removeSelf() end) local colors = ' .. colors
    GAME.lua = GAME.lua .. '\n GAME_objects[name] = display.newLine(GAME.group, x1, y1, x2, y2) pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:setStrokeColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].strokeWidth = 5'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = GAME_objects[name].strokeWidth'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = GAME_objects[name].strokeWidth'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._density = 1 GAME_objects[name]._bounce = 0'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = 0 GAME_objects[name]._gravity = 1'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = \'\' GAME_objects[name]._hitbox = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = \'\' GAME_objects[name]._name = \'SHAPE\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._touch = false GAME_objects[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._data = {} GAME_objects[name]._baseDir = system.DocumentsDirectory'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._listeners = {}'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._size, GAME_objects[name].name = 1, name end)'
end

M['appendLine'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local coords = COPY_TABLE(' .. CALC(params[2], '{}') .. ') for i = 1, #coords do if i % 2 == 0'
    GAME.lua = GAME.lua .. '\n then coords[i] = SET_Y(coords[i]) else coords[i] = SET_X(coords[i]) end end'
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. CALC(params[1]) ..  ']:append(unpack(coords)) end)'
end

M['setColor'] = function(params)
    local name = CALC(params[1])
    local colors = CALC(params[2], '{255, 255, 255}')

    GAME.lua = GAME.lua .. '\n pcall(function() local colors = ' .. colors
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
end

M['setRGB'] = function(params)
    local name = CALC(params[1])
    local r, g, b = CALC(params[2], '255'), CALC(params[3], '255'), CALC(params[4], '255')

    GAME.lua = GAME.lua .. '\n pcall(function() local r, g, b = ' .. r .. '/255, ' .. g .. '/255, ' .. b .. '/255'
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. name .. ']:setFillColor(r, g, b) end)'
end

M['setHEX'] = function(params)
    local name = CALC(params[1])
    local hex = CALC(params[2], '\'FFFFFF\'')

    GAME.lua = GAME.lua .. '\n pcall(function() local hex = UTF8.trim(tostring(' .. hex .. '))'
    GAME.lua = GAME.lua .. '\n if UTF8.sub(hex, 1, 1) == \'#\' then hex = UTF8.sub(hex, 2, 7) end'
    GAME.lua = GAME.lua .. '\n if UTF8.len(hex) ~= 6 then hex = \'FFFFFF\' end local errorHex = false'
    GAME.lua = GAME.lua .. '\n local filterHex = {\'0\', \'1\', \'2\', \'3\', \'4\', \'5\', \'6\','
    GAME.lua = GAME.lua .. '\n \'7\', \'8\', \'9\', \'A\', \'B\', \'C\', \'D\', \'E\', \'F\'}'
    GAME.lua = GAME.lua .. '\n for indexHex = 1, 6 do local symHex = UTF8.upper(UTF8.sub(hex, indexHex, indexHex))'
    GAME.lua = GAME.lua .. '\n for i = 1, #filterHex do if symHex == filterHex[i] then break elseif i == #filterHex then errorHex = true end end'
    GAME.lua = GAME.lua .. '\n end if errorHex then hex = \'FFFFFF\' end local r, g, b = unpack(math.hex(hex))'
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. name .. ']:setFillColor(r/255, g/255, b/255) end)'
end

M['newBitmap'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', \'nearest\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', \'nearest\')'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_bitmaps[' .. name .. '] ='
    GAME.lua = GAME.lua .. '\n BITMAP.newTexture({width = ' .. width .. ', height = ' .. height .. '}) end)'
end

M['setPixel'] = function(params)
    local name, colors, posX = CALC(params[1]), CALC(params[4], '{255, 255, 255}'), CALC(params[2])
    local posY = 'GAME_bitmaps[name].height + 1 - ' .. CALC(params[3])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local colors = ' .. colors .. ' GAME_bitmaps[name]:setPixel('
    GAME.lua = GAME.lua .. posX .. ', ' .. posY .. ', colors[1]/255, colors[2]/255, colors[3]/255, 1) end)'
end

M['setPixelRGB'] = function(params)
    local name, posX = CALC(params[1]), CALC(params[2])
    local posY = 'GAME_bitmaps[name].height + 1 - ' .. CALC(params[3])
    local r, g, b = CALC(params[4], '255'), CALC(params[5], '255'), CALC(params[6], '255')

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_bitmaps[name]:setPixel('
    GAME.lua = GAME.lua .. posX .. ', ' .. posY .. ', ' .. r .. '/255, ' .. g .. '/255, ' .. b .. '/255, 1) end)'
end

M['removePixel'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_bitmaps[name]:setPixel(' .. CALC(params[2]) .. ','
    GAME.lua = GAME.lua .. '\n GAME_bitmaps[name].height + 1 - ' .. CALC(params[3]) .. ', 0, 0, 0, 0) end)'
end

M['updBitmap'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_bitmaps[' .. CALC(params[1]) .. ']:invalidate() end)'
end

M['setBitmapSprite'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local _link, name = ' .. link .. ', ' .. name
    GAME.lua = GAME.lua .. '\n local image = display.newImage(GAME_bitmaps[_link].filename,'
    GAME.lua = GAME.lua .. '\n GAME_bitmaps[_link].baseDir, 10000, 10000)'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._width = image.width'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._height = image.height'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._link = GAME_bitmaps[_link].filename'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._baseDir = GAME_bitmaps[_link].baseDir'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]._name = _link'
    GAME.lua = GAME.lua .. '\n GAME_objects[name].fill = {type = \'image\','
    GAME.lua = GAME.lua .. '\n filename = GAME_bitmaps[_link].filename,'
    GAME.lua = GAME.lua .. '\n baseDir = GAME_bitmaps[_link].baseDir} image:removeSelf() image = nil end)'
end

M['getBitmapSprite'] = function(params)
    local link, name = CALC(params[1]), CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local link, filter = other.getImage(' .. link .. ')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter or \'nearest\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter or \'nearest\')'
    GAME.lua = GAME.lua .. '\n other.getBitmapTexture(link, ' .. name .. ') end)'
end

M['setGradientPaint'] = function(params)
    local name = CALC(params[1])
    local colors1, colors2 = CALC(params[2], '{255, 255, 255}'), CALC(params[3], '{255, 255, 255}')
    local alpha1, alpha2 = CALC(params[4], '100'), CALC(params[5], '100')

    GAME.lua = GAME.lua .. '\n pcall(function() local colors1, colors2 = ' .. colors1 .. ', ' .. colors2
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. name .. '].fill = {type = \'gradient\','
    GAME.lua = GAME.lua .. '\n color1 = {colors1[1]/255, colors1[2]/255, colors1[3]/255, ' .. alpha1 .. '/100},'
    GAME.lua = GAME.lua .. '\n color2 = {colors2[1]/255, colors2[2]/255, colors2[3]/255, ' .. alpha2 .. '/100}} end)'
end

M['setLinearGradient'] = function(params)
    local name = CALC(params[1])
    local angle = '(' .. CALC(params[2], '0') .. ' * -1)'
    local colorD = '(not ' .. CALC(params[3], 'true') .. ')'
    local colors1, colors2 = CALC(params[4], '{255, 255, 255}'), CALC(params[5], '{255, 255, 255}')

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local object = GAME_objects[name]'
    GAME.lua = GAME.lua .. '\n object._effect = \'generator.linearGradient\' object.fill.effect = \'generator.linearGradient\''
    GAME.lua = GAME.lua .. '\n if ' .. colorD .. ' then object:setFillColor(1, 1, 1) end'
    GAME.lua = GAME.lua .. '\n local colors1, colors2 = ' .. colors1 .. ', ' .. colors2
    GAME.lua = GAME.lua .. '\n local pos1 = {(_G.math.sin(_G.math.rad(' .. angle .. ')) + 1) / 2,'
    GAME.lua = GAME.lua .. '\n (_G.math.cos(_G.math.rad(' .. angle .. ')) + 1) / 2}'
    GAME.lua = GAME.lua .. '\n local pos2 = {(_G.math.sin(_G.math.rad(' .. angle .. ' - 180)) + 1) / 2,'
    GAME.lua = GAME.lua .. '\n (_G.math.cos(_G.math.rad(' .. angle .. ' - 180)) + 1) / 2}'
    GAME.lua = GAME.lua .. '\n object.fill.effect.color1 = {colors1[1]/255, colors1[2]/255, colors1[3]/255, ' .. CALC(params[6]) .. '/100}'
    GAME.lua = GAME.lua .. '\n object.fill.effect.color2 = {colors2[1]/255, colors2[2]/255, colors2[3]/255, ' .. CALC(params[7]) .. '/100}'
    GAME.lua = GAME.lua .. '\n object.fill.effect.position1 = pos1 object.fill.effect.position2 = pos2 end)'
end

M['setRadialGradient'] = function(params)
    local name = CALC(params[1])
    local ratio = CALC(params[2])
    local colorD = '(not ' .. CALC(params[3], 'true') .. ')'
    local colors1, colors2 = CALC(params[4], '{255, 255, 255}'), CALC(params[5], '{255, 255, 255}')
    local center_and_radiuses = '{' .. CALC(params[6]) .. ' / 100, 1 - ' .. CALC(params[7]) .. ' / 100, ' .. CALC(params[8])
    local center_and_radiuses = center_and_radiuses .. '/ 100, ' .. CALC(params[9]) .. ' / 100}'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local object = GAME_objects[name]'
    GAME.lua = GAME.lua .. '\n object._effect = \'generator.radialGradient\' object.fill.effect = \'generator.radialGradient\''
    GAME.lua = GAME.lua .. '\n if ' .. colorD .. ' then object:setFillColor(1, 1, 1) end'
    GAME.lua = GAME.lua .. '\n local colors1, colors2 = ' .. colors1 .. ', ' .. colors2
    GAME.lua = GAME.lua .. '\n object.fill.effect.color1 = {colors1[1]/255, colors1[2]/255, colors1[3]/255, ' .. CALC(params[10]) .. '/100}'
    GAME.lua = GAME.lua .. '\n object.fill.effect.color2 = {colors2[1]/255, colors2[2]/255, colors2[3]/255, ' .. CALC(params[11]) .. '/100}'
    GAME.lua = GAME.lua .. '\n object.fill.effect.center_and_radiuses = ' .. center_and_radiuses
    GAME.lua = GAME.lua .. '\n object.fill.effect.aspectRatio = ' .. ratio .. ' end)'
end

M['setStrokeWidth'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].strokeWidth =' .. CALC(params[2]) .. ' end)'
end

M['updStrokeWidth'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' GAME_objects[name].strokeWidth ='
    GAME.lua = GAME.lua .. '\n GAME_objects[name].strokeWidth + ' .. CALC(params[2]) .. ' end)'
end

M['setStrokeColor'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local colors = ' .. CALC(params[2], '{255, 255, 255}')
    GAME.lua = GAME.lua .. '\n GAME_objects[' .. CALC(params[1]) .. '].stroke = {colors[1]/255, colors[2]/255, colors[3]/255} end)'
end

M['setStrokeRGB'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].stroke ='
    GAME.lua = GAME.lua .. '\n {' .. CALC(params[2]) .. '/255, ' .. CALC(params[3]) .. '/255, ' .. CALC(params[4]) .. '/255} end)'
end

M['setMarchingAnts'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].stroke.effect = \'generator.marchingAnts\' end)'
end

M['removeMarchingAnts'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].stroke.effect = nil end)'
end

return M
