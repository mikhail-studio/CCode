local CALC = require 'Core.Simulation.calc'
local M = {}

if 'Группы' then
    M['newGroup'] = function(params, isLevel)
        local name = CALC(params[1])

        if isLevel then
            name = 'data.title'
        end

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_groups[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_groups[name] = display.newGroup() GAME_groups[name]._tag = \'TAG\''
        GAME.lua = GAME.lua .. '\n GAME_groups[name]._isGroup = true GAME_groups[name].name = name'
        GAME.lua = GAME.lua .. '\n GAME.group:insert(GAME_groups[name]) end)'
    end

    M['newLevel'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local data = JSON.decode(READ_FILE(DOC_DIR'
        GAME.lua = GAME.lua .. '\n .. \'/\' .. other.getLevel(' .. CALC(params[1]) .. ')))'
        require('Core.Simulation.events').BLOCKS['newGroup']({}, true)
        GAME.lua = GAME.lua .. '\n for _, object in ipairs(data.params) do if object.type[1] == \'image\' then'
        require('Core.Simulation.events').BLOCKS['newObject']({}, true)
        require('Core.Simulation.events').BLOCKS['addGroupObject']({}, true)
        GAME.lua = GAME.lua .. '\n elseif object.type[1] == \'text\' then'
        require('Core.Simulation.events').BLOCKS['newText']({}, true)
        require('Core.Simulation.events').BLOCKS['addGroupText']({}, true)
        GAME.lua = GAME.lua .. '\n end end end)'
    end

    M['newContainer'] = function(params)
        local name = CALC(params[1])
        local width = CALC(params[2])
        local height = CALC(params[3])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_groups[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_groups[name] = display.newContainer(' .. width .. ', ' .. height .. ')'
        GAME.lua = GAME.lua .. '\n GAME_groups[name]._tag = \'TAG\' GAME_groups[name]._isContainer = true'
        GAME.lua = GAME.lua .. '\n GAME_groups[name].x = CENTER_X GAME_groups[name].y = CENTER_Y'
        GAME.lua = GAME.lua .. '\n GAME_groups[name].name = name GAME.group:insert(GAME_groups[name]) end)'
    end

    M['removeGroup'] = function(params)
        local name = CALC(params[1])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' pcall(function() GAME_groups[name]:removeSelf() end)'
        GAME.lua = GAME.lua .. '\n GAME_groups[name] = nil end)'
    end

    M['showGroup'] = function(params)
        local name = CALC(params[1])
        local resumePhysics = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local name, resumePhysics = ' .. name .. ', ' .. resumePhysics
        GAME.lua = GAME.lua .. '\n local group = GAME_groups[name] group.isVisible = true'
        GAME.lua = GAME.lua .. '\n if resumePhysics then for index = 1, group.numChildren do local object = {name ='
        GAME.lua = GAME.lua .. '\n group[index].name}' require('Core.Simulation.events').BLOCKS['updHitbox']({}, true)
        GAME.lua = GAME.lua .. '\n end end end)'
    end

    M['hideGroup'] = function(params)
        local name = CALC(params[1])
        local pausePhysics = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local name, pausePhysics = ' .. name .. ', ' .. pausePhysics
        GAME.lua = GAME.lua .. '\n local group = GAME_groups[name] group.isVisible = false'
        GAME.lua = GAME.lua .. '\n if pausePhysics then for index = 1, group.numChildren do'
        GAME.lua = GAME.lua .. '\n pcall(function() PHYSICS.removeBody(group[index]) end) end end end)'
    end

    M['addGroupObject'] = function(params, isLevel)
        local nameGroup = CALC(params[1])
        local nameObject = CALC(params[2])

        if isLevel then
            nameGroup = 'data.title'
            nameObject = 'object.name'
        end

        GAME.lua = GAME.lua .. '\n pcall(function() local nameGroup, nameObject = ' .. nameGroup .. ', ' .. nameObject
        GAME.lua = GAME.lua .. '\n GAME_groups[nameGroup]:insert(GAME_objects[nameObject])'
        GAME.lua = GAME.lua .. '\n if GAME_groups[nameGroup]._isContainer then'
        GAME.lua = GAME.lua .. '\n local obj = GAME_objects[nameObject] obj._container = nameGroup'
        GAME.lua = GAME.lua .. '\n obj.x = SET_X(GET_X(obj.x), obj) obj.y = SET_Y(GET_Y(obj.y), obj) end end)'
    end

    M['addGroupText'] = function(params, isLevel)
        local nameGroup = CALC(params[1])
        local nameText = CALC(params[2])

        if isLevel then
            nameGroup = 'data.title'
            nameText = 'object.name'
        end

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. nameGroup .. ']:insert(GAME_texts[' .. nameText .. ']) end)'
    end

    M['addGroupWidget'] = function(params)
        local nameGroup = CALC(params[1])
        local nameWidget = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. nameGroup .. ']:insert(GAME_widgets[' .. nameWidget .. ']) end)'
    end

    M['addGroupMedia'] = function(params)
        local nameGroup = CALC(params[1])
        local nameMedia = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. nameGroup .. ']:insert(GAME_media[' .. nameMedia .. ']) end)'
    end

    M['addGroupTag'] = function(params)
        local nameGroup = CALC(params[1])
        local nameTag = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else'
        GAME.lua = GAME.lua .. '\n GAME_groups[' .. nameGroup .. ']:insert(GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end end end doTag(' .. nameTag .. ') end)'
    end

    M['addGroupSnapshot'] = function(params)
        local nameGroup = CALC(params[1])
        local nameSnap = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. nameGroup .. ']:insert(GAME_snapshots[' .. nameSnap .. ']) end)'
    end

    M['addGroupGroup'] = function(params)
        local nameGroup = CALC(params[1])
        local nameGroup2 = CALC(params[2])

        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. nameGroup .. ']:insert(GAME_groups[' .. nameGroup2 .. ']) end)'
    end

    M['setGroupPos'] = function(params)
        local name = CALC(params[1])
        local posX = CALC(params[2])
        local posY = CALC(params[3])

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name
        GAME.lua = GAME.lua .. '\n GAME_groups[name].x = SET_X(' .. posX .. ', GAME_groups[name])'
        GAME.lua = GAME.lua .. '\n GAME_groups[name].y =  SET_Y(' .. posY .. ', GAME_groups[name]) end)'
    end

    M['setGroupSize'] = function(params)
        local name = CALC(params[1])
        local width = CALC(params[2])
        local height = CALC(params[3])

        GAME.lua = GAME.lua .. '\n pcall(function() local w, h, name = ' .. width .. ', ' .. height .. ', ' .. name
        GAME.lua = GAME.lua .. '\n GAME_groups[name].height = h == 0 and GAME_groups[name].height or h'
        GAME.lua = GAME.lua .. '\n GAME_groups[name].width = w == 0 and GAME_groups[name].width or w end)'
    end

    M['setGroupRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. CALC(params[1]) .. '].rotation = ' .. CALC(params[2]) .. ' end)'
    end

    M['setGroupAlpha'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. CALC(params[1]) .. '].alpha = (' .. CALC(params[2]) .. ') / 100 end)'
    end

    M['updGroupPosX'] = function(params)
        local name = CALC(params[1])
        local posX = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].x ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].x + ' .. posX .. ' end)'
    end

    M['updGroupPosY'] = function(params)
        local name = CALC(params[1])
        local posY = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].y ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].y - ' .. posY .. ' end)'
    end

    M['updGroupWidth'] = function(params)
        local name = CALC(params[1])
        local width = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].width ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].width + ' .. width .. ' end)'
    end

    M['updGroupHeight'] = function(params)
        local name = CALC(params[1])
        local height = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].height ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].height + ' .. height .. ' end)'
    end

    M['updGroupRotation'] = function(params)
        local name = CALC(params[1])
        local rotation = '(' .. CALC(params[2]) .. ')'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].rotation ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].rotation + ' .. rotation .. ' end)'
    end

    M['updGroupAlpha'] = function(params)
        local name = CALC(params[1])
        local alpha = '((' .. CALC(params[2]) .. ') / 100)'

        GAME.lua = GAME.lua .. '\n pcall(function() local name = ' .. name .. ' GAME_groups[name].alpha ='
        GAME.lua = GAME.lua .. '\n GAME_groups[name].alpha + ' .. alpha .. ' end)'
    end

    M['frontGroup'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. CALC(params[1]) .. ']:toFront() end)'
    end

    M['backGroup'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_groups[' .. CALC(params[1]) .. ']:toBack() end)'
    end

    M['addGroupObjectNoob'] = M['addGroupObject']
end

if 'Теги' then
    M['newTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() GAME_tags[' .. CALC(params[1]) .. '] = {} end)'
    end

    M['removeTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else if child[2] == \'widgets\' then'
        GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() GAME.group[child[2]][child[1]]:removeSelf() end) end)'
        GAME.lua = GAME.lua .. '\n else GAME.group[child[2]][child[1]]:removeSelf() end'
        GAME.lua = GAME.lua .. '\n end end GAME_tags[tag] = nil end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['showTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else if child[2] == \'widgets\' then'
        GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() GAME.group[child[2]][child[1]].isVisible = true end) end)'
        GAME.lua = GAME.lua .. '\n else GAME.group[child[2]][child[1]].isVisible = true end'
        GAME.lua = GAME.lua .. '\n end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['hideTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else if child[2] == \'widgets\' then'
        GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() GAME.group[child[2]][child[1]].isVisible = false end) end)'
        GAME.lua = GAME.lua .. '\n else GAME.group[child[2]][child[1]].isVisible = false end'
        GAME.lua = GAME.lua .. '\n end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['addTagObject'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_objects[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_objects[name]._tag]) do if info[1] == name and info[2] == \'objects\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_objects[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'objects\'}) GAME_objects[name]._tag = tag end)'
    end

    M['addTagText'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_texts[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_texts[name]._tag]) do if info[1] == name and info[2] == \'texts\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_texts[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'texts\'}) GAME_texts[name]._tag = tag end)'
    end

    M['addTagWidget'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_widgets[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_widgets[name]._tag]) do if info[1] == name and info[2] == \'widgets\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_widgets[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'widgets\'}) GAME_widgets[name]._tag = tag end)'
    end

    M['addTagMedia'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_media[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_media[name]._tag]) do if info[1] == name and info[2] == \'media\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_media[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'media\'}) GAME_media[name]._tag = tag end)'
    end

    M['addTagGroup'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_groups[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_groups[name]._tag]) do if info[1] == name and info[2] == \'groups\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_groups[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'groups\'}) GAME_groups[name]._tag = tag end)'
    end

    M['addTagTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local name, tag = ' .. CALC(params[2]) .. ', ' .. CALC(params[1])
        GAME.lua = GAME.lua .. '\n if GAME_tags[name]._tag ~= \'TAG\' then for index, info in'
        GAME.lua = GAME.lua .. '\n ipairs(GAME_tags[GAME_tags[name]._tag]) do if info[1] == name and info[2] == \'tags\''
        GAME.lua = GAME.lua .. '\n then table.remove(GAME_tags[GAME_tags[name]._tag], index) break end end end'
        GAME.lua = GAME.lua .. '\n table.insert(GAME_tags[tag], {name, \'tags\'}) end)'
    end

    M['setTagPos'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].x = SET_X(' .. CALC(params[2]) .. ','
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].y = SET_Y(' .. CALC(params[3]) .. ','
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]])'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagSize'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else local w, h = ' .. CALC(params[2]) .. ', ' .. CALC(params[3])
        GAME.lua = GAME.lua .. '\n pcall(function() GAME.group[child[2]][child[1]].width = w == 0 and GAME.group[child[2]][child[1]].width or w'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].height = h == 0 and GAME.group[child[2]][child[1]].height or h'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].rotation = ' .. CALC(params[2])
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['setTagAlpha'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].alpha = (' .. CALC(params[2]) .. ') / 100'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagPosX'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].x = GAME.group[child[2]][child[1]].x + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagPosY'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].y = GAME.group[child[2]][child[1]].y - (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagWidth'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].width = GAME.group[child[2]][child[1]].width + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagHeight'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].height = GAME.group[child[2]][child[1]].height + (' .. CALC(params[2]) .. ')'
        GAME.lua = GAME.lua .. '\n end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagRotation'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].rotation = GAME.group[child[2]][child[1]].rotation +'
        GAME.lua = GAME.lua .. '\n (' .. CALC(params[2]) .. ') end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['updTagAlpha'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else pcall(function()'
        GAME.lua = GAME.lua .. '\n GAME.group[child[2]][child[1]].alpha = GAME.group[child[2]][child[1]].alpha +'
        GAME.lua = GAME.lua .. '\n ((' .. CALC(params[2]) .. ') / 100) end) end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['frontTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else if child[2] == \'widgets\' then'
        GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() GAME.group[child[2]][child[1]]:toFront() end) end)'
        GAME.lua = GAME.lua .. '\n else GAME.group[child[2]][child[1]].isVisible = true end'
        GAME.lua = GAME.lua .. '\n end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['backTag'] = function(params)
        GAME.lua = GAME.lua .. '\n pcall(function() local function doTag(tag) for _, child in ipairs(GAME_tags[tag]) do'
        GAME.lua = GAME.lua .. '\n if child[2] == \'tags\' then doTag(child[1]) else if child[2] == \'widgets\' then'
        GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() GAME.group[child[2]][child[1]]:toBack() end) end)'
        GAME.lua = GAME.lua .. '\n else GAME.group[child[2]][child[1]].isVisible = true end'
        GAME.lua = GAME.lua .. '\n end end end doTag(' .. CALC(params[1]) .. ') end)'
    end

    M['addTagObjectNoob'] = M['addTagObject']
end

return M
