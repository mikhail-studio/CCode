local CALC = require 'Core.Simulation.calc'
local M = {}

M['setWidgetPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(SET_X(' .. CALC(params[2]) .. ', GAME_widgets[name]))'
    local posY = '(SET_Y(' .. CALC(params[3]) .. ', GAME_widgets[name]))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_widgets[name].x = ' .. posX
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].y = ' .. posY .. ' end)'
end

M['setWidgetSize'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' if GAME_widgets[name].wtype == \'slider\' then'
    GAME.lua = GAME.lua .. '\n local widget = GAME_widgets[name]'
    GAME.lua = GAME.lua .. '\n local type, posX, posY, value = widget.type, widget._x, widget._y, widget.value'
    GAME.lua = GAME.lua .. '\n local size = type == \'horizontal\' and ' .. width .. ' or ' .. height
    GAME.lua = GAME.lua .. '\n if size == 0 then size = type == \'horizontal\' and widget.width or widget.height end'
    GAME.lua = GAME.lua .. '\n pcall(function() widget:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = WIDGET.newSlider({x = posX, y = posY, value = value,'
    GAME.lua = GAME.lua .. '\n [type == \'horizontal\' and \'width\' or \'height\'] = size, orientation = type or \'vertical\'})'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].type = type GAME_widgets[name].wtype = \'slider\''
    GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_widgets[name])'
    GAME.lua = GAME.lua .. '\n elseif GAME_widgets[name].wtype ~= \'switch\' then GAME_widgets[name].width = ' .. width
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].height = ' .. height .. ' end end)'
end

M['setWidgetListener'] = function(params)
    local name = CALC(params[1])
    local fun = CALC(params[2], 'a', true)

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' if GAME_widgets[name].wtype == \'webview\' then'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:addEventListener(\'urlRequest\', function(e) pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].url = e.url ' .. fun .. '(e, name) end) end)'
    GAME.lua = GAME.lua .. '\n elseif GAME_widgets[name].wtype == \'field\' then'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:addEventListener(\'userInput\', function(e)'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then pcall(function() ' .. fun .. '(e, name) end) end end) end end)'
end

M['removeWidget'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' '
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:removeSelf() GAME_widgets[name] = nil end)'
end

M['showWidget'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' timer.new(10, 1, function()'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[name].isVisible = true end) end) end)'
end

M['hideWidget'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1]) .. ' timer.new(10, 1, function()'
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[name].isVisible = false end) end) end)'
end

M['newWebView'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'https://google.com\'')
    local width = CALC(params[3])
    local height = CALC(params[4])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function()'
    GAME.lua = GAME.lua .. '\n local random_widget = GAME_widgets[name] GAME_widgets[name]'
    GAME.lua = GAME.lua .. '\n = nil timer.new(20, 1, function() pcall(function() random_widget:removeSelf() end) end) end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = native.newWebView(CENTER_X, CENTER_Y, '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') GAME_widgets[name]:request(' .. link .. ')'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:addEventListener(\'urlRequest\', function(e)'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then GAME_widgets[name].url = e.url end end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].wtype = \'webview\' GAME.group:insert(GAME_widgets[name]) end)'
end

