local CALC = require 'Core.Simulation.calc'
local M = {}

M['setFrame'] = function(params)
    local nameObject = CALC(params[1])
    local frame = CALC(params[2], '1')

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. ']:setFrame(' .. frame .. ') end)'
end

M['setScale'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. nameObject .. ' GAME_objects[name].xScale = ' .. scale
    GAME.lua = GAME.lua .. '\n GAME_objects[name].yScale = ' .. scale .. ' end)'
end

M['setScaleX'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. '].xScale = ' .. scale .. ' end)'
end

M['setScaleY'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. '].yScale = ' .. scale .. ' end)'
end

M['newSeqAnimation'] = function(params)
    local name, direction = CALC(params[1]), CALC(params[2], '\'forward\'')
    local startFrame, countFrame = CALC(params[3], '1'), CALC(params[4], '1')
    local countRepeat, time = CALC(params[5], '0'), '(' .. CALC(params[6], '0') .. ') * 1000'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_animations[name] = {name = name,'
    GAME.lua = GAME.lua .. '\n time = ' .. time .. ', loopDirection = ' .. direction .. ', start = ' .. startFrame .. ','
    GAME.lua = GAME.lua .. '\n count = ' .. countFrame .. ', loopCount = ' .. countRepeat .. '} end)'
end

M['newParAnimation'] = function(params)
    local tableFrames, name, direction = CALC(params[1], '{1}'), CALC(params[2]), CALC(params[3], '\'forward\'')
    local countRepeat, time = CALC(params[4], '0'), '(' .. CALC(params[5], '0') .. ') * 1000'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_animations[name] ='
    GAME.lua = GAME.lua .. '\n {name = name, time = ' .. time .. ', frames = ' .. tableFrames .. ','
    GAME.lua = GAME.lua .. '\n loopDirection = ' .. direction .. ', loopCount = ' .. countRepeat .. '} end)'
end

M['playAnimation'] = function(params)
    local nameObject, nameAnimation = CALC(params[1]), CALC(params[2], 'nil')

    GAME.lua = GAME.lua .. '\n pcall(function() local nameAnimation, name = ' .. nameAnimation .. ', ' .. nameObject
    GAME.lua = GAME.lua .. '\n if nameAnimation then GAME_objects[name]:setSequence(nameAnimation) end'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:play() end)'
end

M['newMask'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() local link, filter = other.getImage(' .. link .. ')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'magTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'minTextureFilter\', filter ~= \'linear\' and \'nearest\' or \'linear\')'
    GAME.lua = GAME.lua .. '\n GAME.group.masks[' .. name .. '] = graphics.newMask(link, system.DocumentsDirectory) end)'
end

M['addMaskToObject'] = function(params)
    local nameObject = CALC(params[1])
    local nameMask = CALC(params[2])

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. ']:setMask(GAME.group.masks[' .. nameMask .. ']) end)'
end

M['removeMask'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME.group.masks[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

M['removeMaskFromObject'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. ']:setMask(nil) end)'
end

M['setMaskScale'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() local name, scale = ' .. nameObject .. ', ' .. scale
    GAME.lua = GAME.lua .. '\n GAME_objects[name].maskScaleX = scale GAME_objects[name].maskScaleY = scale end)'
end

M['setMaskScaleX'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. '].maskScaleX = ' .. scale .. ' end)'
end

M['setMaskScaleY'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. nameObject .. '].maskScaleY = ' .. scale .. ' end)'
end

M['setMaskPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'
    local posY = '-(' .. CALC(params[3]) .. ')'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_objects[name].maskX = ' .. posX
    GAME.lua = GAME.lua .. '\n GAME_objects[name].maskY = ' .. posY .. ' end)'
end

M['pauseAnimation'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. ']:pause() end)'
end

M['setMaskHitTrue'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isHitTestMasked = true end)'
end

M['setMaskHitFalse'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_objects[' .. CALC(params[1]) .. '].isHitTestMasked = false end)'
end

return M
