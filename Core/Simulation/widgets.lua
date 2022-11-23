local CALC = require 'Core.Simulation.calc'
local M = {}

M['setWidgetPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[3]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name ..'].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setWidgetSize'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() if GAME.group.widgets[' .. name .. ']._type == \'slider\' then'
    GAME.lua = GAME.lua .. ' local widget = GAME.group.widgets[' .. name .. ']'
    GAME.lua = GAME.lua .. ' local type, posX, posY, value = widget.type, widget._x, widget._y, widget.value'
    GAME.lua = GAME.lua .. ' local size = type == \'horizontal\' and ' .. width .. ' or ' .. height
    GAME.lua = GAME.lua .. ' if size == 0 then size = type == \'horizontal\' and widget.width or widget.height end'
    GAME.lua = GAME.lua .. ' pcall(function() widget:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '] = WIDGET.newSlider({x = posX, y = posY, value = value,'
    GAME.lua = GAME.lua .. ' [type == \'horizontal\' and \'width\' or \'height\'] = size, orientation = type or \'vertical\'})'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].type = type GAME.group.widgets[' .. name .. ']._type = \'slider\''
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.widgets[' .. name .. '])'
    GAME.lua = GAME.lua .. ' else GAME.group.widgets[' .. name .. '].width = ' .. width
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].height = ' .. height .. ' end end)'
end

M['removeWidget'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

M['newWebView'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'https://google.com\'')
    local width = CALC(params[3])
    local height = CALC(params[4])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. '] = native.newWebView(CENTER_X, CENTER_Y, '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') GAME.group.widgets[' .. name .. ']:request(' .. link .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']:addEventListener(\'urlRequest\', function(e)'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].url = e.url end)'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._type = \'webview\' GAME.group:insert(GAME.group.widgets[' .. name .. ']) end)'
end

M['newHSlider'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2], '100')
    local posX = '(CENTER_X + (' .. CALC(params[3]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. '] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. ' value = 50, width = ' .. width .. '}) GAME.group.widgets[' .. name .. '].type = \'horizontal\''
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._x, GAME.group.widgets[' .. name .. ']._y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._type = \'slider\' GAME.group:insert(GAME.group.widgets[' .. name .. ']) end)'
end

M['newVSlider'] = function(params)
    local name = CALC(params[1])
    local height = CALC(params[2], '100')
    local posX = '(CENTER_X + (' .. CALC(params[3]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. '] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. ' value = 50, height = ' .. height .. ', orientation = \'vertical\'})'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._x, GAME.group.widgets[' .. name .. ']._y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._type = \'slider\' GAME.group:insert(GAME.group.widgets[' .. name .. ']) end)'
end

M['newField'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local type = CALC(params[3], '\'default\'')
    local color = CALC(params[4], '{255}')
    local fontSize = CALC(params[5], '25')
    local isBackground = CALC(params[6], 'true')
    local align = CALC(params[7], '\'left\'')
    local font = CALC(params[8], '\'ubuntu\'')
    local posX = '(CENTER_X + (' .. CALC(params[11]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[12]) .. '))'
    local width, height = CALC(params[9]), CALC(params[10])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:removeSelf() end) pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '] = native.newTextField(' .. posX .. ', ' .. posY .. ', ' .. width .. ','
    GAME.lua = GAME.lua .. ' ' .. height .. ') GAME.group.widgets[' .. name .. '].placeholder = tostring(' .. placeholder .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].align = ' .. align .. ' GAME.group.widgets[' .. name .. ']._type = \'field\''
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].inputType = ' .. type .. ' local colors = ' .. color
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.widgets[' .. name .. ']) end)'
end

M['newBox'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local color = CALC(params[3], '{255}')
    local fontSize = CALC(params[4], '25')
    local isBackground = CALC(params[5], 'true')
    local align = CALC(params[6], '\'left\'')
    local font = CALC(params[7], '\'ubuntu\'')
    local posX = '(CENTER_X + (' .. CALC(params[10]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[11]) .. '))'
    local width, height = CALC(params[8]), CALC(params[9])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. '] = native.newTextBox(' .. posX .. ', ' .. posY .. ','
    GAME.lua = GAME.lua .. ' ' .. width .. ', ' .. height .. ') GAME.group.widgets[' .. name .. '].placeholder = ' .. placeholder
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].align = ' .. align .. ' local colors = ' .. colors
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']._type = \'field\' GAME.group.widgets[' .. name .. '].isEditable = true'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. '].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' .. name .. ']:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.widgets[' .. name .. ']) end)'
end

M['setWebViewLink'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'google.com\'')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. name .. ']:request(' .. link .. ') end)'
end

M['setWebViewFront'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. ']:forward() end)'
end

M['setWebViewBack'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. ']:back() end)'
end

M['updWebViewSite'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. ']:reload() end)'
end

M['setSliderValue'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local value = tonumber(' ..  CALC(params[2]) .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.widgets[' ..  CALC(params[1]) .. ']:setValue(value > 100 and 100 or value < 0 and 0 or value) end)'
end

M['setFieldSecure'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. '].isSecure = true end)'
end

M['setFieldText'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. '].text = ' .. CALC(params[2]) .. ' end)'
end

M['setFieldRule'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.widgets[' .. CALC(params[1]) .. '].isEditable = ' .. CALC(params[2]) .. ' end)'
end

return M
