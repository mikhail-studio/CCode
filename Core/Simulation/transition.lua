local CALC = require 'Core.Simulation.calc'
local M = {}

M['transitionXY'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'obj\'')
    local time = CALC(params[3])
    local iteration = CALC(params[4])
    local x = CALC(params[5])
    local y = CALC(params[6])

    if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
    elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
    GAME.lua = GAME.lua .. ' pcall(function() transition.to(  '..type..', {'
    GAME.lua = GAME.lua .. 'time='..time..'*1000, iteration='..iteration..', x=CENTER_X +'..x..', y=CENTER_Y +'..y..'} ) end)'
end

M['transitionWH'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'obj\'')
    local time = CALC(params[3])
    local iteration = CALC(params[4])
    local width = CALC(params[5])
    local height = CALC(params[6])

    if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
    elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
    GAME.lua = GAME.lua .. ' pcall(function() transition.to(  '..type..', {'
    GAME.lua = GAME.lua .. 'time='..time..'*1000, iteration='..iteration..', width='..width..', height='..height..'} ) end)'
end

M['transitionRotation'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'obj\'')
    local time = CALC(params[3])
    local iteration = CALC(params[4])
    local rotation = CALC(params[5])

    if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
    elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
    GAME.lua = GAME.lua .. ' pcall(function() transition.to(  '..type..', {'
    GAME.lua = GAME.lua .. 'time='..time..'*1000, iteration='..iteration..', rotation='..rotation..'} ) end)'
end

M['transitionAlpha'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'obj\'')
    local time = CALC(params[3])
    local iteration = CALC(params[4])
    local alpha = CALC(params[5])

    if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
    elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
    GAME.lua = GAME.lua .. ' pcall(function() transition.to(  '..type..', {'
    GAME.lua = GAME.lua .. 'time='..time..'*1000, iteration='..iteration..', alpha='..alpha..'/100} ) end)'
end

M['transitionCancel'] = function(params)
  local name = CALC(params[1])
  local type = CALC(params[2], '\'obj\'')

  if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
  elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
  GAME.lua = GAME.lua .. ' pcall(function() transition.cancel('..type..') end)'
end

M['transitionPause'] = function(params)
  local name = CALC(params[1])
  local type = CALC(params[2], '\'obj\'')

  if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
  elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
  GAME.lua = GAME.lua .. ' pcall(function() transition.pause('..type..') end)'
end

M['transitionResume'] = function(params)
    local name = CALC(params[1])
    local type = CALC(params[2], '\'obj\'')

    if type == "(select['obj']())" then type = 'GAME.group.objects['.. name ..']' elseif type == "(select['text']())" then type = 'GAME.group.texts[' .. name .. ']' elseif type == "(select['group']())" then type = 'GAME.group.groups[' .. name .. ']'
    elseif type == "(select['teg']())" then  type = 'GAME.group.tags['.. name ..']' elseif type == "(select['widget']())" then  type = 'GAME.group.widgets[' .. name .. ']' elseif type == "(select['newBitmap']())" then  type = 'GAME.group.bitmaps[' .. name .. ']' end
    GAME.lua = GAME.lua .. ' pcall(function() transition.resume('..type..') end)'
end

M['transitionCancelAll'] = function(params)
  GAME.lua = GAME.lua .. ' pcall(function() transition.cancelAll() end)'
end

M['transitionPauseAll'] = function(params)
  GAME.lua = GAME.lua .. ' pcall(function() transition.pauseAll() end)'
end

M['transitionResumeAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() transition.resumeAll() end)'
end

return M
