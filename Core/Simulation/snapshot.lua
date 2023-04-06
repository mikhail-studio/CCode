local CALC = require 'Core.Simulation.calc'
local M = {}

M['newSnapshot'] = function(params)
    local name, mode = CALC(params[1]), CALC(params[2])
    local width, height = CALC(params[3]), CALC(params[4])
    local posX = '(SET_X(' .. CALC(params[5]) .. '))'
    local posY = '(SET_Y(' .. CALC(params[6]) .. '))'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' pcall(function() GAME.group.snapshots[name]:removeSelf() end)'
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name] = display.newSnapshot(' .. width .. ', ' .. height .. ')'
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].x, GAME.group.snapshots[name].y = ' .. posX .. ', ' .. posY
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].canvasMode = ' .. mode .. ' GAME.group:insert(GAME.group.snapshots[name]) end)'
end

M['addToSnapshot'] = function(params)
    local snapshot, mode = CALC(params[1]), CALC(params[2], 'group')
    local name, type = CALC(params[3]), CALC(params[4], 'GAME.group.objects')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.snapshots'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'snapshot\']())' then type = 'GAME.group.snapshots'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    GAME.lua = GAME.lua .. ' pcall(function() local name, snapshot = ' .. name .. ', ' .. snapshot .. ' local obj = ' .. type .. '[name]'
    GAME.lua = GAME.lua .. ' local function doTo(obj) GAME.group.snapshots[snapshot][' .. mode .. ']:insert(obj)'
    GAME.lua = GAME.lua .. ' obj._snapshot, obj.x, obj.y = snapshot, GET_X(obj.x, obj), GET_Y(obj.y, obj) end if \'' .. type .. '\' =='
    GAME.lua = GAME.lua .. ' \'GAME.group.tags\' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(GAME.group[child[2]][child[1]])'
    GAME.lua = GAME.lua .. ' end end end doTag(name) end) else doTo(obj) end end)'
end

M['removeFromSnapshot'] = function(params)
    local snapshot, mode = CALC(params[1]), CALC(params[2], 'group')
    local name, type = CALC(params[3]), CALC(params[4], 'GAME.group.objects')

    if type == '(select[\'obj\']())' then type = 'GAME.group.objects'
    elseif type == '(select[\'text\']())' then type = 'GAME.group.texts'
    elseif type == '(select[\'group\']())' then type = 'GAME.group.snapshots'
    elseif type == '(select[\'widget\']())' then type = 'GAME.group.widgets'
    elseif type == '(select[\'snapshot\']())' then type = 'GAME.group.snapshots'
    elseif type == '(select[\'tag\']())' then type = 'GAME.group.tags' end

    GAME.lua = GAME.lua .. ' pcall(function() local name, snapshot = ' .. name .. ', ' .. snapshot .. ' local obj = ' .. type .. '[name]'
    GAME.lua = GAME.lua .. ' local function doTo(obj) GAME.group:insert(obj) obj._snapshot = nil'
    GAME.lua = GAME.lua .. ' obj.x, obj.y = SET_X(obj.x), SET_Y(obj.y) end if \'' .. type .. '\' =='
    GAME.lua = GAME.lua .. ' \'GAME.group.tags\' then pcall(function() local function doTag(tag) for _, child in ipairs(obj) do if child[2]'
    GAME.lua = GAME.lua .. ' == \'tags\' then doTag(child[1]) else doTo(child[1]) end end end doTag(name) end) else doTo(obj) end end)'
end

M['removeSnapshot'] = function(params)
    local name = CALC(params[1])

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' pcall(function()'
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name]:removeSelf() end) GAME.group.snapshots[name] = nil end)'
end

M['showSnapshot'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.snapshots[' .. CALC(params[1]) .. '].isVisible = true end)'
end

M['hideSnapshot'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.snapshots[' .. CALC(params[1]) .. '].isVisible = false end)'
end

M['setSnapshotColor'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name, colors = ' .. CALC(params[1]) .. ', ' .. CALC(params[2], '{255, 255, 255}')
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].clearColor = {colors[1]/255, colors[2]/255, colors[3]/255} end)'
end

M['setSnapshotPos'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() local name, x, y = ' .. CALC(params[1]) .. ', ' .. CALC(params[2]) .. ', ' .. CALC(params[3])
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].x = x == 0 and GAME.group.snapshots[name].x or SET_X(x)'
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].y = y == 0 and GAME.group.snapshots[name].y or SET_Y(y) end)'
end

M['setSnapshotSize'] = function(params)
    local name = CALC(params[1])
    local width = CALC(params[2])
    local height = CALC(params[3])

    GAME.lua = GAME.lua .. ' pcall(function() local w, h, name = ' .. width .. ', ' .. height .. ', ' .. name
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].height = h == 0 and GAME.group.snapshots[name].height or h'
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].width = w == 0 and GAME.group.snapshots[name].width or w end)'
end

M['setSnapshotRotation'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.snapshots[' .. CALC(params[1]) .. '].rotation = ' .. CALC(params[2]) .. ' end)'
end

M['setSnapshotAlpha'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.group.snapshots[' .. CALC(params[1]) .. '].alpha = (' .. CALC(params[2]) .. ') / 100 end)'
end

M['updSnapshotPosX'] = function(params)
    local name = CALC(params[1])
    local posX = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].x ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].x + ' .. posX .. ' end)'
end

M['updSnapshotPosY'] = function(params)
    local name = CALC(params[1])
    local posY = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].y ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].y - ' .. posY .. ' end)'
end

M['updSnapshotWidth'] = function(params)
    local name = CALC(params[1])
    local width = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].width ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].width + ' .. width .. ' end)'
end

M['updSnapshotHeight'] = function(params)
    local name = CALC(params[1])
    local height = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].height ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].height + ' .. height .. ' end)'
end

M['updSnapshotRotation'] = function(params)
    local name = CALC(params[1])
    local rotation = '(' .. CALC(params[2]) .. ')'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].rotation ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].rotation + ' .. rotation .. ' end)'
end

M['updSnapshotAlpha'] = function(params)
    local name = CALC(params[1])
    local alpha = '((' .. CALC(params[2]) .. ') / 100)'

    GAME.lua = GAME.lua .. ' pcall(function() local name = ' .. name .. ' GAME.group.snapshots[name].alpha ='
    GAME.lua = GAME.lua .. ' GAME.group.snapshots[name].alpha + ' .. alpha .. ' end)'
end

return M
