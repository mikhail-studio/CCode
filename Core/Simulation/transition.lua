local CALC = require 'Core.Simulation.calc'
local M = {}

M['setTransitionListener'] = function(listener)
    return ' function(e) pcall(function() if GAME.hash == hash then ' .. listener .. '(e) end end) end'
end

M['setTransitionTo'] = function(params)
    local name, count = CALC(params[1]), CALC(params[4], '1')
    local direction, time, easing = CALC(params[3]), CALC(params[5], '1'), CALC(params[14], 'nil')
    local type, onComplete = CALC(params[2], 'GAME.group.objects'), CALC(params[15], 'a', true)
    local width, height, posX = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
    local posY, scaleX, scaleY = CALC(params[9], 'nil'), CALC(params[10], 'nil'), CALC(params[11], 'nil')
    local onPause, onResume = CALC(params[16], 'a', true), CALC(params[17], 'a', true)
    local onCancel, onRepeat = CALC(params[18], 'a', true), CALC(params[19], 'a', true)
    local alpha, rotation = CALC(params[12], 'nil'), CALC(params[13], 'nil')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
    local posX = posX == 'nil' and 'nil' or 'SET_X(' .. posX .. ', ' .. type .. '[name])'
    local posY = posY == 'nil' and 'nil' or 'SET_Y(' .. posY .. ', ' .. type .. '[name])'
    local scaleX = scaleX == 'nil' and 'nil' or scaleX .. ' / 100'
    local scaleY = scaleY == 'nil' and 'nil' or scaleY .. ' / 100'
    local alpha = alpha == 'nil' and 'nil' or alpha .. ' / 100'

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
    GAME.lua = GAME.lua .. ' onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', time = '
    GAME.lua = GAME.lua .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ', x = ' .. posX .. ','
    GAME.lua = GAME.lua .. ' width = ' .. width .. ', height = ' .. height .. ', rotation = ' .. rotation .. ', alpha = ' .. alpha .. ','
    GAME.lua = GAME.lua .. ' xScale = ' .. scaleX .. ', yScale = ' .. scaleY .. ', y = ' .. posY .. '}) end if \'' .. type .. '\' =='
    GAME.lua = GAME.lua .. ' \'GAME.group.tags\' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionPos'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')
    local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
    local posX, posY, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
    local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
    local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
    local onRepeat = CALC(params[13], 'a', true)

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
    local posX = posX == 'nil' and 'nil' or 'SET_X(' .. posX .. ', ' .. type .. '[name])'
    local posY = posY == 'nil' and 'nil' or 'SET_Y(' .. posY .. ', ' .. type .. '[name])'

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
    GAME.lua = GAME.lua .. ' onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
    GAME.lua = GAME.lua .. ' x = ' .. posX .. ', y = ' .. posY .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
    GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionSize'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')
    local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
    local width, height, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
    local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
    local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
    local onRepeat, size = CALC(params[13], 'a', true), 'nil'

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    if type == 'GAME.group.texts' then
        width, height, size = 'nil', 'nil', width ~= 'nil' and width or height
    end

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ', onPause'
    GAME.lua = GAME.lua .. ' = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', size = ' .. size .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
    GAME.lua = GAME.lua .. ' width = ' .. width .. ', height = ' .. height .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
    GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionScale'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')
    local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
    local scaleX, scaleY, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
    local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
    local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
    local onRepeat = CALC(params[13], 'a', true)

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
    local scaleX = scaleX == 'nil' and 'nil' or scaleX .. ' / 100'
    local scaleY = scaleY == 'nil' and 'nil' or scaleY .. ' / 100'

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
    GAME.lua = GAME.lua .. ' onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
    GAME.lua = GAME.lua .. ' xScale = ' .. scaleX .. ', yScale = ' .. scaleY .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
    GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionRotation'] = function(params)
    local name, type = CALC(params[1]), CALC(params[3], 'GAME.group.objects')
    local direction, count, time = CALC(params[2]), CALC(params[5], '1'), CALC(params[4], '1')
    local rotation, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil')
    local onComplete, onPause = CALC(params[8], 'a', true), CALC(params[9], 'a', true)
    local onResume, onCancel = CALC(params[10], 'a', true), CALC(params[11], 'a', true)
    local onRepeat = CALC(params[12], 'a', true)

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
    GAME.lua = GAME.lua .. ' onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
    GAME.lua = GAME.lua .. ' rotation = ' .. rotation .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
    GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionAlpha'] = function(params)
    local name, type = CALC(params[1]), CALC(params[3], 'GAME.group.objects')
    local direction, count, time = CALC(params[2]), CALC(params[5], '1'), CALC(params[4], '1')
    local alpha, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil')
    local onComplete, onPause = CALC(params[8], 'a', true), CALC(params[9], 'a', true)
    local onResume, onCancel = CALC(params[10], 'a', true), CALC(params[11], 'a', true)
    local onRepeat = CALC(params[12], 'a', true)

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
    local alpha = alpha == 'nil' and 'nil' or alpha .. ' / 100'

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
    GAME.lua = GAME.lua .. ' transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
    GAME.lua = GAME.lua .. ' onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
    GAME.lua = GAME.lua .. ' time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
    GAME.lua = GAME.lua .. ' alpha = ' .. alpha .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
    GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['setTransitionAngles'] = function(params)
    local name, count, angles = CALC(params[1]), CALC(params[5], '1'), CALC(params[6], 'nil')
    local direction, time, easing = CALC(params[2]), CALC(params[4], '1'), CALC(params[7], 'nil')
    local type, onComplete = CALC(params[3], 'GAME.group.objects'), CALC(params[8], 'a', true)
    local onPause, onResume = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
    local onCancel, onRepeat = CALC(params[11], 'a', true), CALC(params[12], 'a', true)

    local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
    local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    local onComplete = M['setTransitionListener'](onComplete)
    local onCancel = M['setTransitionListener'](onCancel)
    local onPause = M['setTransitionListener'](onPause)
    local onResume = M['setTransitionListener'](onResume)
    local onRepeat = M['setTransitionListener'](onRepeat)

    if type == 'GAME.group.tags' or type == 'GAME.group.objects' then
        GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
        GAME.lua = GAME.lua .. ' local p = ' .. angles .. ' if type(p) ~= \'table\' then p = {} end'
        GAME.lua = GAME.lua .. ' local function doTo(obj) transition.' .. direction .. '(obj.path,'
        GAME.lua = GAME.lua .. ' {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ', onPause = ' .. onPause .. ','
        GAME.lua = GAME.lua .. ' onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', x1 = p.x1, y1 = p.y1, x2 = p.x2, y2 = p.y2,'
        GAME.lua = GAME.lua .. ' x3 = p.x3, y3 = p.y3, x4 = p.x4, y4 = p.y4, time = ' .. time .. ' * 1000, iterations = ' .. count .. ','
        GAME.lua = GAME.lua .. ' transition = easing.' .. easing .. '}) end if \'' .. type .. '\' == \'GAME.group.tags\''
        GAME.lua = GAME.lua .. ' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\''
        GAME.lua = GAME.lua .. ' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
    end
