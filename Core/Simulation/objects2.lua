local CALC = require 'Core.Simulation.calc'
local M = {}

M['setSprite'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() local link, filter = other.getImage(' .. link .. ')'
    GAME.lua = GAME.lua .. ' display.setDefault(\'magTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' display.setDefault(\'minTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' local image = display.newImage(tostring(link), system.DocumentsDirectory)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._width = image.width'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._height = image.height'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._link = tostring(link)'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']._name = ' .. link
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].fill = {type = \'image\', filename = tostring(link),'
    GAME.lua = GAME.lua .. ' baseDir = system.DocumentsDirectory} image:removeSelf() image = nil end)'
end

M['setScale'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].xScale = ' .. scale
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. nameObject .. '].yScale = ' .. scale .. ' end)'
end

M['setScaleX'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].xScale = ' .. scale .. ' end)'
end

M['setScaleY'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].yScale = ' .. scale .. ' end)'
end

M['newSeqAnimation'] = function(params)
    local name, direction = CALC(params[1]), CALC(params[2], '\'forward\'')
    local startFrame, countFrame = CALC(params[3], '1'), CALC(params[4], '1')
    local countRepeat, time = CALC(params[5], '0'), '(' .. CALC(params[6], '0') .. ') * 1000'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.animations[' .. name .. '] = {name = ' .. name .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ', loopDirection = ' .. direction .. ', start = ' .. startFrame .. ','
    GAME.lua = GAME.lua .. ' count = ' .. countFrame .. ', loopCount = ' .. countRepeat .. '} end)'
end

M['newParAnimation'] = function(params)
    local tableFrames, name, direction = CALC(params[1], '{1}'), CALC(params[2]), CALC(params[3], '\'forward\'')
    local countRepeat, time = CALC(params[4], '0'), '(' .. CALC(params[5], '0') .. ') * 1000'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.animations[' .. name .. '] ='
    GAME.lua = GAME.lua .. ' {name = ' .. name .. ', time = ' .. time .. ', frames = ' .. tableFrames .. ','
    GAME.lua = GAME.lua .. ' loopDirection = ' .. direction .. ', loopCount = ' .. countRepeat .. '} end)'
end

M['playAnimation'] = function(params)
    local nameObject, nameAnimation = CALC(params[1]), CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. ']:setSequence(' .. nameAnimation .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. nameObject .. ']:play() end)'
end

M['setColor'] = function(params)
    local name = CALC(params[1])
    local colors = CALC(params[2], '{255}')

    GAME.lua = GAME.lua .. ' pcall(function() local colors = ' .. colors
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. ']:setFillColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
end

M['newMask'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() local link, filter = other.getImage(' .. link .. ')'
    GAME.lua = GAME.lua .. ' display.setDefault(\'magTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' display.setDefault(\'minTextureFilter\', filter)'
    GAME.lua = GAME.lua .. ' GAME.group.masks[' .. name .. '] = graphics.newMask(link, system.DocumentsDirectory) end)'
end

M['addMaskToObject'] = function(params)
    local nameObject = CALC(params[1])
    local nameMask = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. ']:setMask(GAME.group.masks[' .. nameMask .. ']) end)'
end

M['addMaskToGroup'] = function(params)
    local nameGroup = CALC(params[1])
    local nameMask = CALC(params[2])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:setMask(GAME.group.masks[' .. nameMask .. ']) end)'
end

M['setMaskScale'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].maskScaleX = ' .. scale
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. nameObject .. '].maskScaleY = ' .. scale .. ' end)'
end

M['setMaskScaleX'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].maskScaleX = ' .. scale .. ' end)'
end

M['setMaskScaleY'] = function(params)
    local nameObject = CALC(params[1])
    local scale = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObject .. '].maskScaleY = ' .. scale .. ' end)'
end

M['setMaskPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'
    local posY = '-(' .. CALC(params[3]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. name .. '].maskX = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.objects[' .. name .. '].maskY = ' .. posY .. ' end)'
end

M['pauseAnimation'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. ']:pause() end)'
end

M['setMaskHitTrue'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isHitTestMasked = true end)'
end

M['setMaskHitFalse'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. '].isHitTestMasked = false end)'
end

return M