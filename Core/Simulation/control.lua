local CALC = require 'Core.Simulation.calc'
local M = {}

M['requestApi'] = function(params, custom)
    local p1, p2 = params[1][1][1]:gsub('\n', '\\n'):gsub('\r', ''):gsub('\'', '\\\''), 'local args = {}'
    for i = 1, custom and #custom or 0 do p2 = p2 .. ' args[' .. i .. '] = ' .. CALC(custom[i]) end
    p1 = UTF8.gsub(p1, 'loadstring', 'print')
    p1 = UTF8.gsub(p1, 'currentStage', 'fps')
    p1 = UTF8.gsub(p1, 'getCurrentStage', 'getDefault')
    p1 = UTF8.gsub(p1, 'setFocus', 'display.getCurrentStage():setFocus')
    p2 = p2:gsub('\n', '\\n'):gsub('\r', ''):gsub('\'', '\\\'')

    GAME.lua = GAME.lua .. ' pcall(function() loadstring(\'local G = {} for key, value in pairs(GET_GLOBAL_TABLE())'
    GAME.lua = GAME.lua .. ' do G[key] = value end setfenv(1, G) ' .. p2 .. ' ' .. p1 .. '\')() end)'
end

M['requestFun'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. '() end)'
end

M['requestFunParams'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. '(' .. CALC(params[2]) .. ') end)'
end

M['setFocus'] = function(params)
    GAME.lua = GAME.lua .. ' display.getCurrentStage():setFocus(' .. CALC(params[1], 'nil') .. ')'
end

M['setFocusMultitouch'] = function(params)
    GAME.lua = GAME.lua .. ' display.getCurrentStage():setFocus(' .. CALC(params[1], 'nil') .. ', ' .. CALC(params[2], 'nil') .. ')'
end

M['activateMultitouch'] = function(params)
    GAME.lua = GAME.lua .. ' system.activate(\'multitouch\')'
end

M['deactivateMultitouch'] = function(params)
    GAME.lua = GAME.lua .. ' system.deactivate(\'multitouch\')'
end

M['toastShort'] = function(params)
    GAME.lua = GAME.lua .. ' GANIN.toast(' .. CALC(params[1], '\'\'') .. ', 0)'
end

M['toastLong'] = function(params)
    GAME.lua = GAME.lua .. ' GANIN.toast(' .. CALC(params[1], '\'\'') .. ', 1)'
end

M['returnValue'] = function(params)
    GAME.lua = GAME.lua .. ' return ' .. CALC(params[1])
end

M['requestExit'] = function(params)
    if CURRENT_LINK ~= 'App' then
        GAME.lua = GAME.lua .. ' pcall(function() if GAME.isStarted then EXITS.game() end end)'
    else
        GAME.lua = GAME.lua .. ' pcall(function() native.requestExit() end)'
    end
end

M['setListener'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. ']:addEventListener(\'touch\','
    GAME.lua = GAME.lua .. ' function(e) GAME.group.const.touch = e.phase ~= \'ended\' and'
    GAME.lua = GAME.lua .. ' e.phase ~= \'cancelled\' GAME.group.const.touch_x, GAME.group.const.touch_y, e.target._touch = e.x, e.y,'
    GAME.lua = GAME.lua .. ' GAME.group.const.touch return ' .. CALC(params[2], 'a', true) .. '(e) end) end)'
end

M['timer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.ts, timer.new(' .. CALC(params[1], '0.001')
    GAME.lua = GAME.lua .. ' * 1000, ' .. CALC(params[2], '1') .. ', function(e) print(1) if GAME.group then'
end

M['timerName'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.timers[' .. CALC(params[1]) .. '] = timer.new(' .. CALC(params[2], '0.001')
    GAME.lua = GAME.lua .. ' * 1000, ' .. CALC(params[3], '1') .. ', function(e) if GAME.group then'
end

M['timerEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end end)) end)'
end

M['timerNameEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end end) end)'
end

M['if'] = function(params)
    GAME.lua = GAME.lua .. ' if ' .. CALC(params[1]) .. ' then'
end

M['ifElse'] = function(params)
    GAME.lua = GAME.lua .. ' elseif ' .. CALC(params[1]) .. ' then'
end

M['ifEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end'
end

M['forever'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.ts, timer.new(1, 0, function(e) if GAME.group then'
end

M['foreverEnd'] = function(params)
    GAME.lua = GAME.lua .. ' end end)) end)'
end

M['for'] = function(params)
    local from, to = CALC(params[1]), CALC(params[2])
    local var, step = CALC(params[3], 'a', true), CALC(params[4], '1')

    GAME.lua = GAME.lua .. ' for i = ' .. from .. ', ' .. to .. ', ' .. step .. ' do ' .. var .. ' = i'
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

M['timerPause'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.pause(GAME.group.timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerResume'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.resume(GAME.group.timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerCancel'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.cancel(GAME.group.timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerPauseAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.pauseAll() end)'
end

M['timerResumeAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.resumeAll() end)'
end

M['timerCancelAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() timer.cancelAll() end)'
end

return M
