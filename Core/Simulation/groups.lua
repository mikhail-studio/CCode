local CALC = require 'Core.Simulation.calc'
local M = {}

if 'Группы' then
    M['newGroup'] = function(params)
        local name = CALC(params[1])

        GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.groups[' .. name .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '] = display.newGroup() GAME.group.groups[' .. name .. ']._tag = \'TAG\''
        GAME.lua = GAME.lua .. ' GAME.group:insert(GAME.group.groups[' .. name .. ']) end)'
    end

    M['removeGroup'] = function(params)
        local name = CALC(params[1])

        GAME.lua = GAME.lua .. ' pcall(function() pcall(function() GAME.group.groups[' .. name .. ']:removeSelf() end)'
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '] = nil end)'
    end

    M['showGroup'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].isVisible = true end)'
    end

    M['hideGroup'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].isVisible = false end)'
    end

    M['addGroupObject'] = function(params)
        local nameGroup = CALC(params[1])
        local nameObject = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.objects[' .. nameObject .. ']) end)'
    end

    M['addGroupText'] = function(params)
        local nameGroup = CALC(params[1])
        local nameText = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.texts[' .. nameText .. ']) end)'
    end

    M['addGroupWidget'] = function(params)
        local nameGroup = CALC(params[1])
        local nameWidget = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.widgets[' .. nameWidget .. ']) end)'
    end

    M['addGroupMedia'] = function(params)
        local nameGroup = CALC(params[1])
        local nameMedia = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.media[' .. nameMedia .. ']) end)'
    end

    M['addGroupTag'] = function(params)
        local nameGroup = CALC(params[1])
        local nameTag = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. nameTag .. ') end)'
    end

    M['addGroupGroup'] = function(params)
        local nameGroup = CALC(params[1])
        local nameGroup2 = CALC(params[2])

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. nameGroup .. ']:insert(GAME.group.groups[' .. nameGroup2 .. ']) end)'
    end

    M['setGroupPos'] = function(params)
        local name = CALC(params[1])
        local posX = CALC(params[2])
        local posY = '0 - (' .. CALC(params[3]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].x = ' .. posX
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].y = ' .. posY .. ' end)'
    end

    M['setGroupSize'] = function(params)
        local name = CALC(params[1])
        local width = CALC(params[2])
        local height = CALC(params[3])

        GAME.lua = GAME.lua .. ' pcall(function() local w, h = ' .. width .. ', ' .. height
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].height = h == 0 and GAME.group.groups[' .. name .. '].height or h'
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].width = w == 0 and GAME.group.groups[' .. name .. '].width or w end)'
    end

    M['setGroupRotation'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].rotation = ' .. CALC(params[2]) .. ' end)'
    end

    M['setGroupAlpha'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. CALC(params[1]) .. '].alpha = (' .. CALC(params[2]) .. ') / 100 end)'
    end

    M['updGroupPosX'] = function(params)
        local name = CALC(params[1])
        local posX = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].x ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].x + ' .. posX .. ' end)'
    end

    M['updGroupPosY'] = function(params)
        local name = CALC(params[1])
        local posY = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].y ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].y - ' .. posY .. ' end)'
    end

    M['updGroupWidth'] = function(params)
        local name = CALC(params[1])
        local width = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].width ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].width + ' .. width .. ' end)'
    end

    M['updGroupHeight'] = function(params)
        local name = CALC(params[1])
        local height = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].height ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].height + ' .. height .. ' end)'
    end

    M['updGroupRotation'] = function(params)
        local name = CALC(params[1])
        local rotation = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].rotation ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].rotation + ' .. rotation .. ' end)'
    end

    M['updGroupAlpha'] = function(params)
        local name = CALC(params[1])
        local alpha = '((' .. CALC(params[2]) .. ') / 100)'

        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.groups[' .. name .. '].alpha ='
        GAME.lua = GAME.lua .. ' GAME.group.groups[' .. name .. '].alpha + ' .. alpha .. ' end)'
    end
end

if 'Теги' then
    M['newTag'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() GAME.group.tags[' .. CALC(params[1]) .. '] = {} end)'
    end

    M['removeTag'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else GAME.group[child[2]][child[1]]:removeSelf()'
        GAME.lua = GAME.lua .. ' end end GAME.group.tags[tag] = nil end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['showTag'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].isVisible = true'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['hideTag'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].isVisible = false'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['addTagObject'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'objects\'}) GAME.group.objects[name]._tag = tag end)'
    end

    M['addTagText'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'texts\'}) GAME.group.texts[name]._tag = tag end)'
    end

    M['addTagWidget'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'widgets\'}) GAME.group.widgets[name]._tag = tag end)'
    end

    M['addTagMedia'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'media\'}) GAME.group.media[name]._tag = tag end)'
    end

    M['addTagGroup'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'groups\'}) GAME.group.groups[name]._tag = tag end)'
    end

    M['addTagTag'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. ' table.insert(GAME.group.tags[tag], {name, \'tags\'}) end)'
    end

    M['setTagPos'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].x = SET_X(' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].y = SET_Y(' .. CALC(params[3]) .. ')'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagSize'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else local w, h = ' .. CALC(params[2]) .. ', ' .. CALC(params[3])
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].width = w == 0 and GAME.group[child[2]][child[1]].width or w'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].height = h == 0 and GAME.group[child[2]][child[1]].height or h'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagRotation'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].rotation = ' .. CALC(params[2])
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagAlpha'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].alpha = (' .. CALC(params[2]) .. ') / 100'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagPosX'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].x = GAME.group[child[2]][child[1]].x + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagPosY'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].y = GAME.group[child[2]][child[1]].y - (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagWidth'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].width = GAME.group[child[2]][child[1]].width + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagHeight'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].height = GAME.group[child[2]][child[1]].height + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. ' end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagRotation'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].rotation = GAME.group[child[2]][child[1]].rotation +'
        GAME.lua = GAME.lua .. ' (' .. CALC(params[2]) .. ') end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagAlpha'] = function(params)
        GAME.lua = GAME.lua .. ' pcall(function() local function doTag(tag) for _, child in ipairs(GAME.group.tags[tag]) do'
        GAME.lua = GAME.lua .. ' if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. ' GAME.group[child[2]][child[1]].alpha = GAME.group[child[2]][child[1]].alpha +'
        GAME.lua = GAME.lua .. ' ((' .. CALC(params[2]) .. ') / 100) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end
end

return M
