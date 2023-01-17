local listeners = {}

listeners.programs = function()
    PROGRAMS.group:removeSelf()
    PROGRAMS.group = nil
    MENU.group.isVisible = true
end

listeners.program = function()
    PROGRAM.group:removeSelf()
    PROGRAM.group = nil
    PROGRAMS.group.isVisible = true
end

listeners.scripts = function()
    SCRIPTS.group:removeSelf()
    SCRIPTS.group = nil
    PROGRAM.group.isVisible = true
end

listeners.images = function()
    IMAGES.group:removeSelf()
    IMAGES.group = nil
    PROGRAM.group.isVisible = true
end

listeners.sounds = function()
    SOUNDS.group:removeSelf()
    SOUNDS.group = nil
    PROGRAM.group.isVisible = true
end

listeners.videos = function()
    VIDEOS.group:removeSelf()
    VIDEOS.group = nil
    PROGRAM.group.isVisible = true
end

listeners.fonts = function()
    FONTS.group:removeSelf()
    FONTS.group = nil
    PROGRAM.group.isVisible = true
end

listeners.psettings = function()
    PSETTINGS.group:removeSelf()
    PSETTINGS.group = nil
    PROGRAM.group.isVisible = true
end

listeners.settings = function()
    SETTINGS.group:removeSelf()
    SETTINGS.group = nil
    MENU.group.isVisible = true
end

listeners.blocks = function()
    if BLOCKS.custom then
        local data = GET_GAME_CODE(CURRENT_LINK)

        WINDOW.new(STR['scripts.sandbox.exit'], {STR['scripts.sandbox.not.save'], STR['scripts.sandbox.save']}, function(e)
            if e.index == 2 then
                local custom = GET_GAME_CUSTOM() custom[BLOCKS.custom.index] = {
                    BLOCKS.custom.name, COPY_TABLE(BLOCKS.custom.params), COPY_TABLE(GET_GAME_SCRIPT(CURRENT_LINK, 1, data)),
                    os.time(), COPY_TABLE(BLOCKS.custom.color)
                } custom.len = custom.len + (BLOCKS.custom.isChange and 0 or 1) SET_GAME_CUSTOM(custom)

                if BLOCKS.custom.isChange then
                    for id, type in ipairs(INFO.listBlock.custom) do
                        if type == 'custom' .. BLOCKS.custom.index then
                            table.remove(INFO.listBlock.custom, id)
                            table.insert(INFO.listBlock.custom, 1, 'custom' .. BLOCKS.custom.index)
                            break
                        end
                    end

                    for i = 1, #data.scripts do
                        local script = GET_GAME_SCRIPT(CURRENT_LINK, i, data)

                        for j = 1, #script.params do
                            if script.params[j].name == 'custom' .. BLOCKS.custom.index then
                                local block = custom[BLOCKS.custom.index]
                                local typeBlock = 'custom' .. BLOCKS.custom.index
                                local blockParams = {} for i = 1, #block[2] do blockParams[i] = 'value' end

                                INFO.listName[typeBlock] = {'custom', unpack(blockParams)}

                                if #script.params[j].params >= #block[2] then
                                    for k = #script.params[j].params, #block[2] + 1, -1 do
                                        table.remove(script.params[j].params, k)
                                    end
                                else
                                    for k = #script.params[j].params + 1, #block[2] do
                                        script.params[j].params[k] = {}
                                    end
                                end
                            end
                        end

                        SET_GAME_SCRIPT(CURRENT_LINK, script, i, data)
                    end
                else
                    table.insert(INFO.listBlock.custom, 1, 'custom' .. BLOCKS.custom.index)
                    table.insert(INFO.listBlock.everyone, 'custom' .. BLOCKS.custom.index)
                end
            end

            if e.index ~= 0 then
                DEL_GAME_SCRIPT(CURRENT_LINK, 1, data)
                table.remove(INFO.listBlock.everyone, 1)
                table.remove(data.scripts, 1)
                SET_GAME_CODE(CURRENT_LINK, data)
                CURRENT_SCRIPT = LAST_CURRENT_SCRIPT
                BLOCKS.group:removeSelf() BLOCKS.group = nil
                BLOCKS.create() BLOCKS.custom = nil
                BLOCKS.group.isVisible = false
                NEW_BLOCK.custom(2) BACK.front()
            end
        end, 4) require('Core.Modules.logic-list').remove()
    else
        BLOCKS.group:removeSelf()
        BLOCKS.group = nil
        SCRIPTS.group.isVisible = true
    end
end

listeners.new_block = function()
    NEW_BLOCK.group.isVisible = false
    NEW_BLOCK.group[4].isVisible = false
    BLOCKS.group.isVisible = true
end

listeners.editor = function()
    EDITOR.group:removeSelf()
    EDITOR.group = nil
    BLOCKS.group.isVisible = true
end

listeners.game = function()
    GAME.remove()
    GAME_GROUP_OPEN.group.isVisible = true
end

listeners.add = function(listener, arg)
    listeners.listener = function() listeners.listener = nil listener(arg) end
end

listeners.remove = function()
    listeners.listener = nil
end

listeners.lis = function(event)
    if (event.keyName == 'back' or event.keyName == 'escape') and event.phase == 'up' and ALERT then
        if PROGRAMS and PROGRAMS.group and PROGRAMS.group.isVisible then
            listeners.programs()
        elseif GAME and GAME.isStarted and GAME.needBack and GAME.group and GAME.group.isVisible then
            listeners.game()
        elseif PROGRAM and PROGRAM.group and PROGRAM.group.isVisible then
            listeners.program()
        elseif SCRIPTS and SCRIPTS.group and SCRIPTS.group.isVisible then
            listeners.scripts()
        elseif IMAGES and IMAGES.group and IMAGES.group.isVisible then
            listeners.images()
        elseif SOUNDS and SOUNDS.group and SOUNDS.group.isVisible then
            listeners.sounds()
        elseif VIDEOS and VIDEOS.group and VIDEOS.group.isVisible then
            listeners.videos()
        elseif FONTS and FONTS.group and FONTS.group.isVisible then
            listeners.fonts()
        elseif PSETTINGS and PSETTINGS.group and PSETTINGS.group.isVisible then
            listeners.psettings()
        elseif SETTINGS and SETTINGS.group and SETTINGS.group.isVisible then
            listeners.settings()
        elseif BLOCKS and BLOCKS.group and BLOCKS.group.isVisible then
            listeners.blocks()
        elseif NEW_BLOCK and NEW_BLOCK.group and NEW_BLOCK.group.isVisible then
            listeners.new_block()
        elseif EDITOR and EDITOR.group and EDITOR.group.isVisible then
            listeners.editor()
        end
    elseif (event.keyName == 'back' or event.keyName == 'escape') and event.phase == 'up' then
        if listeners.listener then listeners.listener() end
    end

    if (event.keyName == 'back' or event.keyName == 'escape') and event.phase == 'up' then
        return true
    end
end

Runtime:addEventListener('key', listeners.lis)

return listeners
