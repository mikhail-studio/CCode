local CALC = require 'Core.Simulation.calc'
local M = {}

M['newText'] = function(params)
    local name, text = CALC(params[1]), CALC(params[2])
    local font, size = CALC(params[3], '\'ubuntu\''), CALC(params[4], '36')
    local colors, alpha = CALC(params[5], '{255}'), CALC(params[6], '100')
    local posX = '(CENTER_X + (' .. CALC(params[7]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[8]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local colors, font = ' .. colors .. ', other.getFont(' .. font .. ')'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '] = display.newText(GAME.group, tostring(' .. text .. '), '
    GAME.lua = GAME.lua .. posX .. ', ' .. posY .. ', font, ' .. size .. ') GAME.group:insert(GAME.group.texts[' .. name .. '])'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].alpha = ' ..  alpha .. ' / 100 end)'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._density = 1 GAME.group.texts[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._friction = 0 GAME.group.texts[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._body = \'\' GAME.group.texts[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._touch = \'\' GAME.group.texts[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '].name = ' .. name .. ' end)'
end

M['newText2'] = function(params)
    local name, text = CALC(params[1]), CALC(params[2])
    local font, size = CALC(params[3], '\'ubuntu\''), CALC(params[4], '36')
    local colors, align = CALC(params[5], '{255}'), CALC(params[6], '\'center\'')
    local width, height = CALC(params[7]), CALC(params[8])
    local posX = '(CENTER_X + (' .. CALC(params[9]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[10]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local colors, font = ' .. colors .. ', other.getFont(' .. font .. ')'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '] = display.newText({parent = GAME.group, text = tostring('
    GAME.lua = GAME.lua .. text .. '), x = ' .. posX .. ', y = ' .. posY .. ', width = ' .. width .. ', height = ' .. height .. ', align = '
    GAME.lua = GAME.lua .. align .. ', font = font, fontSize = ' .. size .. '}) GAME.group:insert(GAME.group.texts[' .. name .. '])'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._density = 1 GAME.group.texts[' .. name .. ']._bounce = 0'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._friction = 0 GAME.group.texts[' .. name .. ']._gravity = 1'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._body = \'\' GAME.group.texts[' .. name .. ']._hitbox = {}'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._touch = \'\' GAME.group.texts[' .. name .. ']._tag = \'TAG\''
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '].name = ' .. name .. ' end)'
end

M['setVar'] = function(params)
    local var = CALC(params[1], nil, true)
    local value = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() ' .. var .. ' = ' .. value .. ' end)'
end

M['updVar'] = function(params)
    local var = CALC(params[1], nil, true)
    local value = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() ' .. var .. ' = ' .. var .. ' + ' .. value .. ' end)'
end

M['addTable'] = function(params)
    local key = UTF8.sub(CALC(params[1], nil, true), 2)
    local table = CALC(params[2], nil, true)
    local value = CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() if ' .. table .. ' then ' .. table .. key .. ' = ' .. value
    GAME.lua = GAME.lua .. ' else ' .. table .. ' = {' .. key .. ' = ' .. value .. '} end end)'
end

M['resetTable'] = function(params)
    local table = CALC(params[1], nil, true)
    local value = CALC(params[2], '[]')

    GAME.lua = GAME.lua .. ' pcall(function() ' .. table .. ' = JSON.decode(' .. value .. ') end)'
end

M['setText'] = function(params)
    local name = CALC(params[1])
    local text = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].text = tostring(' .. text .. ') end)'
end

M['setTextPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[3]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setTextPosX'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].x = ' .. posX .. ' end)'
end

M['setTextPosY'] = function(params)
    local name = CALC(params[1])
    local posY = '(CENTER_Y - (' .. CALC(params[2]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setTextRotation'] = function(params)
    local name = CALC(params[1])
    local rotation = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].rotation = ' .. rotation .. ' end)'
end

M['setTextAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '(' .. CALC(params[2]) .. ' / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].alpha = ' .. alpha .. ' end)'
end

M['updTextPosX'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].x = GAME.group.texts[' .. name .. '].x + ' .. posX .. ' end)'
end

M['updTextPosY'] = function(params)
    local name = CALC(params[1])
    local posY = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].y = GAME.group.texts[' .. name .. '].y - ' .. posY .. ' end)'
end

M['updTextRotation'] = function(params)
    local name = CALC(params[1])
    local rotation = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].rotation = GAME.group.texts[' .. name .. '].rotation + ' .. rotation .. ' end)'
end

M['updTextAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.texts[' .. name .. '].alpha = GAME.group.texts[' .. name .. '].alpha + ' .. alpha .. ' end)'
end

M['saveValue'] = function(params)
    local key = CALC(params[1])
    local value = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() local data =  GET_GAME_SAVE(CURRENT_LINK)'
    GAME.lua = GAME.lua .. ' data[tostring(' .. key .. ')] = ' .. value .. ' SET_GAME_SAVE(CURRENT_LINK, data) end)'
end

M['setRandomSeed'] = function(params)
    local seed = CALC(params[1])

    GAME.lua = GAME.lua .. ' pcall(function() math.randomseed(math.sum(UTF8.byte(tostring(' .. seed .. '), 1,'
    GAME.lua = GAME.lua .. ' UTF8.len(tostring(' .. seed .. '))))) end)'
end

return M
