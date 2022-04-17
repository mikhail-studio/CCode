local CALC = require 'Core.Simulation.calc'
local M = {}

M['newGroup'] = function(params)
    local name = CALC(params[1])

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.groups[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '] = display.newGroup() GAME.group:insert(GAME.group.groups[' .. name .. ']) end)'
end

M['addObject'] = function(params)
    local nameGroup = CALC(params[1])
    local nameObject = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.objects[' .. nameObject .. ']) end)'
end

M['removeGroup'] = function(params)
    local name = CALC(params[1])

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.groups[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '] = nil end)'
end

M['showGroup'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].isVisible = true end)'
end

M['hideGroup'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].isVisible = false end)'
end

M['setGroupPos'] = function(params)
    local name = CALC(params[1])
    local posX = CALC(params[2])
    local posY = '0 - (' .. CALC(params[3]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setGroupPosX'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].x = ' .. CALC(params[2]) .. ' end)'
end

M['setGroupPosY'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].y = 0 - (' .. CALC(params[2]) .. ') end)'
end

M['setGroupAlpha'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].alpha = (' .. CALC(params[2]) .. ') / 100 end)'
end

M['updGroupPosX'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].x = GAME.group.groups[' .. name .. '].x + ' .. posX .. ' end)'
end

M['updGroupPosY'] = function(params)
    local name = CALC(params[1])
    local posY = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].y = GAME.group.groups[' .. name .. '].y - ' .. posY .. ' end)'
end

M['updGroupAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].alpha ='
    GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].alpha + ' .. alpha .. ' end)'
end

return M
