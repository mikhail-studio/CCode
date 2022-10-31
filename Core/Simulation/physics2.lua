local CALC = require 'Core.Simulation.calc'
local M = {}

M['setTextBody'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'dynamic\'')
    local density = CALC(params[3], '1')
    local bounce = CALC(params[4], '0')
    local friction = CALC(params[5], '0')
    local gravity = '0 - (' .. CALC(params[6], '-1') .. ')'
    local hitbox = 'GAME.group.texts[' .. name .. ']._hitbox'

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() PHYSICS.removeBody(GAME.group.texts[' .. name .. ']) end)'
    GAME.lua = GAME.lua .. ' local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ')'
    GAME.lua = GAME.lua .. ' PHYSICS.addBody(GAME.group.texts[' .. name .. '], ' .. type .. ', params)'
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._density = ' .. density
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._bounce = ' .. bounce
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._friction = ' .. friction
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._gravity = ' .. gravity
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. ']._body = ' .. type
    GAME.lua = GAME.lua .. ' GAME.group.texts[' .. name .. '].gravityScale = ' .. gravity .. ' end)'
end

M['setHitboxVisible'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.setDrawMode \'hybrid\' end)'
end

M['removeHitboxVisible'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.setDrawMode \'normal\' end)'
end

M['startPhysics'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.start() end)'
end

M['stopPhysics'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.stop() end)'
end

return M
