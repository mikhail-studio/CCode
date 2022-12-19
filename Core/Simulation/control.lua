local CALC = require 'Core.Simulation.calc'
local M = {}

M['requestApi'] = function(params)
    local p1 = params[1][1][1]:gsub('\n', '\\n'):gsub('\r', ''):gsub('\'', '\\\'')
    p1 = UTF8.gsub(p1, 'setfenv', 'print')
    p1 = UTF8.gsub(p1, 'loadstring', 'print')
    p1 = UTF8.gsub(p1, 'currentStage', 'fps')
    p1 = UTF8.gsub(p1, 'getCurrentStage', 'getDefault')
    p1 = UTF8.gsub(p1, 'setFocus', 'display.getCurrentStage():setFocus')

    GAME.lua = GAME.lua .. ' pcall(function() local args = type(args) == \'table\' and JSON.encode(args) or \'{}\''
    GAME.lua = GAME.lua .. ' args = args:gsub(\'\\n\', \'\\\\n\'):gsub(\'\\r\', \'\'):gsub(\'\\\'\', \'\\\\\\\'\')'
    GAME.lua = GAME.lua .. ' return loadstring(\'local G = {} G.fun, G.device, G.other, G.math, G.prop = fun, device, other, math, prop'
    GAME.lua = GAME.lua .. ' G.args = JSON.decode(\\\'\' .. args .. \'\\\') for key, value in'
    GAME.lua = GAME.lua .. ' pairs(GET_GLOBAL_TABLE()) do G[key] = value end setfenv(1, G) ' .. p1 .. '\')() end)'
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
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.objects[' .. CALC(params[1]) .. ']:addEventListener(\'touch\', function(e)'
    GAME.lua = GAME.lua .. ' e.target._touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\' GAME.group.const.touch = e.target._touch'
    GAME.lua = GAME.lua .. ' GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y if e.target._touch then'
    GAME.lua = GAME.lua .. ' display.getCurrentStage():setFocus(e.target) else display.getCurrentStage():setFocus(nil) end'
    GAME.lua = GAME.lua .. ' local isComplete, result = pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e)'
    GAME.lua = GAME.lua .. ' end) return isComplete and result or false end) end)'
end

M['setLocalCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' GAME.group.objects[name].collision = function(s, e) local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. ' and result or false end GAME.group.objects[name]:addEventListener(\'collision\') end)'
end

M['setLocalPreCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' GAME.group.objects[name].preCollision = function(s, e) e.phase = \'pre\' local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. ' and result or false end GAME.group.objects[name]:addEventListener(\'preCollision\') end)'
end

M['setLocalPostCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' GAME.group.objects[name].postCollision = function(s, e) e.phase = \'post\' local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. ' and result or false end GAME.group.objects[name]:addEventListener(\'postCollision\') end)'
end

M['setGlobalCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.collis, function(e) local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isComplete and result or false'
    GAME.lua = GAME.lua .. ' end) Runtime:addEventListener(\'collision\', GAME.group.collis[#GAME.group.collis]) end)'
end

M['setGlobalPreCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.collis, function(e) e.phase = \'pre\' local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isComplete and result or false'
    GAME.lua = GAME.lua .. ' end) Runtime:addEventListener(\'preCollision\', GAME.group.collis[#GAME.group.collis]) end)'
end

M['setGlobalPostCollision'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.collis, function(e) e.phase = \'post\' local isComplete, result ='
    GAME.lua = GAME.lua .. ' pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isComplete and result or false'
    GAME.lua = GAME.lua .. ' end) Runtime:addEventListener(\'postCollision\', GAME.group.collis[#GAME.group.collis]) end)'
end

M['timer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.ts, timer.new(' .. CALC(params[1], '0.001')
    GAME.lua = GAME.lua .. ' * 1000, ' .. CALC(params[2], '1') .. ', function(e) if GAME.group then'
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