M['newScrollView'] = function(params)
    local name, listener, friction = CALC(params[1]), CALC(params[3], 'a', true), CALC(params[5], '0.972')
    local horizontalScrollDisabled = '(not ' .. CALC(params[6], 'true') .. ')'
    local verticalScrollDisabled = '(not ' .. CALC(params[7], 'true') .. ')'
    local colors, isBounceEnabled = CALC(params[8], '{255, 255, 255}'), CALC(params[4], 'true')
    local hideBackground = '(not ' .. CALC(params[9], 'true') .. ')'
    local hideScrollBar = '(not ' .. CALC(params[2], 'true') .. ')'
    local posX = '(SET_X(' .. CALC(params[12]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[13]) .. '))'
    local width, height = CALC(params[10]), CALC(params[11])

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_widgets[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n local colors = ' .. colors .. ' GAME_widgets[name] = WIDGET.newScrollView({x = ' .. posX .. ','
    GAME.lua = GAME.lua .. '\n y = ' .. posY .. ', width = ' .. width .. ', horizontalScrollDisabled = ' .. horizontalScrollDisabled .. ','
    GAME.lua = GAME.lua .. '\n friction = ' .. friction .. ', isBounceEnabled = ' .. isBounceEnabled .. ', listener = function(e)'
    GAME.lua = GAME.lua .. '\n pcall(function() e.target = nil ' .. listener .. '(e) end) end,'
    GAME.lua = GAME.lua .. '\n verticalScrollDisabled = ' .. verticalScrollDisabled .. ', hideScrollBar = ' .. hideScrollBar .. ','
    GAME.lua = GAME.lua .. '\n hideBackground = ' .. hideBackground .. ', backgroundColor = {colors[1]/255, colors[2]/255, colors[3]/255},'
    GAME.lua = GAME.lua .. '\n height = ' .. height .. '}) GAME_widgets[name].wtype = \'scroll\' GAME_widgets[name].name = name end)'
end

M['newSwitch'] = function(params)
    local name = CALC(params[1])
    local style = CALC(params[2], '\'checkbox\'')
    local state = CALC(params[3], 'false')
    local width = style == '(select[\'switchToggle\']())' and CALC(params[4], '250') or CALC(params[4], '100')
    local height = style == '(select[\'switchToggle\']())' and CALC(params[5], '50') or CALC(params[5], '100')
    local posX = '(SET_X(' .. CALC(params[6]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[7]) .. '))'
    local onPress = CALC(params[8], 'a', true)
    local onRelease = CALC(params[9], 'a', true)

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_widgets[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = WIDGET.newSwitch({style = ' .. style .. ','
    GAME.lua = GAME.lua .. '\n x = ' .. posX .. ', y = ' .. posY .. ', initialSwitchState = ' .. state .. ', onPress = ' .. onPress .. ','
    GAME.lua = GAME.lua .. '\n onRelease = ' .. onRelease .. '}) GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].width, GAME_widgets[name].height = ' .. width .. ',' .. height
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].wtype = \'switch\' GAME.group:insert(GAME_widgets[name]) end)'
end

M['newHSlider'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2], '100')
    local fun = CALC(params[3], 'a', true)
    local posX = '(SET_X(' .. CALC(params[4]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[5]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_widgets[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. '\n value = 50, width = ' .. width .. ', listener = function(e) if GAME.hash == hash then pcall(function() '
    GAME.lua = GAME.lua .. fun .. '(e.value) end) end end}) GAME_widgets[name].type = \'horizontal\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._x, GAME_widgets[name]._y = GAME_widgets[name].x, GAME_widgets[name].y'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].wtype = \'slider\' GAME.group:insert(GAME_widgets[name]) end)'
end

M['newVSlider'] = function(params)
    local name = CALC(params[1])
    local height = CALC(params[2], '100')
    local fun = CALC(params[3], 'a', true)
    local posX = '(SET_X(' .. CALC(params[4]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[5]) .. '))'

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_widgets[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. '\n value = 50, height = ' .. height .. ', listener = function(e) if GAME.hash == hash then pcall(function() '
    GAME.lua = GAME.lua .. fun .. '(e.value) end) end end, orientation = \'vertical\'}) GAME_widgets[name].type = \'vertical\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._x, GAME_widgets[name]._y = GAME_widgets[name].x, GAME_widgets[name].y'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].wtype = \'slider\' GAME.group:insert(GAME_widgets[name]) end)'
end

M['newField'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local type = CALC(params[3], '\'default\'')
    local colors = CALC(params[4], '{255, 255, 255}')
    local fontSize = CALC(params[5], '25')
    local isBackground = CALC(params[6], 'true')
    local align = CALC(params[7], '\'left\'')
    local font = CALC(params[8], '\'ubuntu\'')
    local posX = '(SET_X(' .. CALC(params[11]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[12]) .. '))'
    local width, height = CALC(params[9], '400'), CALC(params[10], '80')

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function()'
    GAME.lua = GAME.lua .. '\n local random_widget = GAME_widgets[name] GAME_widgets[name]'
    GAME.lua = GAME.lua .. '\n = nil timer.new(20, 1, function() pcall(function() random_widget:removeSelf() end) end) end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = native.newTextField(' .. posX .. ', ' .. posY .. ', ' .. width .. ','
    GAME.lua = GAME.lua .. '\n ' .. height .. ') GAME_widgets[name].placeholder = tostring' .. placeholder
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ')'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].align = ' .. align .. ' GAME_widgets[name].wtype = \'field\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].inputType = ' .. type .. ' local colors = ' .. colors
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_widgets[name]) end)'
end

M['newBox'] = function(params)
    local name = CALC(params[1])
    local placeholder = CALC(params[2])
    local colors = CALC(params[3], '{255, 255, 255}')
    local fontSize = CALC(params[4], '25')
    local isBackground = CALC(params[5], 'true')
    local align = CALC(params[6], '\'left\'')
    local font = CALC(params[7], '\'ubuntu\'')
    local posX = '(SET_X(' .. CALC(params[10]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[11]) .. '))'
    local width, height = CALC(params[8], '400'), CALC(params[9], '80')

    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function()'
    GAME.lua = GAME.lua .. '\n local random_widget = GAME_widgets[name] GAME_widgets[name]'
    GAME.lua = GAME.lua .. '\n = nil timer.new(20, 1, function() pcall(function() random_widget:removeSelf() end) end) end)'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name] = native.newTextBox(' .. posX .. ', ' .. posY .. ','
    GAME.lua = GAME.lua .. '\n ' .. width .. ', ' .. height .. ') GAME_widgets[name].placeholder = tostring' .. placeholder
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].font = native.newFont(other.getFont(' .. font .. '), ' .. fontSize .. ')'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].align = ' .. align .. ' local colors = ' .. colors
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]._tag = \'TAG\''
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].wtype = \'field\' GAME_widgets[name].isEditable = true'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name].hasBackground = ' .. isBackground .. ' pcall(function()'
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:setTextColor(colors[1]/255, colors[2]/255, colors[3]/255) end)'
    GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_widgets[name]) end)'
