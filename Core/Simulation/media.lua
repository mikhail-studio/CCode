local CALC = require 'Core.Simulation.calc'
local M = {}

M['newVideo'] = function(params)
    local name, link, fun = CALC(params[1]), CALC(params[2]), CALC(params[3], 'a', true)
    local posX = '(CENTER_X + (' .. CALC(params[4]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[5]) .. '))'
    local width, height = CALC(params[6]), CALC(params[7])

    GAME.lua = GAME.lua .. ' pcall(function() local link, name = other.getVideo(' .. link .. '), ' .. name .. ' GAME.group.media[name]'
    GAME.lua = GAME.lua .. ' = native.newVideo(' .. posX .. ', ' .. posY .. ', ' .. width .. ', ' .. height .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.media[name]:load(link, system.DocumentsDirectory)'
    GAME.lua = GAME.lua .. ' GAME.group.media[name]:addEventListener(\'video\', function(e) pcall(function() e.name = name ' .. fun .. '(e)'
    GAME.lua = GAME.lua .. ' end) end) GAME.group.media[name]:setNativeProperty(\'IgnoreErrors\', true) end)'
end

M['newRemoteVideo'] = function(params)
    local name, link, fun = CALC(params[1]), CALC(params[2]), CALC(params[3], 'a', true)
    local posX = '(CENTER_X + (' .. CALC(params[4]) .. '))'
    local posY = '(CENTER_Y - (' .. CALC(params[5]) .. '))'
    local width, height = CALC(params[6]), CALC(params[7])

    GAME.lua = GAME.lua .. ' pcall(function() local link, name = ' .. link .. ', ' .. name .. ' GAME.group.media[name]'
    GAME.lua = GAME.lua .. ' = native.newVideo(' .. posX .. ', ' .. posY .. ', ' .. width .. ', ' .. height .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.media[name]:load(link, media.RemoteSource)'
    GAME.lua = GAME.lua .. ' GAME.group.media[name]:addEventListener(\'video\', function(e) pcall(function() e.name = name ' .. fun .. '(e)'
    GAME.lua = GAME.lua .. ' end) end) GAME.group.media[name]:setNativeProperty(\'IgnoreErrors\', true) end)'
end

M['loadSound'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local link, name = other.getSound(' .. CALC(params[2]) .. '), ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' GAME.group.media[name] = {audio.loadSound(link, system.DocumentsDirectory)} end)'
end

M['loadStream'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local link, name = other.getSound(' .. CALC(params[2]) .. '), ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' GAME.group.media[name] = {audio.loadStream(link, system.DocumentsDirectory)} end)'
end

M['playSound'] = function(params)
    local name = CALC(params[1])
    local loops = CALC(params[2], '1')
    local fun = CALC(params[3], 'a', true)
    local duration = CALC(params[4], '0') .. ' * 1000'
    local fadein = CALC(params[5], '0') .. ' * 1000'

    GAME.lua = GAME.lua .. ' pcall(function() local name, loops = ' .. name .. ', ' .. loops .. ' - 1'
    GAME.lua = GAME.lua .. ' GAME.group.media[name][2] = audio.play(GAME.group.media[name][1], {channel = audio.findFreeChannel(),'
    GAME.lua = GAME.lua .. ' loops = loops, duration = ' .. duration .. ', fadein = ' .. fadein .. ', onComplete = function(e)'
    GAME.lua = GAME.lua .. ' pcall(function() e.name = name ' .. fun .. '(e) end) end}) end)'
end

M['resumeMedia'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' if GAME.group.media[name][2] then audio.resume(GAME.group.media[name][2])'
    GAME.lua = GAME.lua .. ' else GAME.group.media[name]:play() end end)'
end

M['pauseMedia'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. ' if GAME.group.media[name][2] then audio.pause(GAME.group.media[name][2])'
    GAME.lua = GAME.lua .. ' else GAME.group.media[name]:pause() end end)'
end

M['seekMedia'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name, duration = ' .. CALC(params[1]) .. ', 1000 * ' .. CALC(params[2], '0')
    GAME.lua = GAME.lua .. ' if GAME.group.media[name][2] then audio.seek(duration, {channel = GAME.group.media[name][2]})'
    GAME.lua = GAME.lua .. ' else GAME.group.media[name]:seek(duration / 1000) end end)'
end

M['setVolume'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name, volume = ' .. CALC(params[1]) .. ', ' .. CALC(params[2], '1')
    GAME.lua = GAME.lua .. ' audio.setVolume(volume, {channel = GAME.group.media[name][2]}) end)'
end

M['fadeVolume'] = function(params)
    local name = CALC(params[1])
    local time = CALC(params[2], '1')
    local volume = CALC(params[3], '1')

    GAME.lua = GAME.lua .. ' pcall(function() local name, time, volume = ' .. name .. ', ' .. time .. ', ' .. volume
    GAME.lua = GAME.lua .. ' audio.fade({channel = GAME.group.media[name][2], time = time, volume = volume}) end)'
end

M['stopSound'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() audio.stop(GAME.group.media[' .. CALC(params[1]) .. '][2]) end)'
end

M['stopTimerSound'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name, duration = ' .. CALC(params[1]) .. ', ' .. CALC(params[2], '0')
    GAME.lua = GAME.lua .. ' audio.stopWithDelay(duration, {channel = GAME.group.media[name][2]}) end)'
end

M['disposeSound'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() audio.dispose(GAME.group.media[' .. CALC(params[1]) .. '][1]) end)'
end

M['removeVideo'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.media[' .. CALC(params[1]) .. ']:removeSelf() end)'
end

return M
