local CALC = require 'Core.Simulation.calc'
local M = {}

M['setBody'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'dynamic\'')
    local density = CALC(params[3], '1')
    local bounce = CALC(params[4], '0')
    local friction = CALC(params[5], '0')
    local gravity = '0 - (' .. CALC(params[6], '-1') .. ')'
    local hitbox = 'GAME.group.objects[' .. name .. ']._hitbox'

    GAME.lua = GAME.lua .. ' pcall(function() pcall(function() PHYSICS.removeBody(GAME.group.objects[' .. name .. ']) end)'
    GAME.lua = GAME.lua .. ' local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ')'
    GAME.lua = GAME.lua .. ' PHYSICS.addBody(GAME.group.objects[' .. name .. '], ' .. type .. ', params)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._density = ' .. density
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._bounce = ' .. bounce
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._friction = ' .. friction
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._gravity = ' .. gravity
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = ' .. type
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].gravityScale = ' .. gravity .. ' end)'
end

M['setBodyType'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'dynamic\'')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].bodyType = ' .. type
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._body = ' .. type .. ' end)'
end

M['removeBody'] = function(params)
    local name = CALC(params[1])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']._body = \'\''
    GAME.lua = GAME.lua .. ' PHYSICS.removeBody(GAME.group.objects[' .. name .. ']) end)'
end

M['setGravity'] = function(params)
    local name = CALC(params[1])
    local gravity = '0 - (' .. CALC(params[2], '-1') .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].gravityScale = ' .. gravity
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._gravity = ' .. gravity .. ' end)'
end

M['setWorldGravity'] = function(params)
    local gravityX = CALC(params[1], '0')
    local gravityY = '0 - (' .. CALC(params[2], '-9.8') .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.setGravity(' .. gravityX .. ', ' .. gravityY .. ') end)'
end

M['setLinearVelocity'] = function(params)
    local name = CALC(params[1])
    local speedX = CALC(params[2], '0')
    local speedY = CALC(params[3], '0')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:setLinearVelocity(' .. speedX .. ', -' .. speedY .. ') end)'
end

M['setLinearVelocityX'] = function(params)
    local name = CALC(params[1])
    local speedX = CALC(params[2], '0')

    GAME.lua = GAME.lua .. ' pcall(function() local speedX, speedY = GAME.group.objects[' .. name .. ']:getLinearVelocity()'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']:setLinearVelocity(' .. speedX .. ', speedY) end)'
end

M['setLinearVelocityY'] = function(params)
    local name = CALC(params[1])
    local speedY = CALC(params[2], '0')

    GAME.lua = GAME.lua .. ' pcall(function() local speedX, speedY = GAME.group.objects[' .. name .. ']:getLinearVelocity()'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']:setLinearVelocity(speedX, ' .. speedY .. ') end)'
end

M['setAngularVelocity'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].angularVelocity = ' .. CALC(params[2]) .. ' end)'
end

M['setAngularDamping'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].angularDamping = ' .. CALC(params[2]) .. ' end)'
end

M['setLinearDamping'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].linearDamping = ' .. CALC(params[2]) .. ' end)'
end

M['setLinearImpulse'] = function(params)
    local name = CALC(params[1])
    local forceX = CALC(params[2], '0')
    local forceY = CALC(params[3], '0')
    local offsetX = CALC(params[4], '0')
    local offsetY = CALC(params[5], '0')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:applyLinearImpulse(' .. forceX .. ', 0 - (' .. forceY .. '),'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].x + (' .. offsetX .. '),'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].y - (' .. offsetY .. ')) end)'
end

M['setAngularImpulse'] = function(params)
    local name = CALC(params[1])
    local force = CALC(params[2], '0')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:applyAngularImpulse(' .. force .. ') end)'
end

M['setForce'] = function(params)
    local name = CALC(params[1])
    local forceX = CALC(params[2], '0')
    local forceY = CALC(params[3], '0')
    local offsetX = CALC(params[4], '0')
    local offsetY = CALC(params[5], '0')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']:applyForce(' .. forceX .. ', 0 - (' .. forceY .. '),'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].x + (' .. offsetX .. '),'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].y - (' .. offsetY .. ')) end)'
end

M['setTorque'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. ']:applyTorque(' .. CALC(params[2])  .. ') end)'
end

M['setHitboxBox'] = function(params)
    local name = CALC(params[1])
    local rotation = CALC(params[2])
    local halfWidth = '(' .. CALC(params[3]) .. ') / 2'
    local halfHeight = '(' .. CALC(params[4]) .. ') / 2'
    local offsetX = CALC(params[5])
    local offsetY = CALC(params[6])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']._hitbox.type = \'box\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.halfWidth = ' .. halfWidth
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.halfHeight = ' .. halfHeight
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.offsetX = ' .. offsetX
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.offsetY = ' .. offsetY
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.rotation = ' .. rotation .. ' end)'
end

M['setHitboxCircle'] = function(params)
    local name = CALC(params[1])
    local radius = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']._hitbox.type = \'circle\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.radius = ' .. radius .. ' end)'
end

M['setHitboxMesh'] = function(params)
    local name = CALC(params[1])
    local mesh = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']._hitbox.type = \'mesh\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.outline = graphics.newOutline(' .. mesh .. ','
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link, system.DocumentsDirectory) end)'
end

M['setHitboxPolygon'] = function(params)
    local name = CALC(params[1])
    local polygon = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. ']._hitbox.type = \'polygon\''
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._hitbox.shape = ' .. polygon .. ' end)'
end

M['updHitbox'] = function(params)
    local name = CALC(params[1])
    local type = 'GAME.group.objects[' .. name .. ']._body'
    local friction = 'GAME.group.objects[' .. name .. ']._friction'
    local bounce = 'GAME.group.objects[' .. name .. ']._bounce'
    local density = 'GAME.group.objects[' .. name .. ']._density'
    local gravity = 'GAME.group.objects[' .. name .. ']._gravity'
    local hitbox = 'GAME.group.objects[' .. name .. ']._hitbox'
    local isSensor = 'GAME.group.objects[' .. name .. '].isSensor'
    local isFixedRotation = 'GAME.group.objects[' .. name .. '].isFixedRotation'
    local isBullet = 'GAME.group.objects[' .. name .. '].isBullet'

    GAME.lua = GAME.lua .. ' pcall(function() local isSensor, isFixedRotation, isBullet = false, false, false pcall(function()'
    GAME.lua = GAME.lua .. ' isFixedRotation = ' .. isFixedRotation .. ' isSensor, isBullet = ' .. isSensor .. ', ' .. isBullet .. ' end)'
    GAME.lua = GAME.lua .. ' pcall(function() PHYSICS.removeBody(GAME.group.objects[' .. name .. ']) end)'
    GAME.lua = GAME.lua .. ' local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ')'
    GAME.lua = GAME.lua .. ' PHYSICS.addBody(GAME.group.objects[' .. name .. '], ' .. type .. ', params)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].isSensor = isSensor end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].isFixedRotation = isFixedRotation end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].isBullet = isBullet end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].gravityScale = ' .. gravity .. ' end) end)'
end

M['setSensor'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isSensor = true end)'
end

M['setAwake'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isAwake = true end)'
end

M['removeSensor'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isSensor = false end)'
end

M['setFixedRotation'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isFixedRotation = true end)'
end

M['removeFixedRotation'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isFixedRotation = false end)'
end

M['setBullet'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isBullet = true end)'
end

M['removeBullet'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isBullet = false end)'
end

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