end

M['setTransitionPause'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
    GAME.lua = GAME.lua .. ' if \'' .. type .. '\' == \'GAME.group.tags\' then pcall(function()'
    GAME.lua = GAME.lua .. ' local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
    GAME.lua = GAME.lua .. ' else transition.pause(child[1]) end end end doTag(name) end) else transition.pause(obj) end end)'
end

M['setTransitionResume'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
    GAME.lua = GAME.lua .. ' if \'' .. type .. '\' == \'GAME.group.tags\' then pcall(function()'
    GAME.lua = GAME.lua .. ' local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
    GAME.lua = GAME.lua .. ' else transition.resume(child[1]) end end end doTag(name) end) else transition.resume(obj) end end)'
end

M['setTransitionCancel'] = function(params)
    local name, type = CALC(params[1]), CALC(params[2], 'GAME.group.objects')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.groups'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
    GAME.lua = GAME.lua .. ' if \'' .. type .. '\' == \'GAME.group.tags\' then pcall(function()'
    GAME.lua = GAME.lua .. ' local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
    GAME.lua = GAME.lua .. ' else transition.cancel(child[1]) end end end doTag(name) end) else transition.cancel(obj) end end)'
end

M['setTransitionPauseAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() transition.pauseAll() end)'
end

M['setTransitionResumeAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() transition.resumeAll() end)'
end

M['setTransitionCancelAll'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() transition.cancelAll() end)'
end

return M
