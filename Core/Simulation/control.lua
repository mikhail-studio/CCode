local CALC = require 'Core.Simulation.calc'
local M = {}

M['requestApi'] = function(params)
    local p1 = params[1][1][1]
    p1 = UTF8.gsub(p1, 'currentStage', '')
    p1 = UTF8.gsub(p1, 'getCurrentStage', '')
    p1 = UTF8.gsub(p1, 'setFocus', 'display.getCurrentStage():setFocus')

    GAME.lua = GAME.lua .. ' pcall(function() loadstring(\'local G = {} for key, value in pairs(GET_GLOBAL_TABLE())'
    GAME.lua = GAME.lua .. ' do G[key] = value end setfenv(1, G) ' .. p1 .. '\')() end)'
end

M['requestFun'] = function(params)
    local name = params[1][1][1]
    local type = params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. type .. '[\'' .. name .. '\']() end)'
end

M['requestExit'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() native.requestExit() end)'
end

M['requestFunParams'] = function(params)
    local nameFun = params[1][1][1]
    local nameTable = params[2][1][1]
    local typeFun = params[1][1][2] == 'fS' and 'funsS' or 'funsP'
    local typeTable = params[2][1][2] == 'tE' and 'tablesE' or params[2][1][2] == 'tS' and 'tablesS' or 'tablesP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'](' .. typeTable .. '[\'' .. nameTable .. '\']) end)'
end

M['setListener'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1][1]
    local typeFun = params[2][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) GAME.group.const.touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\''
    GAME.lua = GAME.lua .. ' GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y '
    GAME.lua = GAME.lua .. typeFun .. '[\'' .. nameFun .. '\'](e) end) end)'
end

M['setListener2'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1][1]
    local typeFun = params[2][1][2] == 'fS' and 'funsS' or 'funsP'
    local nameFun2 = params[3][1][1]
    local typeFun2 = params[3][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) GAME.group.const.touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\''
    GAME.lua = GAME.lua .. ' GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y '
    GAME.lua = GAME.lua .. typeFun .. '[\'' .. nameFun .. '\'](e) ' .. typeFun2 .. '[\'' .. nameFun2 .. '\'](e) end) end)'
end

M['setListener3'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1][1]
    local typeFun = params[2][1][2] == 'fS' and 'funsS' or 'funsP'
    local nameFun2 = params[3][1][1]
    local typeFun2 = params[3][1][2] == 'fS' and 'funsS' or 'funsP'
    local nameFun3 = params[4][1][1]
    local typeFun3 = params[4][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) GAME.group.const.touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\''
    GAME.lua = GAME.lua .. ' GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y ' .. typeFun .. '[\'' .. nameFun .. '\'](e) '
    GAME.lua = GAME.lua .. typeFun2 .. '[\'' .. nameFun2 .. '\'](e) ' .. typeFun3 .. '[\'' .. nameFun3 .. '\'](e) end) end)'
end

M['timer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.new((' .. CALC(params[1], '0') .. ' * 1000), ' .. CALC(params[2], '1') .. ', function()'
end

M['timerEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end) end)'
end

M['if'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() if (' .. CALC(params[1]) .. ') then'
end

M['ifEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end end)'
end

M['forever'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.performWithDelay(0, function()'
end

M['foreverEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end, 0) end)'
end

M['for'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() for i = 1, ' .. CALC(params[1]) .. ' do'
end

M['forEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end end)'
end

return M
