local M = {}

if 'Объект' then
    M['obj.touch'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name]._touch or false
        end) return isComplete and result
    end

    M['obj.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['obj.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name].x - CENTER_X or 0
        end) return isComplete and result or 0
    end

    M['obj.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and 0 - GAME.group.objects[name].y + CENTER_Y or 0
        end) return isComplete and result or 0
    end

    M['obj.width'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME.group.objects[name] and GAME.group.objects[name]._radius)
            and (GAME.group.objects[name].path.radius or 0) or (GAME.group.objects[name] and GAME.group.objects[name].width or 0)
        end) return isComplete and result or 0
    end

    M['obj.height'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME.group.objects[name] and GAME.group.objects[name]._radius)
            and (GAME.group.objects[name].path.radius or 0) or (GAME.group.objects[name] and GAME.group.objects[name].height or 0)
        end) return isComplete and result or 0
    end

    M['obj.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['obj.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end

    M['obj.name_texture'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name] and GAME.group.objects[name]._name or ''
        end) return isComplete and result or ''
    end

    M['obj.velocity_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name]._body ~= '' and select(1, GAME.group.objects[name]:getLinearVelocity()) or 0
        end) return isComplete and result or 0
    end

    M['obj.velocity_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name]._body ~= '' and 0 - select(2, GAME.group.objects[name]:getLinearVelocity()) or 0
        end) return isComplete and result or 0
    end

    M['obj.angular_velocity'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.objects[name]._body ~= '' and GAME.group.objects[name].angularVelocity or 0
        end) return isComplete and result or 0
    end
end

if 'Текст' then
    M['text.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['text.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name].x - CENTER_X or 0
        end) return isComplete and result or 0
    end

    M['text.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and 0 - GAME.group.texts[name].y + CENTER_Y or 0
        end) return isComplete and result or 0
    end

    M['text.width'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name].width or 0
        end) return isComplete and result or 0
    end

    M['text.height'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name].height or 0
        end) return isComplete and result or 0
    end

    M['text.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['text.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.texts[name] and GAME.group.texts[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end
end

if 'Группа' then
    M['group.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['group.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name].x or 0
        end) return isComplete and result or 0
    end

    M['group.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and 0 - GAME.group.groups[name].y or 0
        end) return isComplete and result or 0
    end

    M['group.width'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name].width or 0
        end) return isComplete and result or 0
    end

    M['group.height'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name].height or 0
        end) return isComplete and result or 0
    end

    M['group.rotation'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name].rotation or 0
        end) return isComplete and result or 0
    end

    M['group.alpha'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.groups[name] and GAME.group.groups[name].alpha * 100 or 100
        end) return isComplete and result or 100
    end
end

if 'Виджет' then
    M['widget.tag'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and GAME.group.widgets[name]._tag or ''
        end) return isComplete and result or ''
    end

    M['widget.pos_x'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and GAME.group.widgets[name].x - CENTER_X or 0
        end) return isComplete and result or 0
    end

    M['widget.pos_y'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and 0 - GAME.group.widgets[name].y + CENTER_Y or 0
        end) return isComplete and result or 0
    end

    M['widget.value'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'slider' and GAME.group.widgets[name].value or 0) or 50
        end) return isComplete and result or 50
    end

    M['widget.text'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'field' and GAME.group.widgets[name].text or '') or ''
        end) return isComplete and result or ''
    end

    M['widget.link'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.widgets[name] and (GAME.group.widgets[name]._type == 'webview' and GAME.group.widgets[name].url or '') or ''
        end) return isComplete and result or ''
    end
end

if 'Медиа' then
    M['media.current_time'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.media[name] and GAME.group.media[name].currentTime or 0
        end) return isComplete and result or 0
    end

    M['media.total_time'] = function(name)
        local isComplete, result = pcall(function()
            return GAME.group.media[name] and GAME.group.media[name].totalTime or 0
        end) return isComplete and result or 0
    end

    M['media.sound_volume'] = function(name)
        local isComplete, result = pcall(function()
            return audio.getVolume((GAME.group.media[name] and GAME.group.media[name][2]) and {channel=GAME.group.media[name][2]} or nil)
        end) return isComplete and result or 0
    end

    M['media.sound_total_time'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME.group.media[name] and GAME.group.media[name][1]) and audio.getDuration(GAME.group.media[name][1]) or 0
        end) return isComplete and result or 0
    end

    M['media.sound_pause'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME.group.media[name] and GAME.group.media[name][2]) and audio.isChannelPaused(GAME.group.media[name][2]) or nil
        end) return isComplete and result or nil
    end

    M['media.sound_play'] = function(name)
        local isComplete, result = pcall(function()
            return (GAME.group.media[name] and GAME.group.media[name][2]) and audio.isChannelPlaying(GAME.group.media[name][2]) or nil
        end) return isComplete and result or nil
    end
end

return M
