local CALC = require 'Core.Simulation.calc'
local M = {}

if 'Переходы' then
    M['setTransitionListener'] = function(listener)
        return ' function(e) pcall(function() if GAME.hash == hash then ' .. listener .. '(e) end end) end'
    end

    M['setTransitionTo'] = function(params)
        local name, count = CALC(params[1]), CALC(params[4], '1')
        local direction, time, easing = CALC(params[3]), CALC(params[5], '1'), CALC(params[14], 'nil')
        local type, onComplete = CALC(params[2], 'GAME_objects'), CALC(params[15], 'a', true)
        local width, height, posX = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
        local posY, scaleX, scaleY = CALC(params[9], 'nil'), CALC(params[10], 'nil'), CALC(params[11], 'nil')
        local onPause, onResume = CALC(params[16], 'a', true), CALC(params[17], 'a', true)
        local onCancel, onRepeat = CALC(params[18], 'a', true), CALC(params[19], 'a', true)
        local alpha, rotation = CALC(params[12], 'nil'), CALC(params[13], 'nil')

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

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

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
        GAME.lua = GAME.lua .. '\n onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', time = '
        GAME.lua = GAME.lua .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ', x = ' .. posX .. ','
        GAME.lua = GAME.lua .. '\n width = ' .. width .. ', height = ' .. height .. ', rotation = ' .. rotation .. ', alpha = ' .. alpha .. ','
        GAME.lua = GAME.lua .. '\n xScale = ' .. scaleX .. ', yScale = ' .. scaleY .. ', y = ' .. posY .. '}) end if \'' .. type .. '\' =='
        GAME.lua = GAME.lua .. '\n \'GAME_tags\' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionPos'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')
        local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
        local posX, posY, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
        local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
        local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
        local onRepeat = CALC(params[13], 'a', true)

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
        local posX = posX == 'nil' and 'nil' or 'SET_X(' .. posX .. ', ' .. type .. '[name])'
        local posY = posY == 'nil' and 'nil' or 'SET_Y(' .. posY .. ', ' .. type .. '[name])'

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
        GAME.lua = GAME.lua .. '\n onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
        GAME.lua = GAME.lua .. '\n time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
        GAME.lua = GAME.lua .. '\n x = ' .. posX .. ', y = ' .. posY .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
        GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionSize'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')
        local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
        local width, height, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
        local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
        local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
        local onRepeat, size = CALC(params[13], 'a', true), 'nil'

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        if type == 'GAME_texts' then
            width, height, size = 'nil', 'nil', width ~= 'nil' and width or height
        end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ', onPause'
        GAME.lua = GAME.lua .. '\n = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', size = ' .. size .. ','
        GAME.lua = GAME.lua .. '\n time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
        GAME.lua = GAME.lua .. '\n width = ' .. width .. ', height = ' .. height .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
        GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionScale'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')
        local direction, count, time = CALC(params[3]), CALC(params[4], '1'), CALC(params[5], '1')
        local scaleX, scaleY, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil'), CALC(params[8], 'nil')
        local onComplete, onPause = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
        local onResume, onCancel = CALC(params[11], 'a', true), CALC(params[12], 'a', true)
        local onRepeat = CALC(params[13], 'a', true)

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
        local scaleX = scaleX == 'nil' and 'nil' or scaleX .. ' / 100'
        local scaleY = scaleY == 'nil' and 'nil' or scaleY .. ' / 100'

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
        GAME.lua = GAME.lua .. '\n onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
        GAME.lua = GAME.lua .. '\n time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
        GAME.lua = GAME.lua .. '\n xScale = ' .. scaleX .. ', yScale = ' .. scaleY .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
        GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionRotation'] = function(params)
        local name, type = CALC(params[1]), CALC(params[3], 'GAME_objects')
        local direction, count, time = CALC(params[2]), CALC(params[5], '1'), CALC(params[4], '1')
        local rotation, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil')
        local onComplete, onPause = CALC(params[8], 'a', true), CALC(params[9], 'a', true)
        local onResume, onCancel = CALC(params[10], 'a', true), CALC(params[11], 'a', true)
        local onRepeat = CALC(params[12], 'a', true)

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
        GAME.lua = GAME.lua .. '\n onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
        GAME.lua = GAME.lua .. '\n time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
        GAME.lua = GAME.lua .. '\n rotation = ' .. rotation .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
        GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionAlpha'] = function(params)
        local name, type = CALC(params[1]), CALC(params[3], 'GAME_objects')
        local direction, count, time = CALC(params[2]), CALC(params[5], '1'), CALC(params[4], '1')
        local alpha, easing = CALC(params[6], 'nil'), CALC(params[7], 'nil')
        local onComplete, onPause = CALC(params[8], 'a', true), CALC(params[9], 'a', true)
        local onResume, onCancel = CALC(params[10], 'a', true), CALC(params[11], 'a', true)
        local onRepeat = CALC(params[12], 'a', true)

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'
        local alpha = alpha == 'nil' and 'nil' or alpha .. ' / 100'

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name] local function doTo(obj)'
        GAME.lua = GAME.lua .. '\n transition.' .. direction .. '(obj, {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ','
        GAME.lua = GAME.lua .. '\n onPause = ' .. onPause .. ', onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ','
        GAME.lua = GAME.lua .. '\n time = ' .. time .. ' * 1000, iterations = ' .. count .. ', transition = easing.' .. easing .. ','
        GAME.lua = GAME.lua .. '\n alpha = ' .. alpha .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
        GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
        GAME.lua = GAME.lua .. '\n == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
    end

    M['setTransitionAngles'] = function(params)
        local name, count, angles = CALC(params[1]), CALC(params[5], '1'), CALC(params[6], 'nil')
        local direction, time, easing = CALC(params[2]), CALC(params[4], '1'), CALC(params[7], 'nil')
        local type, onComplete = CALC(params[3], 'GAME_objects'), CALC(params[8], 'a', true)
        local onPause, onResume = CALC(params[9], 'a', true), CALC(params[10], 'a', true)
        local onCancel, onRepeat = CALC(params[11], 'a', true), CALC(params[12], 'a', true)

        local easing = easing == '(select[\'loop\']())' and 'continuousLoop' or (UTF8.match(easing, '%(select%[\'(.+)\'%]') or 'linear')
        local direction = direction == '(select[\'bounce\']())' and 'loop' or 'to'

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        local onComplete = M['setTransitionListener'](onComplete)
        local onCancel = M['setTransitionListener'](onCancel)
        local onPause = M['setTransitionListener'](onPause)
        local onResume = M['setTransitionListener'](onResume)
        local onRepeat = M['setTransitionListener'](onRepeat)

        if type == 'GAME_tags' or type == 'GAME_objects' then
            GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
            GAME.lua = GAME.lua .. '\n local p = ' .. angles .. ' if type(p) ~= \'table\' then p = {} end'
            GAME.lua = GAME.lua .. '\n local function doTo(obj) transition.' .. direction .. '(obj.path,'
            GAME.lua = GAME.lua .. '\n {onComplete = ' .. onComplete .. ', onRepeat = ' .. onRepeat .. ', onPause = ' .. onPause .. ','
            GAME.lua = GAME.lua .. '\n onResume = ' .. onResume .. ', onCancel = ' .. onCancel .. ', x1 = p.x1, y1 = p.y1, x2 = p.x2, y2 = p.y2,'
            GAME.lua = GAME.lua .. '\n x3 = p.x3, y3 = p.y3, x4 = p.x4, y4 = p.y4, time = ' .. time .. ' * 1000, iterations = ' .. count .. ','
            GAME.lua = GAME.lua .. '\n transition = easing.' .. easing .. '}) end if \'' .. type .. '\' == \'GAME_tags\''
            GAME.lua = GAME.lua .. '\n then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\''
            GAME.lua = GAME.lua .. '\n then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
            GAME.lua = GAME.lua .. '\n end end end doTag(name) end) else doTo(obj) end end)'
        end
    end

    M['setTransitionPause'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
        GAME.lua = GAME.lua .. '\n if \'' .. type .. '\' == \'GAME_tags\' then pcall(function()'
        GAME.lua = GAME.lua .. '\n local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
        GAME.lua = GAME.lua .. '\n else transition.pause(child[1]) end end end doTag(name) end) else transition.pause(obj) end end)'
    end

    M['setTransitionResume'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
        GAME.lua = GAME.lua .. '\n if \'' .. type .. '\' == \'GAME_tags\' then pcall(function()'
        GAME.lua = GAME.lua .. '\n local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
        GAME.lua = GAME.lua .. '\n else transition.resume(child[1]) end end end doTag(name) end) else transition.resume(obj) end end)'
    end

    M['setTransitionCancel'] = function(params)
        local name, type = CALC(params[1]), CALC(params[2], 'GAME_objects')

        if type == '(select[\'obj\']())' then type = 'GAME_objects'
        elseif type == '(select[\'text\']())' then type = 'GAME_texts'
        elseif type == '(select[\'group\']())' then type = 'GAME_groups'
        elseif type == '(select[\'widget\']())' then type = 'GAME_widgets'
        elseif type == '(select[\'snapshot\']())' then type = 'GAME_snapshots'
        elseif type == '(select[\'tag\']())' then type = 'GAME_tags' end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' local obj = ' .. type .. '[name]'
        GAME.lua = GAME.lua .. '\n if \'' .. type .. '\' == \'GAME_tags\' then pcall(function()'
        GAME.lua = GAME.lua .. '\n local function doTag(tag) for _, child in ipairs(obj) do if child[2] == \'tags\' then doTag(child[1])'
        GAME.lua = GAME.lua .. '\n else transition.cancel(child[1]) end end end doTag(name) end) else transition.cancel(obj) end end)'
    end

    M['setTransitionPauseAll'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() transition.pauseAll() end)'
    end

    M['setTransitionResumeAll'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() transition.resumeAll() end)'
    end

    M['setTransitionCancelAll'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() transition.cancelAll() end)'
    end
end

if 'Частицы' then
    M['newEmitter'] = function(params)
        local name = CALC(params[1])
        local type = UTF8.match(CALC(params[2]), '%(select%[\'(.+)\'%]') or 'air_stars'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_particles[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name] = PARTICLE.newEmitter(\'Emitter/' .. type .. '.json\', nil, \'Emitter/\')'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].x, GAME_particles[name].y = CENTER_X, CENTER_Y'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._height = GAME_particles[name].height'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._width = GAME_particles[name].width'
        GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_particles[name]) end)'
    end

    M['newCustomEmitter'] = function(params)
        local name = CALC(params[1])
        local emitter = CALC(params[2])
        local link = CALC(params[3])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_particles[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n local params = ' .. emitter .. ' params.textureFileName = other.getImage(' .. link .. ')'
        GAME.lua = GAME.lua .. '\n GAME_particles[name] = display.newEmitter(params, system.DocumentsDirectory)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].x, GAME_particles[name].y = CENTER_X, CENTER_Y'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._height = GAME_particles[name].height'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._width = GAME_particles[name].width'
        GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_particles[name]) end)'
    end

    M['newLinearEmitter'] = function(params)
        local name, link = CALC(params[1]), CALC(params[2])
        local maxParticles, absolutePosition = CALC(params[3], '500'), CALC(params[4], 'nil')
        local angle, angleVariance = CALC(params[5], '0'), CALC(params[6], '0')
        local speed, speedVariance = CALC(params[7], '0'), CALC(params[8], '0')
        local sourcePositionVariancex, sourcePositionVariancey = CALC(params[9], '0'), CALC(params[10], '0')
        local gravityx, gravityy = CALC(params[11], '0'), CALC(params[12], '0')
        local radialAcceleration, radialAccelVariance = CALC(params[13], 'nil'), CALC(params[14], 'nil')
        local tangentialAcceleration, tangentialAccelVariance = CALC(params[15], 'nil'), CALC(params[16], 'nil')
        local particleLifespan, particleLifespanVariance = CALC(params[17], '2'), CALC(params[18], '0')
        local startParticleSize, startParticleSizeVariance = CALC(params[19], '20'), CALC(params[20], '0')
        local finishParticleSize, finishParticleSizeVariance = CALC(params[21], '5'), CALC(params[22], '0')
        local rotationStart, rotationStartVariance = CALC(params[23], '0'), CALC(params[24], '0')
        local rotationEnd, rotationEndVariance = CALC(params[25], '0'), CALC(params[26], '0')
        local startColor, startColorVariance = CALC(params[27], '{255, 255, 255}'), CALC(params[28], '{0, 0, 0}')
        local finishColor, finishColorVariance = CALC(params[29], '{0, 0, 0}'), CALC(params[30], '{0, 0, 0}')
        local blendFuncSource = UTF8.match(CALC(params[31]), '%(select%[\'(.+)\'%]') or 'GL_SRC_ALPHA'
        local blendFuncDestination = UTF8.match(CALC(params[32]), '%(select%[\'(.+)\'%]') or 'GL_ONE'
        local blendFuncSource, blendFuncDestination = GET_GL_NUM(blendFuncSource), GET_GL_NUM(blendFuncDestination)

        GAME.lua = GAME.lua .. '\n pcall(function() local name, params = ' .. name .. ', {emitterType = 0,'
        GAME.lua = GAME.lua .. '\n textureFileName = other.getImage(' .. link .. '), duration = -1,'
        GAME.lua = GAME.lua .. '\n absolutePosition = not ' .. absolutePosition .. ', maxParticles = ' .. maxParticles .. ','
        GAME.lua = GAME.lua .. '\n angle = ' .. angle .. ', angleVariance = ' .. angleVariance .. ','
        GAME.lua = GAME.lua .. '\n speed = ' .. speed .. ', speedVariance = ' .. speedVariance .. ','
        GAME.lua = GAME.lua .. '\n sourcePositionVariancex = ' .. sourcePositionVariancex .. ','
        GAME.lua = GAME.lua .. '\n sourcePositionVariancey = 0 - ' .. sourcePositionVariancey .. ','
        GAME.lua = GAME.lua .. '\n gravityx = ' .. gravityx .. ', gravityy = 0 - ' .. gravityy .. ','
        GAME.lua = GAME.lua .. '\n radialAcceleration = ' .. radialAcceleration .. ','
        GAME.lua = GAME.lua .. '\n radialAccelVariance = ' .. radialAccelVariance .. ','
        GAME.lua = GAME.lua .. '\n tangentialAcceleration = ' .. tangentialAcceleration .. ','
        GAME.lua = GAME.lua .. '\n tangentialAccelVariance = ' .. tangentialAccelVariance .. ','
        GAME.lua = GAME.lua .. '\n particleLifespan = ' .. particleLifespan .. ','
        GAME.lua = GAME.lua .. '\n particleLifespanVariance = ' .. particleLifespanVariance .. ','
        GAME.lua = GAME.lua .. '\n startParticleSize = ' .. startParticleSize .. ','
        GAME.lua = GAME.lua .. '\n startParticleSizeVariance = ' .. startParticleSizeVariance .. ','
        GAME.lua = GAME.lua .. '\n finishParticleSize = ' .. finishParticleSize .. ','
        GAME.lua = GAME.lua .. '\n finishParticleSizeVariance = ' .. finishParticleSizeVariance .. ','
        GAME.lua = GAME.lua .. '\n rotationStart = ' .. rotationStart .. ', rotationEnd = ' .. rotationEnd .. ','
        GAME.lua = GAME.lua .. '\n blendFuncSource = ' .. blendFuncSource .. ', blendFuncDestination = ' .. blendFuncDestination .. '}'
        GAME.lua = GAME.lua .. '\n local startColor, startColorVariance = ' .. startColor .. ', ' .. startColorVariance
        GAME.lua = GAME.lua .. '\n local finishColor, finishColorVariance = ' .. finishColor .. ', ' .. finishColorVariance
        GAME.lua = GAME.lua .. '\n params.startColorRed = startColor and startColor[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorGreen = startColor and startColor[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorBlue = startColor and startColor[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceRed = startColorVariance and startColorVariance[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceGreen = startColorVariance and startColorVariance[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceBlue = startColorVariance and startColorVariance[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorAlpha = 1 params.startColorVarianceAlpha = 0'
        GAME.lua = GAME.lua .. '\n params.finishColorRed = finishColor and finishColor[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorGreen = finishColor and finishColor[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorBlue = finishColor and finishColor[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceRed = finishColorVariance and finishColorVariance[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceGreen = finishColorVariance and finishColorVariance[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceBlue = finishColorVariance and finishColorVariance[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorAlpha = 1 params.finishColorVarianceAlpha = 0'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_particles[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name] = display.newEmitter(params, system.DocumentsDirectory)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].x, GAME_particles[name].y = CENTER_X, CENTER_Y'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._height = GAME_particles[name].height'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._width = GAME_particles[name].width'
        GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_particles[name]) end)'
    end

    M['newRadialEmitter'] = function(params)
        local name, link = CALC(params[1]), CALC(params[2])
        local maxParticles, absolutePosition = CALC(params[3], '500'), CALC(params[4], 'nil')
        local angle, angleVariance = CALC(params[5], '0'), CALC(params[6], '0')
        local maxRadius, maxRadiusVariance = CALC(params[7], '0'), CALC(params[8], '0')
        local minRadius, minRadiusVariance = CALC(params[9], '0'), CALC(params[10], '0')
        local rotatePerSecond, rotatePerSecondVariance = CALC(params[11], '0'), CALC(params[12], '0')
        local particleLifespan, particleLifespanVariance = CALC(params[13], '2'), CALC(params[14], '0')
        local startParticleSize, startParticleSizeVariance = CALC(params[15], '20'), CALC(params[16], '0')
        local finishParticleSize, finishParticleSizeVariance = CALC(params[17], '5'), CALC(params[18], '0')
        local rotationStart, rotationStartVariance = CALC(params[19], '0'), CALC(params[20], '0')
        local rotationEnd, rotationEndVariance = CALC(params[21], '0'), CALC(params[22], '0')
        local startColor, startColorVariance = CALC(params[23], '{255, 255, 255}'), CALC(params[24], '{0, 0, 0}')
        local finishColor, finishColorVariance = CALC(params[25], '{0, 0, 0}'), CALC(params[26], '{0, 0, 0}')
        local blendFuncSource = UTF8.match(CALC(params[27]), '%(select%[\'(.+)\'%]') or 'GL_SRC_ALPHA'
        local blendFuncDestination = UTF8.match(CALC(params[28]), '%(select%[\'(.+)\'%]') or 'GL_ONE'
        local blendFuncSource, blendFuncDestination = GET_GL_NUM(blendFuncSource), GET_GL_NUM(blendFuncDestination)

        GAME.lua = GAME.lua .. '\n pcall(function() local name, params = ' .. name .. ', {emitterType = 1,'
        GAME.lua = GAME.lua .. '\n textureFileName = other.getImage(' .. link .. '), duration = -1,'
        GAME.lua = GAME.lua .. '\n absolutePosition = not ' .. absolutePosition .. ', maxParticles = ' .. maxParticles .. ','
        GAME.lua = GAME.lua .. '\n angle = ' .. angle .. ', angleVariance = ' .. angleVariance .. ','
        GAME.lua = GAME.lua .. '\n maxRadius = ' .. maxRadius .. ', maxRadiusVariance = ' .. maxRadiusVariance .. ','
        GAME.lua = GAME.lua .. '\n minRadius = ' .. minRadius .. ', minRadiusVariance = ' .. minRadiusVariance .. ','
        GAME.lua = GAME.lua .. '\n rotatePerSecond = ' .. rotatePerSecond .. ','
        GAME.lua = GAME.lua .. '\n rotatePerSecondVariance = ' .. rotatePerSecondVariance .. ','
        GAME.lua = GAME.lua .. '\n particleLifespan = ' .. particleLifespan .. ','
        GAME.lua = GAME.lua .. '\n particleLifespanVariance = ' .. particleLifespanVariance .. ','
        GAME.lua = GAME.lua .. '\n startParticleSize = ' .. startParticleSize .. ','
        GAME.lua = GAME.lua .. '\n startParticleSizeVariance = ' .. startParticleSizeVariance .. ','
        GAME.lua = GAME.lua .. '\n finishParticleSize = ' .. finishParticleSize .. ','
        GAME.lua = GAME.lua .. '\n finishParticleSizeVariance = ' .. finishParticleSizeVariance .. ','
        GAME.lua = GAME.lua .. '\n rotationStart = ' .. rotationStart .. ', rotationEnd = ' .. rotationEnd .. ','
        GAME.lua = GAME.lua .. '\n blendFuncSource = ' .. blendFuncSource .. ', blendFuncDestination = ' .. blendFuncDestination .. '}'
        GAME.lua = GAME.lua .. '\n local startColor, startColorVariance = ' .. startColor .. ', ' .. startColorVariance
        GAME.lua = GAME.lua .. '\n local finishColor, finishColorVariance = ' .. finishColor .. ', ' .. finishColorVariance
        GAME.lua = GAME.lua .. '\n params.startColorRed = startColor and startColor[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorGreen = startColor and startColor[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorBlue = startColor and startColor[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceRed = startColorVariance and startColorVariance[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceGreen = startColorVariance and startColorVariance[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorVarianceBlue = startColorVariance and startColorVariance[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.startColorAlpha = 1 params.startColorVarianceAlpha = 0'
        GAME.lua = GAME.lua .. '\n params.finishColorRed = finishColor and finishColor[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorGreen = finishColor and finishColor[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorBlue = finishColor and finishColor[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceRed = finishColorVariance and finishColorVariance[1] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceGreen = finishColorVariance and finishColorVariance[2] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorVarianceBlue = finishColorVariance and finishColorVariance[3] / 255 or nil'
        GAME.lua = GAME.lua .. '\n params.finishColorAlpha = 1 params.finishColorVarianceAlpha = 0'
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_particles[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name] = display.newEmitter(params, system.DocumentsDirectory)'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].x, GAME_particles[name].y = CENTER_X, CENTER_Y'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._height = GAME_particles[name].height'
        GAME.lua = GAME.lua .. '\n GAME_particles[name]._width = GAME_particles[name].width'
        GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_particles[name]) end)'
    end

    M['removeEmitter'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n GAME_particles[name]:removeSelf() GAME_particles[name] = nil end)'
    end

    M['removeAllEmitter'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() for _, v in pairs(GAME_particles) do'
        GAME.lua = GAME.lua .. '\n pcall(function() v:removeSelf() v = nil end) end end)'
    end

    M['setEmitterPos'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n GAME_particles[name].x = SET_X(' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].y = SET_Y(' .. CALC(params[3]) .. ') end)'
    end

    M['setEmitterSize'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, size = ' .. CALC(params[1]) .. ', ' .. CALC(params[2]) .. ' / 100'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].width = GAME_particles[name]._width * size'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].height = GAME_particles[name]._height * size end)'
    end

    M['setEmitterSpeed'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, speed = ' .. CALC(params[1]) .. ', ' .. CALC(params[2])
        GAME.lua = GAME.lua .. '\n GAME_particles[name].speed = speed end)'
    end

    M['setEmitterRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, angle = ' .. CALC(params[1]) .. ', ' .. CALC(params[2])
        GAME.lua = GAME.lua .. '\n GAME_particles[name].angle = angle end)'
    end

    M['setEmitterGravity'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n GAME_particles[name].gravityx = ' .. CALC(params[2])
        GAME.lua = GAME.lua .. '\n GAME_particles[name].gravityy = 0 - ' .. CALC(params[3]) .. ' end)'
    end

    M['setEmitterStartColor'] = function(params)
        local name = CALC(params[1])
        local colors = CALC(params[2], '{255, 255, 255}')
        local alpha = CALC(params[3], '100')

        GAME.lua = GAME.lua .. '\n pcall(function() local name, colors, alpha = ' .. name .. ', ' .. colors .. ', ' .. alpha
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorRed = colors[1] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorGreen = colors[2] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorBlue = colors[3] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorAlpha = alpha / 100 end)'
    end

    M['setEmitterFinishColor'] = function(params)
        local name = CALC(params[1])
        local colors = CALC(params[2], '{255, 255, 255}')
        local alpha = CALC(params[3], '100')

        GAME.lua = GAME.lua .. '\n pcall(function() local name, colors, alpha = ' .. name .. ', ' .. colors .. ', ' .. alpha
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorRed = colors[1] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorGreen = colors[2] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorBlue = colors[3] / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorAlpha = alpha / 100 end)'
    end

    M['setEmitterStartRGB'] = function(params)
        local name = CALC(params[1])
        local r, g, b = CALC(params[2], '255'), CALC(params[3], '255'), CALC(params[4], '255')
        local alpha = CALC(params[5], '100')

        GAME.lua = GAME.lua .. '\n pcall(function() local name, alpha = ' .. name .. ', ' .. alpha
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorRed = ' .. r .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorGreen = ' .. g .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorBlue = ' .. b .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].startColorAlpha = alpha / 100 end)'
    end

    M['setEmitterFinishRGB'] = function(params)
        local name = CALC(params[1])
        local r, g, b = CALC(params[2], '255'), CALC(params[3], '255'), CALC(params[4], '255')
        local alpha = CALC(params[5], '100')

        GAME.lua = GAME.lua .. '\n pcall(function() local name, alpha = ' .. name .. ', ' .. alpha
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorRed = ' .. r .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorGreen = ' .. g .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorBlue = ' .. b .. ' / 255'
        GAME.lua = GAME.lua .. '\n GAME_particles[name].finishColorAlpha = alpha / 100 end)'
    end
end

return M
