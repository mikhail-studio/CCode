local CALC = require 'Core.Simulation.calc'
local M = {}

M['newRect'] = function(params)
    local name, colors = CALC(params[1]), CALC(params[2], '{255}')
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(CENTER_X + (' .. CALC(params[5]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local colors = ' .. colors
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newRect(' .. posX .. ', ' .. posY .. ', '
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
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newRoundedRect(' .. posX .. ', ' .. posY .. ', '
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
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name ..  '] = display.newCircle(' .. posX .. ', ' .. posY .. ', ' .. radius .. ')'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.objects[' .. name .. '])'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = GAME.group.objects[' .. name .. '].width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = GAME.group.objects[' .. name .. '].height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._density = 1 GAME.group.objects[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._friction = 0 GAME.group.objects[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = \'\' GAME.group.objects[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = link GAME.group.objects[' .. name .. ']._name = \'SHAPE\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._touch = false GAME.group.objects[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._size, GAME.group.objects[' .. name .. '].name = 1, ' .. name .. ' end)'
end

M['setSprite'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() local link, filter = other.getImage(' .. link .. ')'
    GAME.lua = GAME.lua .. ' display.setDefault(\'magTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' display.setDefault(\'minTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' local image = display.newImage(link, system.DocumentsDirectory)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = image.width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = image.height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = link'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._name = ' .. link
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].fill = {type = \'image\',' .. ' filename = link,'
    GAME.lua = GAME.lua .. ' baseDir = system.DocumentsDirectory} image:removeSelf() image = nil end)'
end

M['setColor'] = function(params)
    local name = CALC(params[1])
    local colors = CALC(params[2], '{255}')

    GAME.lua = GAME.lua .. ' pcall(function() local colors = ' .. colors
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
end

return M