end

M['setWebViewLink'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'google.com\'')

    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. name .. ']:request(' .. link .. ') end)'
end

M['setWebViewFront'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. ']:forward() end)'
end

M['setWebViewBack'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. ']:back() end)'
end

M['updWebViewSite'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. ']:reload() end)'
end

M['setSliderValue'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local value = tonumber(' ..  CALC(params[2]) .. ')'
    GAME.lua = GAME.lua .. '\n GAME_widgets[' ..  CALC(params[1]) .. ']:setValue(value > 100 and 100 or value < 0 and 0 or value) end)'
end

M['setSwitchState'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets['
    GAME.lua = GAME.lua .. CALC(params[1]) .. ']:setState({isOn = ' .. CALC(params[2], 'false') .. '}) end)'
end

M['insertToScroll'] = function(params)
    local scroll = CALC(params[1])
    local name = CALC(params[2])
    local type = CALC(params[3], 'GAME_objects')

    if type == '(select[\'obj\']())' then type = 'GAME_objects'
    elseif type == '(select[\'text\']())' then type = 'GAME_texts'
    elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
    elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
    elseif type == '(select[\'group\']())' then type = 'GAME_groups'
    elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

    GAME.lua = GAME.lua .. '\n pcall(function() local _scroll, name = ' .. scroll .. ', ' .. name
    GAME.lua = GAME.lua .. '\n local obj, scroll = ' .. type .. '[name], GAME_widgets[_scroll] local function doTo(obj)'
    GAME.lua = GAME.lua .. '\n local _x, _y = GET_X(obj.x, obj), GET_Y(obj.y, obj) scroll:insert(obj) obj._scroll = _scroll'
    GAME.lua = GAME.lua .. '\n obj.x = SET_X(_x, obj) obj.y = SET_Y(_y, obj) end if \'' .. type .. '\' == \'GAME_tags\' then'
    GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then'
    GAME.lua = GAME.lua .. '\n doTag(child[1]) else doTo(GAME.group[child[2]][child[1]]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['takeFocusScroll'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name, event = ' .. CALC(params[1]) .. ', ' .. CALC(params[2])
    GAME.lua = GAME.lua .. '\n GAME_widgets[name]:takeFocus(event._ccode_event) end)'
end

M['setFieldSecure'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. '].isSecure = true end)'
end

M['removeFieldSecure'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. '].isSecure = false end)'
end

M['setFieldText'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. '].text = ' .. CALC(params[2]) .. ' end)'
end

M['setFieldRule'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_widgets[' .. CALC(params[1]) .. '].isEditable = ' .. CALC(params[2]) .. ' end)'
end

M['setFieldFocus'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() native.setKeyboardFocus(GAME_widgets[' .. CALC(params[1]) .. ']) end)'
end

M['setFieldFocusNil'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() native.setKeyboardFocus(nil) end)'
end

M['hidePanelInterface'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() native.setProperty(\'androidSystemUiVisibility\', \'immersiveSticky\') end)'
end

M['showPanelInterface'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() native.setProperty(\'androidSystemUiVisibility\', \'default\') end)'
end

return M
