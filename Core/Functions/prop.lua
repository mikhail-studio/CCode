local M = {}

if 'Объект' then
    M['obj.touch'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name]._touch or false
        end) return isComplete and result
    end

    M['obj.var'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name]._data or {}
        end) return isComplete and result or {}
    end

    M['obj.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['obj.group'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_objects[name] and GAME_objects[name].parent) and GAME_objects[name].parent.name or ''
        end) return isComplete and result or ''
    end

    M['obj.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GET_X(GAME_objects[name].x, GAME_objects[name]) or 0
        end) return isComplete and result or 0
    end

    M['obj.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GET_Y(GAME_objects[name].y, GAME_objects[name]) or 0
        end) return isComplete and result or 0
    end

    M['obj.width'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_objects[name] and GAME_objects[name]._radius)
            and (GAME_objects[name].path.radius or 0) or (GAME_objects[name] and GAME_objects[name].width or 0)
        end) return isComplete and result or 0
    end

    M['obj.height'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_objects[name] and GAME_objects[name]._radius)
            and (GAME_objects[name].path.radius or 0) or (GAME_objects[name] and GAME_objects[name].height or 0)
        end) return isComplete and result or 0
    end

    M['obj.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['obj.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end

    M['obj.distance'] = function(name1, name2)
        local isComplete, result = pcall(function()
            return _G.math.sqrt(((GAME_objects[name1].x - GAME_objects[name2].x) ^ 2)
            + ((GAME_objects[name1].y - GAME_objects[name2].y) ^ 2))
        end) return isComplete and result or 0
    end

    M['obj.name_texture'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name] and GAME_objects[name]._name or ''
        end) return isComplete and result or ''
    end

    M['obj.velocity_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name]._body ~= '' and select(1, GAME_objects[name]:getLinearVelocity()) or 0
        end) return isComplete and result or 0
    end

    M['obj.velocity_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name]._body ~= '' and 0 - select(2, GAME_objects[name]:getLinearVelocity()) or 0
        end) return isComplete and result or 0
    end

    M['obj.angular_velocity'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_objects[name]._body ~= '' and GAME_objects[name].angularVelocity or 0
        end) return isComplete and result or 0
    end
end

if 'Текст' then
    M['text.get_text'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name or '0'] and GAME_texts[name or '0'].text or ''
        end) return isComplete and result or ''
    end

    M['text.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GAME_texts[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['text.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GET_X(GAME_texts[name].x, GAME_texts[name]) or 0
        end) return isComplete and result or 0
    end

    M['text.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GET_Y(GAME_texts[name].y, GAME_texts[name]) or 0
        end) return isComplete and result or 0
    end

    M['text.width'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GAME_texts[name].width or 0
        end) return isComplete and result or 0
    end

    M['text.height'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GAME_texts[name].height or 0
        end) return isComplete and result or 0
    end

    M['text.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GAME_texts[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['text.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_texts[name] and GAME_texts[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end
end

if 'Группа' then
    M['group.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['group.table'] = function(name)
        local isComplete, result = pcall(function()
            if GAME_groups[name] then
                local t = {} for i = 1, GAME_groups[name].numChildren do
                    table.insert(t, GAME_groups[name][i].name or '')
                end return t
            end
        end) return isComplete and result or ''
    end

    M['group.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name].x or 0
        end) return isComplete and result or 0
    end

    M['group.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and 0 - GAME_groups[name].y or 0
        end) return isComplete and result or 0
    end

    M['group.width'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name].width or 0
        end) return isComplete and result or 0
    end

    M['group.height'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name].height or 0
        end) return isComplete and result or 0
    end

    M['group.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['group.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_groups[name] and GAME_groups[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end
end

if 'Виджет' then
    M['widget.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and GAME_widgets[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['widget.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and GET_X(GAME_widgets[name].x, GAME_widgets[name]) or 0
        end) return isComplete and result or 0
    end

    M['widget.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and GET_Y(GAME_widgets[name].y, GAME_widgets[name]) or 0
        end) return isComplete and result or 0
    end

    M['widget.value'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and (GAME_widgets[name].wtype == 'slider' and GAME_widgets[name].value or 0) or 50
        end) return isComplete and result or 50
    end

    M['widget.state'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name]
                and (GAME_widgets[name].wtype == 'switch' and GAME_widgets[name].isOn or false) or false
        end) return isComplete and result
    end

    M['widget.text'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and (GAME_widgets[name].wtype == 'field' and GAME_widgets[name].text or '') or ''
        end) return isComplete and result or ''
    end

    M['widget.link'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_widgets[name] and (GAME_widgets[name].wtype == 'webview' and GAME_widgets[name].url or '') or ''
        end) return isComplete and result or ''
    end
end

if 'Медиа' then
    M['media.current_time'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_media[name] and GAME_media[name].currentTime or 0
        end) return isComplete and result or 0
    end

    M['media.total_time'] = function(name)
        local isComplete, result = pcall(function()
            return GAME_media[name] and GAME_media[name].totalTime or 0
        end) return isComplete and result or 0
    end

    M['media.sound_volume'] = function(name)
        local isComplete, result = pcall(function()
            return audio.getVolume((GAME_media[name] and GAME_media[name][2]) and {channel=GAME_media[name][2]} or nil)
        end) return isComplete and result or 0
    end

    M['media.sound_total_time'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_media[name] and GAME_media[name][1]) and audio.getDuration(GAME_media[name][1]) or 0
        end) return isComplete and result or 0
    end

    M['media.sound_pause'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_media[name] and GAME_media[name][2]) and audio.isChannelPaused(GAME_media[name][2]) or nil
        end) return isComplete and result or nil
    end

    M['media.sound_play'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME_media[name] and GAME_media[name][2]) and audio.isChannelPlaying(GAME_media[name][2]) or nil
        end) return isComplete and result or nil
    end
end

if 'Файлы' then
    M['files.length'] = function(path, isTemp)
        local isComplete, result = pcall(function()
            return GANIN.file('length', DOC_DIR .. '/' .. CURRENT_LINK .. '/' .. (isTemp and 'Temps' or 'Documents') .. '/' .. path)
        end) return isComplete and result or 0
    end

    M['files.is_file'] = function(path, isTemp)
        local isComplete, result = pcall(function()
            return GANIN.file('is_file', DOC_DIR .. '/' .. CURRENT_LINK .. '/' .. (isTemp and 'Temps' or 'Documents') .. '/' .. path)
        end) return isComplete and result or false
    end

    M['files.is_folder'] = function(path, isTemp)
        local isComplete, result = pcall(function()
            return GANIN.file('is_folder', DOC_DIR .. '/' .. CURRENT_LINK .. '/' .. (isTemp and 'Temps' or 'Documents') .. '/' .. path)
        end) return isComplete and result or false
    end

    M['files.length_folder'] = function(path, isTemp)
        local isComplete, result = pcall(function()
            return GANIN.file('length_folder', DOC_DIR .. '/' .. CURRENT_LINK .. '/' .. (isTemp and 'Temps' or 'Documents') .. '/' .. path)
        end) return isComplete and result or 0
    end

    M['files.last_modified'] = function(path, isTemp)
        local isComplete, result = pcall(function()
            return GANIN.file('last_modified', DOC_DIR .. '/' .. CURRENT_LINK .. '/' .. (isTemp and 'Temps' or 'Documents') .. '/' .. path)
        end) return isComplete and result or 0
    end
end

return M
