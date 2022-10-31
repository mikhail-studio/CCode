local CALC = require 'Core.Simulation.calc'
local M = {}

M['newWebView'] = function(params)
    local name = CALC(params[1])
    local link = CALC(params[2], '\'google.com\'')
    local width = CALC(params[3])
    local height = CALC(params[4])

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. ']:removeSelf() end)'
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.webviews[' .. name .. '] = native.newWebView(CENTER_X, CENTER_Y, '
    GAME.lua = GAME.lua .. width .. ', ' .. height .. ') GAME.group.webviews[' .. name .. ']:request(' .. link .. ')'
    GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.webviews[' .. name .. ']) end)'
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

return M
