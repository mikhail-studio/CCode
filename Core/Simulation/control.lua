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

M['returnValue'] = function(params)
    GAME.lua = GAME.lua .. ' return (' .. CALC(params[1]) .. ')'
end

M['requestExit'] = function(params)
    if CURRENT_LINK ~= 'App' then
        GAME.lua = GAME.lua .. ' pcall(function() if GAME.isStarted then EXITS.game() end end)'
    else
        GAME.lua = GAME.lua .. ' pcall(function() native.requestExit() end)'
    end
end

M['requestFunParams'] = function(params)
    local nameFun, value = params[1][1][1], CALC(params[2])
    local typeFun = params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'](' .. value .. ') end)'
end

M['setListener'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1] and params[2][1][1] or ''
    local typeFun = (params[2][1] and params[2][1][2]) == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) local r1, r2 = pcall(function() GAME.group.const.touch = e.phase ~= \'ended\' and'
    GAME.lua = GAME.lua .. ' e.phase ~= \'cancelled\' GAME.group.const.touch_x, GAME.group.const.touch_y, e.target._touch = e.x, e.y,'
    GAME.lua = GAME.lua .. ' GAME.group.const.touch ' .. typeFun .. '[\'' .. nameFun .. '\'](e) end) return r2 end) end)'
end

M['setListener2'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1] and params[2][1][1] or ''
    local typeFun = (params[2][1] and params[2][1][2]) == 'fS' and 'funsS' or 'funsP'
    local nameFun2 = params[3][1] and params[3][1][1] or ''
    local typeFun2 = (params[3][1] and params[3][1][2]) == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) local r1, r2 = pcall(function() GAME.group.const.touch = e.phase ~= \'ended\' and'
    GAME.lua = GAME.lua .. ' e.phase ~= \'cancelled\' GAME.group.const.touch_x, GAME.group.const.touch_y, e.target._touch = e.x, e.y,'
    GAME.lua = GAME.lua .. ' GAME.group.const.touch ' .. typeFun .. '[\'' .. nameFun .. '\'](e) '
    GAME.lua = GAME.lua .. typeFun2 .. '[\'' .. nameFun2 .. '\'](e) end) return r2 end) end)'
end

M['setListener3'] = function(params)
    local nameObj = CALC(params[1])
    local nameFun = params[2][1] and params[2][1][1] or ''
    local typeFun = (params[2][1] and params[2][1][2]) == 'fS' and 'funsS' or 'funsP'
    local nameFun2 = params[3][1] and params[3][1][1] or ''
    local typeFun2 = (params[3][1] and params[3][1][2]) == 'fS' and 'funsS' or 'funsP'
    local nameFun3 = params[4][1] and params[4][1][1] or ''
    local typeFun3 = (params[4][1] and params[4][1][2]) == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. nameObj .. ']:addEventListener(\'touch\', '
    GAME.lua = GAME.lua .. ' function(e) local r1, r2 = pcall(function() GAME.group.const.touch = e.phase ~= \'ended\' and'
    GAME.lua = GAME.lua .. ' e.phase ~= \'cancelled\' GAME.group.const.touch_x, GAME.group.const.touch_y, e.target._touch = e.x, e.y,'
    GAME.lua = GAME.lua .. ' GAME.group.const.touch ' .. typeFun .. '[\'' .. nameFun .. '\'](e) '
    GAME.lua = GAME.lua .. typeFun2 .. '[\'' .. nameFun2 .. '\'](e) ' .. typeFun3 .. '[\'' .. nameFun3 .. '\'](e) end) return r2 end) end)'
end

M['timer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.new((' .. CALC(params[1], '0') .. ') * 1000, ' .. CALC(params[2], '1') .. ', function()'
end

M['timerEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end) end)'
end

M['if'] = function(params)
    GAME.lua = GAME.lua .. ' if (' .. CALC(params[1]) .. ') then'
end

M['ifElse'] = function(params)
    GAME.lua = GAME.lua .. ' elseif (' .. CALC(params[1]) .. ') then'
end

M['ifEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end'
end

M['forever'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.performWithDelay(0, function(e) if GAME.group then'
end

M['foreverEnd'] = function(params)
    GAME.lua = GAME.lua .. ' else timer.cancel(e.source) end end, 0) end)'
end

M['for'] = function(params)
    local type = (params[3][1] and params[3][1][2]) == 'vE' and 'varsE' or (params[3][1] and params[3][1][2]) == 'vS' and 'varsS' or 'varsP'
    local name, from, to, step = params[3][1] and params[3][1][1] or '', CALC(params[1]), CALC(params[2]), CALC(params[4], '1')

    GAME.lua = GAME.lua .. ' for i = ' .. from .. ', ' .. to .. ', ' .. step .. ' do ' .. type .. '[\'' .. name .. '\'] = i'
end

M['forEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end'
end

M['repeat'] = function(params)
    GAME.lua = GAME.lua .. ' for i = 1, ' .. CALC(params[1]) .. ' do'
end

M['repeatEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end'
end

return M
