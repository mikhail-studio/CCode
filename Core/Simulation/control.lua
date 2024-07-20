local CALC = require 'Core.Simulation.calc'
local M = {}

M['requestApi'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local args = type(args) == \'table\' and JSON.encode(args) or \'{}\''
    GAME.lua = GAME.lua .. '\n args = args:gsub(\'\\n\', \'\\\\n\'):gsub(\'\\r\', \'\'):gsub(\'\\\'\', \'\\\\\\\'\')'
    GAME.lua = GAME.lua .. '\n local p1 = ' .. CALC(params[1], nil, nil, true)
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'setfenv\', \'print\') p1 = UTF8.gsub(p1, \'loadstring\', \'print\')'
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'currentStage\', \'fps\') p1 = UTF8.gsub(p1, \'getCurrentStage\', \'getDefault\')'
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'setFocus\', \'display.getCurrentStage():setFocus\')'
    GAME.lua = GAME.lua .. '\n G_fun, G_device, G_other, G_math, G_prop = fun, device, other, math, prop'
    GAME.lua = GAME.lua .. '\n G_varsE, G_varsS, G_varsP, G_funsS, G_funsP = varsE, varsS, varsP, funsS, funsP'
    GAME.lua = GAME.lua .. '\n G_tablesE, G_tablesS, G_tablesP = tablesE, tablesS, tablesP'
    GAME.lua = GAME.lua .. '\n return loadstring(\'local G = {} G.args = JSON.decode(\\\'\' .. args .. \'\\\') for key, value in '
    GAME.lua = GAME.lua .. 'pairs(GET_GLOBAL_TABLE()) do G[key] = value end setfenv(1, G) require = function(path) '
    GAME.lua = GAME.lua .. 'return (path:find(\\\'%.\\\') or path:find(\\\'io\\\') or path:find(\\\'os\\\') or path:find(\\\'lfs\\\') '
    GAME.lua = GAME.lua .. 'or path:find(\\\'starter\\\')) and {} or print5(path) end \' .. p1)() end)'
end

M['requestApiRes'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local link = other.getResource(' .. CALC(params[1]) .. ')'
    GAME.lua = GAME.lua .. '\n local args = type(args) == \'table\' and JSON.encode(args) or \'{}\''
    GAME.lua = GAME.lua .. '\n args = args:gsub(\'\\n\', \'\\\\n\'):gsub(\'\\r\', \'\'):gsub(\'\\\'\', \'\\\\\\\'\') local p1 ='
    GAME.lua = GAME.lua .. '\n READ_FILE(DOC_DIR .. \'/\' .. link)'
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'setfenv\', \'print\') p1 = UTF8.gsub(p1, \'loadstring\', \'print\')'
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'currentStage\', \'fps\') p1 = UTF8.gsub(p1, \'getCurrentStage\', \'getDefault\')'
    GAME.lua = GAME.lua .. '\n p1 = UTF8.gsub(p1, \'setFocus\', \'display.getCurrentStage():setFocus\')'
    GAME.lua = GAME.lua .. '\n G_fun, G_device, G_other, G_math, G_prop = fun, device, other, math, prop'
    GAME.lua = GAME.lua .. '\n G_varsE, G_varsS, G_varsP, G_funsS, G_funsP = varsE, varsS, varsP, funsS, funsP'
    GAME.lua = GAME.lua .. '\n G_tablesE, G_tablesS, G_tablesP = tablesE, tablesS, tablesP'
    GAME.lua = GAME.lua .. '\n return loadstring(\'local G = {} G.args = JSON.decode(\\\'\' .. args .. \'\\\') for key, value in '
    GAME.lua = GAME.lua .. 'pairs(GET_GLOBAL_TABLE()) do G[key] = value end setfenv(1, G) require = function(path) '
    GAME.lua = GAME.lua .. 'return (path:find(\\\'%.\\\') or path:find(\\\'io\\\') or path:find(\\\'os\\\') or path:find(\\\'lfs\\\') '
    GAME.lua = GAME.lua .. 'or path:find(\\\'starter\\\')) and {} or print5(path) end \' .. p1)() end)'
end

M['requestApiThread'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local luaCode = \'local json = dofile("' .. system.pathForFile('json.nse') .. '")'
    GAME.lua = GAME.lua .. '\n local _, result = pcall(function() \' .. ' .. CALC(params[1]) .. ' .. \' end) print(result)\''
    GAME.lua = GAME.lua .. '\n GANIN.thread(DOC_DIR, luaCode, function(e) if GAME.hash == hash'
    GAME.lua = GAME.lua .. '\n then ' .. CALC(params[2], 'a', true) .. '({result = e.result}) end end) end)'
end

M['requestFun'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. '() end)'
end

M['requestFunNoob'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. '() end)'
end

M['requestFunParams'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. '(' .. CALC(params[2], nil, true) .. ') end)'
end

M['setFocus'] = function(params)
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(GAME_objects[' .. CALC(params[1], 'nil') .. '])'
end

M['setFocusMultitouch'] = function(params)
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(GAME_objects['
    GAME.lua = GAME.lua .. CALC(params[1], 'nil') .. '], ' .. CALC(params[2], 'nil') .. ')'
end

M['activateMultitouch'] = function(params)
    GAME.lua = GAME.lua .. '\n GAME.multi = true system.activate(\'multitouch\')'
end

M['deactivateMultitouch'] = function(params)
    GAME.lua = GAME.lua .. '\n GAME.multi = false system.deactivate(\'multitouch\')'
end

M['toastShort'] = function(params)
    GAME.lua = GAME.lua .. '\n GANIN.toast(' .. CALC(params[1], '\'\'') .. ', 0)'
end

M['toastLong'] = function(params)
    GAME.lua = GAME.lua .. '\n GANIN.toast(' .. CALC(params[1], '\'\'') .. ', 1)'
end

M['returnValue'] = function(params)
    GAME.lua = GAME.lua .. '\n return ' .. CALC(params[1])
end

M['requestExit'] = function(params)
    if CURRENT_LINK ~= 'App' then
        GAME.lua = GAME.lua .. '\n pcall(function() if GAME.isStarted then EXITS.game() end end)'
    else
        GAME.lua = GAME.lua .. '\n pcall(function() native.requestExit() end)'
    end
end

M['setListener'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n table.insert(GAME_objects[name]._listeners, ' .. CALC(params[2], 'a', true) .. ')'
    GAME.lua = GAME.lua .. '\n if not GAME_objects[name].hasListener then GAME_objects[name].hasListener = true'
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:addEventListener(\'touch\','
    GAME.lua = GAME.lua .. '\n function(e) local isComplete, result = pcall(function() if GAME.hash == hash then handlerTouch(e)'
    GAME.lua = GAME.lua .. '\n e.isTouch = e.target._touch GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y'
    GAME.lua = GAME.lua .. '\n if e.phase == \'began\' then e.target._touch, GAME.group.const.touch = true, true'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, e.id)'
    GAME.lua = GAME.lua .. '\n else display.getCurrentStage():setFocus(e.target) end'
    GAME.lua = GAME.lua .. '\n elseif e.phase == \'ended\' or e.phase == \'cancelled\' then'
    GAME.lua = GAME.lua .. '\n e.target._touch, GAME.group.const.touch = false, false'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, nil) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(nil) for name, object in pairs(GAME_objects) do'
    GAME.lua = GAME.lua .. '\n if object._touch then GAME_objects[name]._touch = false end end end end'
    GAME.lua = GAME.lua .. '\n e = {_ccode_event = e, name = e.target.name, x = GET_X(e.x, e.target), y = GET_Y(e.y, e.target),'
    GAME.lua = GAME.lua .. '\n xStart = GET_X(e.xStart, e.target), yStart = GET_Y(e.yStart, e.target),'
    GAME.lua = GAME.lua .. '\n id = e.id, xDelta = e.xDelta, yDelta = e.yDelta, phase = e.phase}'
    GAME.lua = GAME.lua .. '\n local responses = {} for i = 1, #GAME_objects[name]._listeners do'
    GAME.lua = GAME.lua .. '\n local response = GAME_objects[name]._listeners[i](e) if response ~= nil then'
    GAME.lua = GAME.lua .. '\n table.insert(responses, response) end end return responses[#responses]'
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then return result end return true end) end end)'
end

M['setListener3'] = function(params)
    M['setListener']({params[1], params[2]})
    M['setListener']({params[1], params[3]})
    M['setListener']({params[1], params[4]})
end

M['setLocalCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name].collision = function(s, e) if GAME.hash == hash then local isComplete, result ='
    GAME.lua = GAME.lua .. '\n pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. '\n and result or false end end GAME_objects[name]:addEventListener(\'collision\') end)'
end

M['setLocalPreCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name].preCollision = function(s, e) if GAME.hash == hash then e.phase = \'pre\' local'
    GAME.lua = GAME.lua .. '\n isComplete, result = pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. '\n and result or false end end GAME_objects[name]:addEventListener(\'preCollision\') end)'
end

M['setLocalPostCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name].postCollision = function(s, e) if GAME.hash == hash then e.phase = \'post\' local'
    GAME.lua = GAME.lua .. '\n isComplete, result = pcall(function() return ' .. CALC(params[2], 'a', true) .. '(e) end) return isComplete'
    GAME.lua = GAME.lua .. '\n and result or false end end GAME_objects[name]:addEventListener(\'postCollision\') end)'
end

M['setGlobalCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_collis, function(e) if GAME.hash == hash then local isCompl, result ='
    GAME.lua = GAME.lua .. '\n pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isCompl and result or false'
    GAME.lua = GAME.lua .. '\n end end) Runtime:addEventListener(\'collision\', GAME_collis[#GAME_collis]) end)'
end

M['setGlobalPreCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_collis, function(e) if GAME.hash == hash then e.phase = \'pre\' local'
    GAME.lua = GAME.lua .. '\n isCompl, result = pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isCompl and'
    GAME.lua = GAME.lua .. '\n result or false end end) Runtime:addEventListener(\'preCollision\', GAME_collis[#GAME_collis]) end)'
end

M['setGlobalPostCollision'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_collis, function(e) if GAME.hash == hash then e.phase = \'post\''
    GAME.lua = GAME.lua .. '\n local isCompl, result = pcall(function() return ' .. CALC(params[1], 'a', true) .. '(e) end) return isCompl and'
    GAME.lua = GAME.lua .. '\n result or false end end) Runtime:addEventListener(\'postCollision\', GAME_collis[#GAME_collis]) end)'
end

M['timer'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_ts, timer.new(' .. CALC(params[1], '0.001')
    GAME.lua = GAME.lua .. '\n * 1000, ' .. CALC(params[2], '1') .. ', function(e) pcall(function() if GAME.hash == hash then'
end

M['timerName'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME_timers[' .. CALC(params[1]) .. '] = timer.new(' .. CALC(params[2], '0.001')
    GAME.lua = GAME.lua .. '\n * 1000, ' .. CALC(params[3], '1') .. ', function(e) pcall(function() if GAME.hash == hash then'
end

M['timerEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) end)) end)'
end

M['timerNameEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) end) end)'
end

M['if'] = function(params)
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() if ' .. CALC(params[1]) .. ' then'
end

M['ifElse'] = function(params)
    GAME.lua = GAME.lua .. '\n elseif ' .. CALC(params[1]) .. ' then'
end

M['ifEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then if result == \'_ccode_break\' then return end return result end'
end

M['forever'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() timer.new(1, 0, function(e) pcall(function() if GAME.hash == hash then'
end

M['foreverEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) end) end)'
end

M['for'] = function(params)
    local from, to = CALC(params[1]), CALC(params[2])
    local var, step = CALC(params[3], 'a', true), CALC(params[4], '1')

    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function()'
    GAME.lua = GAME.lua .. '\n for i = ' .. from .. ', ' .. to .. ', ' .. step .. ' do ' .. var .. ' = i'
end

M['forEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then return result end'
end

M['foreach'] = function(params)
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() for key, value in pairs(' .. CALC(params[1], '{}') .. ')'
    GAME.lua = GAME.lua .. '\n do ' .. CALC(params[2], 'a', true) .. ' = value ' .. CALC(params[3], 'a', true) .. ' = key'
end

M['foreachEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then return result end'
end

M['while'] = function(params)
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() while ' .. CALC(params[1]) .. ' do'
end

M['whileEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then return result end'
end

M['repeat'] = function(params)
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() for i = 1, ' .. CALC(params[1]) .. ' do'
end

M['repeatEnd'] = function(params)
    GAME.lua = GAME.lua .. '\n end end) if isComplete and result ~= nil then return result end'
end

M['break'] = function(params)
    GAME.lua = GAME.lua .. '\n return \'_ccode_break\''
end

M['timerPause'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() timer.pause(GAME_timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerResume'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() timer.resume(GAME_timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerCancel'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() timer.cancel(GAME_timers[' .. CALC(params[1]) .. ']) end)'
end

M['timerPauseAll'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in pairs(GAME_timers) do pcall(function() timer.pause(v) end) end end)'
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in ipairs(GAME_ts) do pcall(function() timer.pause(v) end) end end)'
end

M['timerResumeAll'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in pairs(GAME_timers) do pcall(function() timer.resume(v) end) end end)'
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in ipairs(GAME_ts) do pcall(function() timer.resume(v) end) end end)'
end

M['timerCancelAll'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in pairs(GAME_timers) do pcall(function() timer.cancel(v) end) end end)'
    GAME.lua = GAME.lua .. '\n pcall(function() for _, v in ipairs(GAME_ts) do pcall(function() timer.cancel(v) end) end end)'
end

M['setBackgroundColor'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local colors = ' .. CALC(params[1], '{0}')
    GAME.lua = GAME.lua .. '\n display.setDefault(\'background\', colors[1]/255, colors[2]/255, colors[3]/255) end)'
end

M['setBackgroundRGB'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() display.setDefault(\'background\','
    GAME.lua = GAME.lua .. CALC(params[1]) .. '/255, ' .. CALC(params[2]) .. '/255, ' .. CALC(params[3]) .. '/255) end)'
end

M['setBackgroundHEX'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local hex = UTF8.trim(tostring(' .. CALC(params[1], '\'000000\'') .. '))'
    GAME.lua = GAME.lua .. '\n if UTF8.sub(hex, 1, 1) == \'#\' then hex = UTF8.sub(hex, 2, 7) end'
    GAME.lua = GAME.lua .. '\n if UTF8.len(hex) ~= 6 then hex = \'FFFFFF\' end local errorHex = false'
    GAME.lua = GAME.lua .. '\n local filterHex = {\'0\', \'1\', \'2\', \'3\', \'4\', \'5\', \'6\','
    GAME.lua = GAME.lua .. '\n \'7\', \'8\', \'9\', \'A\', \'B\', \'C\', \'D\', \'E\', \'F\'}'
    GAME.lua = GAME.lua .. '\n for indexHex = 1, 6 do local symHex = UTF8.upper(UTF8.sub(hex, indexHex, indexHex))'
    GAME.lua = GAME.lua .. '\n for i = 1, #filterHex do if symHex == filterHex[i] then break elseif i == #filterHex then errorHex = true end end'
    GAME.lua = GAME.lua .. '\n end if errorHex then hex = \'FFFFFF\' end local r, g, b = unpack(math.hex(hex))'
    GAME.lua = GAME.lua .. '\n display.setDefault(\'background\', r/255, g/255, b/255) end)'
end

M['setPortraitOrientation'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() setOrientationApp({type = \'portrait\', lis = ' .. CALC(params[1], 'a', true) .. '}) end)'
end

M['setLandscapeOrientation'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() setOrientationApp({type = \'landscape\', lis = ' .. CALC(params[1], 'a', true) .. '}) end)'
end

M['newAlert'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() native.showAlert(' .. CALC(params[1]) .. ', ' .. CALC(params[2]) .. ', '
    GAME.lua = GAME.lua .. CALC(params[3]) .. ', function(e) pcall(function() if GAME.hash == hash then '
    GAME.lua = GAME.lua .. CALC(params[4], 'a', true) .. '(e) end end) end) end)'
end

M['scheduleNotification'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() NOTIFICATIONS.scheduleNotification(' .. CALC(params[2]) .. ','
    GAME.lua = GAME.lua .. '\n {alert = ' .. CALC(params[1]) .. '}) end)'
end

M['cancelNotification'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() NOTIFICATIONS.cancelNotification() end)'
end

M['turnOnAccelerometer'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_accelerometers, function(e) pcall(function()'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then ' .. CALC(params[1], 'a', true) .. '(e) end end) end)'
    GAME.lua = GAME.lua .. '\n Runtime:addEventListener(\'accelerometer\', GAME_accelerometers[#GAME_accelerometers]) end)'
end

M['setAccelerometerFrequency'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() system.setAccelerometerInterval(' .. CALC(params[1], '10') .. ') end)'
end

M['readFileRes'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() local link = other.getResource(' .. CALC(params[1]) .. ') ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = READ_FILE(DOC_DIR .. \'/\' .. link, ' .. CALC(params[3]) .. ') end)'
end

M['pasteboardCopy'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() PASTEBOARD.copy(\'string\', tostring(' .. CALC(params[1]) .. ')) end)'
end

M['pasteboardPaste'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() PASTEBOARD.paste(function(e) ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. '\n = e.string or e.url or ' .. CALC(params[1], 'a', true) .. ' end) end)'
end

M['pasteboardClear'] = function(params)
    GAME.lua = GAME.lua .. '\n pcall(function() PASTEBOARD.clear() end)'
end

return M
