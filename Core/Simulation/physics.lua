local CALC = require 'Core.Simulation.calc'
local M = {}

if 'Физика 1' then
    M['setBody'] = function(params, isLevel)
        local name = CALC(params[1])
        local type = CALC(params[2], '\'dynamic\'')
        local density = #params == 4 and '1' or CALC(params[3], '1')
        local bounce = #params == 4 and CALC(params[3], '0') or CALC(params[4], '0')
        local friction = #params == 4 and '0' or CALC(params[5], '0')
        local gravity = '0 - (' .. (#params == 4 and CALC(params[4], '-1') or CALC(params[6], '-1')) .. ')'
        local categoryBit = #params == 4 and 'nil' or CALC(params[7], 'nil')
        local maskBits = #params == 4 and 'nil' or CALC(params[8], 'nil')
        local hitbox = 'GAME_objects[name]._hitbox'

        if isLevel then
            name = 'object.name'
            type = 'object.body'
            density = 'object.density'
            bounce = 'object.bounce'
            friction = 'object.friction'
            gravity = '0 - object.gravity'
        end

        GAME.lua = GAME.lua .. '\n pcall(function() local name, type = ' .. name .. ', ' .. type
        GAME.lua = GAME.lua .. '\n local maskBits, categoryBit = ' .. maskBits .. ', ' .. categoryBit
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.removeBody(GAME_objects[name]) end)'
        GAME.lua = GAME.lua .. '\n local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ','
        GAME.lua = GAME.lua .. '\n {categoryBit, maskBits}) PHYSICS.addBody(GAME_objects[name], \'dynamic\','
        GAME.lua = GAME.lua .. '\n UNPACK(params)) GAME_objects[name]._density = params.density'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._bounce = params.bounce'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._friction = params.friction'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._gravity = ' .. gravity
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = type'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].bodyType = type'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._maskBits = maskBits'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._categoryBit = categoryBit'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].gravityScale = GAME_objects[name]._gravity end)'

        if isLevel then
            GAME.lua = GAME.lua .. '\n pcall(function() local name = object.name'
            GAME.lua = GAME.lua .. '\n GAME_objects[name].isFixedRotation = object.isFixedRotation'
            GAME.lua = GAME.lua .. '\n GAME_objects[name].isSensor = object.isSensor end)'
        end
    end

    M['setBodyType'] = function(params)
        local name = CALC(params[1])
        local type = CALC(params[2], '\'dynamic\'')

        GAME.lua = GAME.lua .. '\n pcall(function() local name, type = ' .. name .. ', ' .. type .. ' GAME_objects[name].bodyType = type'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._body = type end)'
    end

    M['removeBody'] = function(params)
        local name = CALC(params[1])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name]._body = \'\''
        GAME.lua = GAME.lua .. '\n PHYSICS.removeBody(GAME_objects[name]) end)'
    end

    M['setGravity'] = function(params)
        local name = CALC(params[1])
        local gravity = '0 - (' .. CALC(params[2], '-1') .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name, gravity = ' .. name .. ', ' .. gravity
        GAME.lua = GAME.lua .. '\n GAME_objects[name].gravityScale = gravity GAME_objects[name]._gravity = gravity end)'
    end

    M['setLinearVelocity'] = function(params)
        local name = CALC(params[1])
        local speedX = CALC(params[2], '0')
        local speedY = CALC(params[3], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. name .. ']:setLinearVelocity(' .. speedX .. ', -' .. speedY .. ') end)'
    end

    M['setLinearVelocityX'] = function(params)
        local name = CALC(params[1])
        local speedX = CALC(params[2], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local speedX, speedY = GAME_objects[name]:getLinearVelocity()'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]:setLinearVelocity(' .. speedX .. ', speedY) end)'
    end

    M['setLinearVelocityY'] = function(params)
        local name = CALC(params[1])
        local speedY = CALC(params[2], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local speedX, speedY = GAME_objects[name]:getLinearVelocity()'
        GAME.lua = GAME.lua .. '\n GAME_objects[name]:setLinearVelocity(speedX, -' .. speedY .. ') end)'
    end

    M['setHitboxBox'] = function(params)
        local name = CALC(params[1])
        local rotation = CALC(params[2])
        local halfWidth = '(' .. CALC(params[3]) .. ') / 2'
        local halfHeight = '(' .. CALC(params[4]) .. ') / 2'
        local offsetX = CALC(params[5])
        local offsetY = CALC(params[6])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name]._hitbox.type = \'box\''
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.halfWidth = ' .. halfWidth
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.halfHeight = ' .. halfHeight
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.offsetX = ' .. offsetX
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.offsetY = ' .. offsetY
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.rotation = ' .. rotation .. ' end)'
    end

    M['setHitboxCircle'] = function(params)
        local name = CALC(params[1])
        local radius = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name]._hitbox.type = \'circle\''
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.radius = ' .. radius .. ' end)'
    end

    M['setHitboxMesh'] = function(params)
        local name = CALC(params[1])
        local mesh = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name]._hitbox.type = \'mesh\''
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.outline = graphics.newOutline(' .. mesh .. ','
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._link, GAME_objects[name]._baseDir) end)'
    end

    M['setHitboxPolygon'] = function(params)
        local name = CALC(params[1])
        local polygon = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name]._hitbox.type = \'polygon\''
        GAME.lua = GAME.lua .. '\n GAME_objects[name]._hitbox.shape = ' .. polygon .. ' end)'
    end

    M['updHitbox'] = function(params, isLevel)
        local name = CALC(params[1])
        local type = 'GAME_objects[name]._body'
        local friction = 'GAME_objects[name]._friction'
        local bounce = 'GAME_objects[name]._bounce'
        local density = 'GAME_objects[name]._density'
        local gravity = 'GAME_objects[name]._gravity'
        local hitbox = 'GAME_objects[name]._hitbox'
        local categoryBit = 'GAME_objects[name]._categoryBit'
        local maskBits = 'GAME_objects[name]._maskBits'
        local isSensor = 'GAME_objects[name].isSensor'
        local isFixedRotation = 'GAME_objects[name].isFixedRotation'
        local isBullet = 'GAME_objects[name].isBullet'

        if isLevel then
            name = 'object.name'
        end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name
        GAME.lua = GAME.lua .. '\n local isSensor, isFixedRotation, isBullet = false, false, false pcall(function()'
        GAME.lua = GAME.lua .. '\n isFixedRotation = ' .. isFixedRotation .. ' isSensor, isBullet = ' .. isSensor .. ', ' .. isBullet .. ' end)'
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.removeBody(GAME_objects[name]) end)'
        GAME.lua = GAME.lua .. '\n print(123) local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ','
        GAME.lua = GAME.lua .. '\n {' .. categoryBit .. ', ' .. maskBits .. '}) PHYSICS.addBody(GAME_objects[name], \'dynamic\','
        GAME.lua = GAME.lua .. '\n UNPACK(params)) pcall(function() GAME_objects[name].isSensor = isSensor end)'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name].bodyType = ' .. type .. ' end)'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name].isFixedRotation = isFixedRotation end)'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name].isBullet = isBullet end)'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[name].gravityScale = ' .. gravity .. ' end) end)'
    end

    M['setSensor'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isSensor = true end)'
    end

    M['removeSensor'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isSensor = false end)'
    end

    M['setFixedRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isFixedRotation = true end)'
    end

    M['removeFixedRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isFixedRotation = false end)'
    end

    M['setBullet'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isBullet = true end)'
    end

    M['removeBullet'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isBullet = false end)'
    end
end

if 'Физика 2' then
    M['setWorldGravity'] = function(params)
        local gravityX = CALC(params[1], '0')
        local gravityY = '0 - (' .. CALC(params[2], '-9.8') .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.setGravity(' .. gravityX .. ', ' .. gravityY .. ') end)'
    end

    M['setAngularVelocity'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].angularVelocity = ' .. CALC(params[2]) .. ' end)'
    end

    M['setAngularDamping'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].angularDamping = ' .. CALC(params[2]) .. ' end)'
    end

    M['setLinearDamping'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].linearDamping = ' .. CALC(params[2]) .. ' end)'
    end

    M['setLinearImpulse'] = function(params)
        local name = CALC(params[1])
        local forceX = CALC(params[2], '0')
        local forceY = CALC(params[3], '0')
        local offsetX = CALC(params[4], '0')
        local offsetY = CALC(params[5], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name
        GAME.lua = GAME.lua .. '\n GAME_objects[name]:applyLinearImpulse(' .. forceX .. ', 0 - (' .. forceY .. '),'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].x + (' .. offsetX .. '),'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].y - (' .. offsetY .. ')) end)'
    end

    M['setAngularImpulse'] = function(params)
        local name = CALC(params[1])
        local force = CALC(params[2], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. name .. ']:applyAngularImpulse(' .. force .. ') end)'
    end

    M['setBounce'] = function(params)
        local contact = CALC(params[1])
        local bounce = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() ' .. contact .. '[\'bounce\'] = ' .. bounce .. ' end)'
    end

    M['setFriction'] = function(params)
        local contact = CALC(params[1])
        local friction = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() ' .. contact .. '[\'friction\'] = ' .. friction .. ' end)'
    end

    M['setTangentSpeed'] = function(params)
        local contact = CALC(params[1])
        local speed = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() ' .. contact .. '[\'tangentSpeed\'] = ' .. speed .. ' end)'
    end

    M['setForce'] = function(params)
        local name = CALC(params[1])
        local forceX = CALC(params[2], '0')
        local forceY = CALC(params[3], '0')
        local offsetX = CALC(params[4], '0')
        local offsetY = CALC(params[5], '0')

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name
        GAME.lua = GAME.lua .. '\n GAME_objects[name]:applyForce(' .. forceX .. ', 0 - (' .. forceY .. '),'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].x + (' .. offsetX .. '),'
        GAME.lua = GAME.lua .. '\n GAME_objects[name].y - (' .. offsetY .. ')) end)'
    end

    M['setTorque'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. ']:applyTorque(' .. CALC(params[2])  .. ') end)'
    end

    M['disableCollision'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1]) .. '[\'isEnabled\'] = false end)'
    end

    M['setAwake'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isAwake = true end)'
    end

    M['setTextBody'] = function(params)
        local name = CALC(params[1])
        local type = CALC(params[2], '\'dynamic\'')
        local density = CALC(params[3], '1')
        local bounce = CALC(params[4], '0')
        local friction = CALC(params[5], '0')
        local gravity = '0 - (' .. CALC(params[6], '-1') .. ')'
        local hitbox = 'GAME_texts[name]._hitbox'

        GAME.lua = GAME.lua .. '\n pcall(function() local name, type = ' .. name .. ', ' .. type
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.removeBody(GAME_texts[name]) end)'
        GAME.lua = GAME.lua .. '\n local params = other.getPhysicsParams(' .. friction .. ', ' .. bounce .. ', ' .. density .. ', ' .. hitbox .. ')'
        GAME.lua = GAME.lua .. '\n PHYSICS.addBody(GAME_texts[name], type, UNPACK(params))'
        GAME.lua = GAME.lua .. '\n GAME_texts[name]._density = params.density'
        GAME.lua = GAME.lua .. '\n GAME_texts[name]._bounce = params.bounce'
        GAME.lua = GAME.lua .. '\n GAME_texts[name]._friction = params.friction'
        GAME.lua = GAME.lua .. '\n GAME_texts[name]._gravity = ' .. gravity
        GAME.lua = GAME.lua .. '\n GAME_texts[name]._body = type'
        GAME.lua = GAME.lua .. '\n GAME_texts[name].gravityScale = GAME_texts[name]._gravity end)'
    end

    M['setHitboxVisible'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.setDrawMode \'hybrid\' end)'
    end

    M['removeHitboxVisible'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.setDrawMode \'normal\' end)'
    end

    M['startPhysics'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.start() end)'
    end

    M['pausePhysics'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.pause() end)'
    end

    M['stopPhysics'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.stop() end)'
    end
end

if 'Физика 3' then
    M['deleteJoint'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. CALC(params[1]) .. ']:removeSelf() end)'
    end

    M['setPivotJoint'] = function(params)
        local joint = CALC(params[1])
        local base = CALC(params[2])
        local pivot = CALC(params[3])
        local anchorX = '(' .. CALC(params[4]) .. ')'
        local anchorY = '(' .. CALC(params[5]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects = GAME_objects'
        GAME.lua = GAME.lua .. '\n local pivot = ' .. pivot .. ' local base = ' .. base
        GAME.lua = GAME.lua .. '\n if objects[base]._body ~= \'\' and objects[pivot]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'pivot\', objects[base],'
        GAME.lua = GAME.lua .. '\n objects[pivot], ' .. anchorX .. ' + objects[pivot].x, -' .. anchorY .. ' + objects[pivot].y) end end)'
    end

    M['setPivotMotor'] = function(params)
        local joint = CALC(params[1])
        local state = CALC(params[2])
        local speed = '(' .. CALC(params[3]) .. ')'
        local maxTorque = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local pivotJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n pivotJoint.isMotorEnabled = ' .. state .. ' pivotJoint.motorSpeed = ' .. speed
        GAME.lua = GAME.lua .. '\n pivotJoint.maxMotorTorque = ' .. maxTorque .. ' end)'
    end

    M['setPivotLimits'] = function(params)
        local joint = CALC(params[1])
        local state = CALC(params[2])
        local min = '(' .. CALC(params[3]) .. ')'
        local max = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local pivotJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n pivotJoint.isLimitEnabled = ' .. state
        GAME.lua = GAME.lua .. '\n pivotJoint:setRotationLimits(' .. min .. ', ' .. max .. ') end)'
    end

    M['setDistanceJoint'] = function(params)
        local joint = CALC(params[1])
        local bodyA = CALC(params[2])
        local bodyB = CALC(params[3])
        local anchorXA = '(' .. CALC(params[4]) .. ')'
        local anchorYA = '(' .. CALC(params[5]) .. ')'
        local anchorXB = '(' .. CALC(params[6]) .. ')'
        local anchorYB = '(' .. CALC(params[7]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects, bodyA, bodyB = GAME_objects, ' .. bodyA .. ', ' .. bodyB
        GAME.lua = GAME.lua .. '\n if objects[bodyA]._body ~= \'\' and objects[bodyB]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'distance\', objects[bodyA],'
        GAME.lua = GAME.lua .. '\n objects[bodyB], ' .. anchorXA .. ' + objects[bodyA].x, -' .. anchorYA .. ' + objects[bodyA].y'
        GAME.lua = GAME.lua .. ', ' .. anchorXB .. ' + objects[bodyB].x, -' .. anchorYB .. ' + objects[bodyB].y) end end)'
    end

    M['setDistanceSettings'] = function(params)
        local joint = CALC(params[1])
        local dampingRatio = '(' .. CALC(params[2]) .. ' / 100)'
        local frequency = '(' .. CALC(params[3]) .. ')'
        local length = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local distanceJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n distanceJoint.dampingRatio = ' .. dampingRatio
        GAME.lua = GAME.lua .. '\n distanceJoint.frequency = ' .. frequency
        GAME.lua = GAME.lua .. '\n distanceJoint.length = ' .. length .. ' end)'
    end

    M['setPistonJoint'] = function(params)
        local joint = CALC(params[1])
        local base = CALC(params[2])
        local piston = CALC(params[3])
        local anchorX = '(' .. CALC(params[4]) .. ')'
        local anchorY = '(' .. CALC(params[5]) .. ')'
        local axisX = '(' .. CALC(params[6]) .. ' / 100)'
        local axisY = '(' .. CALC(params[7]) .. ' / 100)'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects = GAME_objects'
        GAME.lua = GAME.lua .. '\n local piston = ' .. piston .. ' local base = ' .. base
        GAME.lua = GAME.lua .. '\n if objects[base]._body ~= \'\' and objects[piston]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'piston\', objects[base],'
        GAME.lua = GAME.lua .. '\n objects[piston], ' .. anchorX .. ' + objects[piston].x, -' .. anchorY
        GAME.lua = GAME.lua .. '\n + objects[piston].y, ' .. axisX .. ', -' .. axisY .. ') end end)'
    end

    M['setPistonMotor'] = function(params)
        local joint = CALC(params[1])
        local state = CALC(params[2])
        local speed = '(' .. CALC(params[3]) .. ')'
        local maxForce = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local pistonJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n pistonJoint.isMotorEnabled = ' .. state
        GAME.lua = GAME.lua .. '\n pistonJoint.motorSpeed = ' .. speed
        GAME.lua = GAME.lua .. '\n pistonJoint.maxMotorForce = ' .. maxForce .. ' end)'
    end

    M['setPistonLimits'] = function(params)
        local joint = CALC(params[1])
        local state = CALC(params[2])
        local min = '(' .. CALC(params[3]) .. ')'
        local max = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local pistonJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n pistonJoint.isLimitEnabled = ' .. state
        GAME.lua = GAME.lua .. '\n pistonJoint:setLimits(' .. max .. ', ' .. min .. ') end)'
    end

    M['setWeldJoint'] = function(params)
        local joint = CALC(params[1])
        local bodyA = CALC(params[2])
        local bodyB = CALC(params[3])
        local anchorX = '(' .. CALC(params[4]) .. ')'
        local anchorY = '(' .. CALC(params[5]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects = GAME_objects'
        GAME.lua = GAME.lua .. '\n local bodyA = ' .. bodyA .. ' local bodyB = ' .. bodyB
        GAME.lua = GAME.lua .. '\n if objects[bodyA]._body ~= \'\' and objects[bodyB]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'weld\', objects[bodyA],'
        GAME.lua = GAME.lua .. '\n objects[bodyB], ' .. anchorX .. ' + objects[bodyA].x, -' .. anchorY
        GAME.lua = GAME.lua .. '\n + objects[bodyA].y) end end)'
    end

    M['setWeldSettings'] = function(params)
        local joint = CALC(params[1])
        local dampingRatio = '(' .. CALC(params[2]) .. ' / 100)'
        local frequency = '(' .. CALC(params[3]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local weldJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n weldJoint.dampingRatio = ' .. dampingRatio
        GAME.lua = GAME.lua .. '\n weldJoint.frequency = ' .. frequency .. ' end)'
    end

    M['setWheelJoint'] = function(params)
        local joint = CALC(params[1])
        local base = CALC(params[2])
        local wheel = CALC(params[3])
        local anchorX = '(' .. CALC(params[4]) .. ')'
        local anchorY = '(' .. CALC(params[5]) .. ')'
        local axisX = '(' .. CALC(params[6]) .. ' / 100)'
        local axisY = '(' .. CALC(params[7]) .. ' / 100)'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects = GAME_objects'
        GAME.lua = GAME.lua .. '\n local wheel = ' .. wheel .. ' local base = ' .. base
        GAME.lua = GAME.lua .. '\n if objects[base]._body ~= \'\' and objects[wheel]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'wheel\', objects[base],'
        GAME.lua = GAME.lua .. '\n objects[wheel], ' .. anchorX .. ' + objects[wheel].x, -' .. anchorY
        GAME.lua = GAME.lua .. '\n + objects[wheel].y, ' .. axisX .. ', -' .. axisY .. ') end end)'
    end

    M['setTouchJoint'] = function(params)
        local joint = CALC(params[1])
        local obj = CALC(params[2])
        local anchorX = '(' .. CALC(params[3]) .. ')'
        local anchorY = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects, obj = GAME_objects, ' .. obj
        GAME.lua = GAME.lua .. '\n if objects[obj]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint(\'touch\','
        GAME.lua = GAME.lua .. '\n objects[obj], ' .. anchorX .. ' + objects[obj].x, -' .. anchorY .. ' + objects[obj].y) end end)'
    end

    M['setTouchTarget'] = function(params)
        local joint = CALC(params[1])
        local targetX = '(' .. CALC(params[2]) .. ')'
        local targetY = '(' .. CALC(params[3]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:setTarget(' .. targetX .. ' + CENTER_X, -' .. targetY .. ' + CENTER_Y) end)'
    end

    M['setTouchSettings'] = function(params)
        local joint = CALC(params[1])
        local dampingRatio = '(' .. CALC(params[2]) .. ' / 100)'
        local frequency = '(' .. CALC(params[3]) .. ')'
        local maxForce = '(' .. CALC(params[4]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local touchJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n touchJoint.dampingRatio = ' .. dampingRatio
        GAME.lua = GAME.lua .. '\n touchJoint.frequency = ' .. frequency
        GAME.lua = GAME.lua .. '\n touchJoint.maxForce = ' .. maxForce .. ' end)'
    end

    M['setRopeJoint'] = function(params)
        local joint = CALC(params[1])
        local bodyA = CALC(params[2])
        local bodyB = CALC(params[3])
        local anchorXA = '(' .. CALC(params[4]) .. ')'
        local anchorYA = '(' .. CALC(params[5]) .. ')'
        local anchorXB = '(' .. CALC(params[6]) .. ')'
        local anchorYB = '(' .. CALC(params[7]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects, bodyA, bodyB = GAME_objects, ' .. bodyA .. ', ' .. bodyB
        GAME.lua = GAME.lua .. '\n if objects[bodyA]._body ~= \'\' and objects[bodyB]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'rope\', objects[bodyA],'
        GAME.lua = GAME.lua .. '\n objects[bodyB], ' .. anchorXA .. ', -' .. anchorYA
        GAME.lua = GAME.lua .. ', ' .. anchorXB .. ', -' .. anchorYB .. ') end end)'
    end

    M['setRopeSettings'] = function(params)
        local joint = CALC(params[1])
        local maxLength = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. '].maxLength = ' .. maxLength .. ' end)'
    end

    M['setFrictionJoint'] = function(params)
        local joint = CALC(params[1])
        local bodyA = CALC(params[2])
        local bodyB = CALC(params[3])
        local anchorX = '(' .. CALC(params[4]) .. ')'
        local anchorY = '(' .. CALC(params[5]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects, bodyA, bodyB = GAME_objects, ' .. bodyA .. ', ' .. bodyB
        GAME.lua = GAME.lua .. '\n if objects[bodyA]._body ~= \'\' and objects[bodyB]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint( \'friction\', objects[bodyA],'
        GAME.lua = GAME.lua .. '\n objects[bodyB], ' .. anchorX .. ' + objects[bodyA].x, -' .. anchorY .. ' + objects[bodyA].y) end end)'
    end

    M['setFrictionSettings'] = function(params)
        local joint = CALC(params[1])
        local maxTorque = '(' .. CALC(params[2]) .. ')'
        local maxForce = '(' .. CALC(params[3]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local frictionJoint = GAME_joints[' .. joint .. ']'
        GAME.lua = GAME.lua .. '\n frictionJoint.maxTorque = ' .. maxTorque
        GAME.lua = GAME.lua .. '\n frictionJoint.maxForce = ' .. maxForce .. ' end)'
    end

    M['setPulleyJoint'] = function(params)
        local joint, ratio, bodyA, bodyB, statXA, statYA, statXB, statYB, bodyXA, bodyYA, bodyXB, bodyYB =
        CALC(params[1]), CALC(params[2]), CALC(params[3]), CALC(params[4]), CALC(params[5]), CALC(params[6]),
        CALC(params[7]), CALC(params[8]), CALC(params[9]), CALC(params[10]), CALC(params[11]), CALC(params[12])

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_joints[' .. joint .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n pcall(function() local objects, bodyA, bodyB = GAME_objects, ' .. bodyA .. ', ' .. bodyB
        GAME.lua = GAME.lua .. '\n if objects[bodyA]._body ~= \'\' and objects[bodyB]._body ~= \'\' then'
        GAME.lua = GAME.lua .. '\n GAME_joints[' .. joint .. '] = PHYSICS.newJoint(\'pulley\','
        GAME.lua = GAME.lua .. '\n objects[bodyA], objects[bodyB], ' .. statXA .. ' + objects[bodyA].x, -' .. statYA .. ' + objects[bodyA].y,'
        GAME.lua = GAME.lua .. '\n ' .. statXB .. ' + objects[bodyB].x, -' .. statYB  .. ' + objects[bodyB].y,'
        GAME.lua = GAME.lua .. '\n ' .. bodyXA .. ' + objects[bodyA].x, -' .. bodyYA .. ' + objects[bodyA].y, ' .. bodyXB
        GAME.lua = GAME.lua .. '\n + objects[bodyB].x, -' .. bodyYB .. ' + objects[bodyB].y, ' .. ratio .. ') end end)'
    end
end

return M
