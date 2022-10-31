local COLOR = require 'Core.Modules.interface-color'
local LIST = require 'Core.Modules.interface-list'
local INFO = require 'Data.info'
local M = {}

M.getListButtons = function(type)
    if type == 'body' then
        return {STR['blocks.select.dynamic'], STR['blocks.select.static']}
    elseif type == 'animation' then
        return {STR['blocks.select.forward'], STR['blocks.select.bounce']}
    end
end

M.getListValue = function(type, text)
    if type == 'body' then
        return text == STR['blocks.select.dynamic'] and 'dynamic' or 'static'
    elseif type == 'animation' then
        return text == STR['blocks.select.forward'] and 'forward' or 'bounce'
    end
end

M.open = function(target)
    local BLOCK = require 'Core.Modules.logic-block'
    local LOGIC = require 'Core.Modules.logic-input'
    local data = GET_GAME_CODE(CURRENT_LINK)
    local paramsIndex = target.index
    local blockName = target.parent.parent.data.name
    local blockX, blockY = target.parent.parent.x, target.parent.parent.y
    local blockIndex = target.parent.parent.getIndex(target.parent.parent)
    local scrollY = select(2, BLOCKS.scroll:getContentPosition())
    local paramsData = data.scripts[CURRENT_SCRIPT].params[blockIndex].params[paramsIndex]
    local listDirection = blockY + target.y + scrollY > CENTER_Y and 'up' or 'down'
    local listY = blockY + target.y + (listDirection == 'up' and target.height / 2 or -target.height / 2) + scrollY
    local listX, type = blockX + target.x + target.width / 2, INFO.listName[blockName][paramsIndex + 1]

    if type == 'text' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        INPUT.new(STR['blocks.entertext'], function(event)
            if (event.phase == 'ended' or event.phase == 'submitted') and not ALERT then
                INPUT.remove(true, event.target.text)
            end
        end, function(e)
            if e.input then
                data.scripts[CURRENT_SCRIPT].params[blockIndex].params[paramsIndex][1] = {e.text, 't'}
                target.parent.parent.data.params[paramsIndex][1] = {e.text, 't'}
                target.parent.parent.params[paramsIndex].value.text = BLOCK.getParamsValueText(target.parent.parent.data.params, paramsIndex)
                SET_GAME_CODE(CURRENT_LINK, data)
            end BLOCKS.group[8]:setIsLocked(false, 'vertical')
        end, (paramsData[1] and paramsData[1][1]) and paramsData[1][1] or '') native.setKeyboardFocus(INPUT.box)
    elseif type == 'value' and ALERT then
        -- if CENTER_X == 640 and system.getInfo 'environment' ~= 'simulator' then ADMOB.hide() end
        EDITOR = require 'Core.Editor.interface'
        EDITOR.create(blockName, blockIndex, paramsData, paramsIndex)
    elseif type == 'var' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LOGIC.new('vars', blockIndex, paramsIndex, COPY_TABLE(paramsData))
    elseif type == 'localvar' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LOGIC.new('vars', blockIndex, paramsIndex, COPY_TABLE(paramsData), true)
    elseif type == 'table' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LOGIC.new('tables', blockIndex, paramsIndex, COPY_TABLE(paramsData))
    elseif type == 'localtable' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LOGIC.new('tables', blockIndex, paramsIndex, COPY_TABLE(paramsData), true)
    elseif type == 'fun' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LOGIC.new('funs', blockIndex, paramsIndex, COPY_TABLE(paramsData))
    elseif type == 'color' and ALERT then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        COLOR.new(COPY_TABLE((paramsData[1] and paramsData[1][1]) and JSON.decode(paramsData[1][1]) or {255, 255, 255}), function(e)
            if e.input then
                data.scripts[CURRENT_SCRIPT].params[blockIndex].params[paramsIndex][1] = {e.rgb, 'c'}
                target.parent.parent.data.params[paramsIndex][1] = {e.rgb, 'c'}
                target.parent.parent.params[paramsIndex].value.text = BLOCK.getParamsValueText(target.parent.parent.data.params, paramsIndex)
                SET_GAME_CODE(CURRENT_LINK, data)
            end BLOCKS.group[8]:setIsLocked(false, 'vertical')
        end)
    elseif type == 'body' or type == 'animation' then
        BLOCKS.group[8]:setIsLocked(true, 'vertical')
        LIST.new(M.getListButtons(type), listX, listY, listDirection, function(e)
            if e.index > 0 then
                data.scripts[CURRENT_SCRIPT].params[blockIndex].params[paramsIndex][1] = {M.getListValue(type, e.text), 'sl'}
                target.parent.parent.data.params[paramsIndex][1] = {M.getListValue(type, e.text), 'sl'}
                target.parent.parent.params[paramsIndex].value.text = BLOCK.getParamsValueText(target.parent.parent.data.params, paramsIndex)
                SET_GAME_CODE(CURRENT_LINK, data)
            end BLOCKS.group[8]:setIsLocked(false, 'vertical')
        end)
    end
end

return M
