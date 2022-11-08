local CALC = require 'Core.Simulation.calc'
local M = {}

M['newField'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local type = CALC(params[3], '\'default\'')
    local color = CALC(params[4], '{255}')
    local fontSize = CALC(params[5], '25')
    local isBackground = CALC(params[6], 'true')
    local align = CALC(params[7], '\'left\'')
    local font = CALC(params[8], '\'ubuntu\'')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. '] = native.newTextField(CENTER_X, CENTER_Y, 400, 80)'
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].placeholder = tostring(' .. placeholder .. ') local colors = ' .. color
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].align = ' .. align .. ' GAME.group.fields[' .. name .. '].inputType = ' .. type
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. ']:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.fields[' .. name .. ']) end)'
end

M['newBox'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local color = CALC(params[3], '{255}')
    local fontSize = CALC(params[4], '25')
    local isBackground = CALC(params[5], 'true')
    local align = CALC(params[6], '\'left\'')
    local font = CALC(params[7], '\'ubuntu\'')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. '] = native.newTextBox(CENTER_X, CENTER_Y, 400, 80) '
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].placeholder = ' .. placeholder .. ' local colors = ' .. colors
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ') '
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].align = ' .. align .. ' GAME.group.fields[' .. name .. '].isEditable = true'
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. ']:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.fields[' .. name .. ']) end)'
end

M['setFieldPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[3]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. '].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setFieldSize'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. name .. '].width = ' .. width
    GAME.lua = GAME.lua .. ' GAME.group.fields[' .. name .. '].height = ' .. height .. ' end)'
end

M['setFieldText'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. CALC(params[1]) .. '].text = ' .. CALC(params[2]) .. ' end)'
end

M['setFieldRule'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. CALC(params[1]) .. '].isEditable = ' .. CALC(params[2]) .. ' end)'
end

M['removeField'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.fields[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

return M
