local CALC = require 'Core.Simulation.calc'
local M = {}

M['newRect'] = function(params)
    local name, colors = CALC(params[1]), CALC(params[2], '{255}')
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(CENTER_X + (' .. CALC(params[5]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local colors = ' .. colors
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newRect(GAME.group, ' .. posX .. ', ' .. posY .. ', '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') GAME.group:insert(GAME.group.objects[' .. name .. '])'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = GAME.group.objects[' .. name .. '].width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = GAME.group.objects[' .. name .. '].height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._density = 1 GAME.group.objects[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._friction = 0 GAME.group.objects[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = \'\' GAME.group.objects[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = link GAME.group.objects[' .. name .. ']._name = \'SHAPE\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._touch = false GAME.group.objects[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._size, GAME.group.objects[' .. name .. '].name = 1, ' .. name .. ' end)'
end

M['newRoundedRect'] = function(params)
    local name, radius = CALC(params[1]), CALC(params[2])
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(CENTER_X + (' .. CALC(params[5]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.objects[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newRoundedRect(GAME.group, ' .. posX .. ', ' .. posY .. ', '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ', ' .. radius .. ') GAME.group:insert(GAME.group.objects[' .. name .. '])'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = GAME.group.objects[' .. name .. '].width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = GAME.group.objects[' .. name .. '].height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._density = 1 GAME.group.objects[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._friction = 0 GAME.group.objects[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = \'\' GAME.group.objects[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = link GAME.group.objects[' .. name .. ']._name = \'SHAPE\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._touch = false GAME.group.objects[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._size, GAME.group.objects[' .. name .. '].name = 1, ' .. name .. ' end)'
end

M['newCircle'] = function(params)
    local name, radius = CALC(params[1]), CALC(params[2])
    local posX = '(CENTER_X + (' .. CALC(params[3]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.objects[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newCircle(GAME.group, ' .. posX .. ', ' .. posY .. ', ' .. radius .. ')'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.objects[' .. name .. '])'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._radius = GAME.group.objects[' .. name .. '].path.radius'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._density = 1 GAME.group.objects[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._friction = 0 GAME.group.objects[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = \'\' GAME.group.objects[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = link GAME.group.objects[' .. name .. ']._name = \'SHAPE\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._touch = false GAME.group.objects[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._size, GAME.group.objects[' .. name .. '].name = 1, ' .. name .. ' end)'
end

M['newBitmap'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. ' display.setDefault(\'magTextureFilter\', \'nearest\')'
    GAME.lua = GAME.lua .. ' display.setDefault(\'minTextureFilter\', \'nearest\')'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.bitmaps[' .. name .. '] ='
    GAME.lua = GAME.lua .. ' BITMAP.newTexture({width = ' .. width .. ', height = ' .. height .. '}) end)'
end

M['setPixel'] = function(params)
    local name, colors = CALC(params[1]), CALC(params[4], '{255}')
    local posX, posY = CALC(params[2]), CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() local colors = ' .. colors .. ' GAME.group.bitmaps[' .. name .. ']:setPixel('
    GAME.lua = GAME.lua .. posX .. ', ' .. posY .. ', colors[1]/255, colors[2]/255, colors[3]/255) end)'
end

M['setPixelRGB'] = function(params)
    local name = CALC(params[1])
    local posX, posY = CALC(params[2]), CALC(params[3])
    local r, g, b = CALC(params[4], '255'), CALC(params[5], '255'), CALC(params[6], '255')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.bitmaps[' .. name .. ']:setPixel('
    GAME.lua = GAME.lua .. posX .. ', ' .. posY .. ', ' .. r .. '/255, ' .. g .. '/255, ' .. b .. '/255) end)'
end

M['updBitmap'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.bitmaps[' .. CALC(params[1]) .. ']:invalidate() end)'
end

M['setBitmapSprite'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() local image = display.newImage(GAME.group.bitmaps[' .. link .. '].filename,'
    GAME.lua = GAME.lua .. ' GAME.group.bitmaps[' .. link .. '].baseDir)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = image.width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = image.height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = GAME.group.bitmaps[' .. link .. '].filename'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._name = ' .. link
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].fill = {type = \'image\','
    GAME.lua = GAME.lua .. ' filename = GAME.group.bitmaps[' .. link .. '].filename,'
    GAME.lua = GAME.lua .. ' baseDir = GAME.group.bitmaps[' .. link .. '].baseDir} image:removeSelf() image = nil end)'
end

return M
