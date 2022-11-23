local CALC = require 'Core.Simulation.calc'
local M = {}

M['newWebView'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'https://google.com\'')
    local width = CALC(params[3])
    local height = CALC(params[4])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. '] = native.newWebView(CENTER_X, CENTER_Y, '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') GAME.group.webviews[' .. name .. ']:request(' .. link .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.webviews[' .. name .. ']:addEventListener(\'urlRequest\', function(e) GAME.group.webviews.url = e.url'
    GAME.lua = GAME.lua .. ' end) end) GAME.group:insert(GAME.group.webviews[' .. name .. ']) end)'
end

M['setWebViewPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[3]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name ..'].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.webviews[' .. name .. '].y = ' .. posY .. ' end)'
end

M['setWebViewSize'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. '].width = ' .. width
    GAME.lua = GAME.lua .. ' GAME.group.webviews[' .. name .. '].height = ' .. height .. ' end)'
end

M['setWebViewLink'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'google.com\'')

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. ']:request(' .. link .. ') end)'
end

M['setWebViewFront'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. CALC(params[1]) .. ']:forward() end)'
end

M['setWebViewBack'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. CALC(params[1]) .. ']:back() end)'
end

M['updWebViewSite'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. CALC(params[1]) .. ']:reload() end)'
end

M['removeWebView'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

M['newHSlider'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2], '100')
    local posX = '(CENTER_X + (' .. CALC(params[3]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. name .. '] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. ' value = 50, width = ' .. width .. '}) GAME.group.sliders[' .. name .. '].type = \'horizontal\''
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.sliders[' .. name .. ']) end)'
end

M['newVSlider'] = function(params)
    local name = CALC(params[1])
    local height = CALC(params[2], '100')
    local posX = '(CENTER_X + (' .. CALC(params[3]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[4]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. name .. '] = WIDGET.newSlider({x = ' .. posX .. ', y = ' .. posY .. ','
    GAME.lua = GAME.lua .. ' value = 50, height = ' .. height .. ', orientation = \'vertical\'})'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.sliders[' .. name .. ']) end)'
end

M['setSliderPos'] = function(params)
    local name = CALC(params[1])
    local posX = '(CENTER_X + (' .. CALC(params[2]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[3]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. name .. '].x = ' .. posX
    GAME.lua = GAME.lua .. ' GAME.group.sliders[' .. name .. '].y = ' .. posY .. ' end)'
end

M['removeSlider'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.sliders[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

M['setSliderValue'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local value = tonumber(' ..  CALC(params[2]) .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.sliders[' ..  CALC(params[1]) .. ']:setValue(value > 100 and 100 or value < 0 and 0 or value) end)'
end

return M
