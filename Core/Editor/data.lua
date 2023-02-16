local M = {}

M.fun = {
    names = {},
    keys = {
        'read_save', 'encode', 'len_table', 'concat', 'totable', 'tostring', 'tonumber', 'len', 'find',
        'sub', 'gsub', 'split', 'unix_time', 'color_pixel', 'get_ip', 'random_str', 'match', 'noise'
    }
}

M.math = {
    names = {},
    keys = {
        'random', 'radical', 'power', 'round', 'remainder',
        'module', 'max', 'min', 'sin', 'cos', 'tan', 'ctan', 'pi',
        'exp', 'factorial', 'log0', 'log10', 'asin', 'acos', 'atan', 'atan2', 'raycast'
    }
}

M.prop = {
    obj = {
        names = {},
        keys = {
            'touch', 'var', 'tag', 'pos_x', 'pos_y', 'width', 'height', 'rotation',
            'alpha', 'name_texture', 'velocity_x', 'velocity_y', 'angular_velocity'
        }
    },

    text = {
        names = {},
        keys = {
            'get_text', 'tag', 'pos_x', 'pos_y', 'width', 'height', 'rotation', 'alpha'
        }
    },

    group = {
        names = {},
        keys = {
            'tag', 'pos_x', 'pos_y', 'width', 'height', 'rotation', 'alpha'
        }
    },

    widget = {
        names = {},
        keys = {
            'tag', 'pos_x', 'pos_y', 'value', 'state', 'text', 'link'
        }
    },

    media = {
        names = {},
        keys = {
            'current_time', 'total_time', 'sound_volume', 'sound_total_time', 'sound_pause', 'sound_play'
        }
    }
}

M.log = {
    names = {},
    keys = {'true', 'false', 'nil', 'or', 'and', '~=', '>', '<', '>=', '<=', 'not'}
}

M.device = {
    names = {},
    keys = {
        'fps', 'device_id', 'width_screen', 'height_screen', 'top_point_screen',
        'bottom_point_screen', 'right_point_screen', 'left_point_screen', 'height_top', 'height_bottom',
        'finger_touching_screen', 'finger_touching_screen_x', 'finger_touching_screen_y'
    }
}

M.set = function(key, name)
    if (not (EDITOR.data[EDITOR.cursor[1] + 1] and EDITOR.data[EDITOR.cursor[1] + 1][1] == '('
    and EDITOR.data[EDITOR.cursor[1] + 1][2] == 's'))
    and (key == 'fC' or key == 'fS' or key == 'fP' or key == 'f' or key == 'm' or key == 'p'
    --[[or name == 'finger_touching_screen_x' or name == 'finger_touching_screen_y']]) and name ~= 'unix_time' and name ~= 'pi' then
        EDITOR.cursor[1] = EDITOR.cursor[1] + 1
        table.remove(EDITOR.data, EDITOR.cursor[1] - 1)
        table.insert(EDITOR.data, EDITOR.cursor[1] - 1, {'(', 's'})
        table.insert(EDITOR.data, EDITOR.cursor[1], {'|', '|'})
        table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {')', 's'})

        if name == 'raycast' then
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
        elseif name == 'gsub' or name == 'sub' then
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
        elseif name == 'find' or name == 'match' or name == 'color_pixel' or name == 'random'
        or name == 'power' or name == 'remainder' or name == 'atan2' or name == 'noise' or name == 'round' then
            if name == 'round' then table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {'0', 'n'}) end
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
        end
    end
end

M.new = function()
    M.prop.obj.names, M.prop.media.names, M.fun.names = {}, {}, {}

    for i = 1, #M.prop.text.keys do
        M.prop.text.names[i] = STR['editor.list.prop.text.' .. M.prop.text.keys[i]]
    end

    for i = 1, #M.prop.group.keys do
        M.prop.group.names[i] = STR['editor.list.prop.group.' .. M.prop.group.keys[i]]
    end

    for i = #M.prop.media.keys, 1, -1 do
        table.insert(M.prop.media.names, 1, STR['editor.list.prop.media.' .. M.prop.media.keys[i]])

        if NOOBMODE and (M.prop.media.keys[i] == 'current_time' or M.prop.media.keys[i] == 'total_time') then
            table.remove(M.prop.media.names, 1)
        end
    end

    for i = 1, #M.prop.widget.keys do
        M.prop.widget.names[i] = STR['editor.list.prop.widget.' .. M.prop.widget.keys[i]]
    end

    for i = #M.prop.obj.keys, 1, -1 do
        table.insert(M.prop.obj.names, 1, STR['editor.list.prop.obj.' .. M.prop.obj.keys[i]])

        if NOOBMODE and (M.prop.obj.keys[i] == 'var' or M.prop.obj.keys[i] == 'name_texture') then
            table.remove(M.prop.obj.names, 1)
        end
    end

    for i = #M.fun.keys, 1, -1 do
        table.insert(M.fun.names, 1, STR['editor.list.fun.' .. M.fun.keys[i]])

        if NOOBMODE and (M.fun.keys[i] == 'read_save' or M.fun.keys[i] == 'noise'
        or M.fun.keys[i] == 'split' or M.fun.keys[i] == 'get_ip' or M.fun.keys[i] == 'match') then
            table.remove(M.fun.names, 1)
        end
    end

    if NOOBMODE then
        local index = table.indexOf(M.fun.names, STR['editor.list.fun.random_str'])
            table.insert(M.fun.names, table.indexOf(M.fun.names, STR['editor.list.fun.concat']) + 1, M.fun.names[index])
            table.remove(M.fun.names, index + 1)
        local index = table.indexOf(M.fun.names, STR['editor.list.fun.totable'])
            table.insert(M.fun.names, M.fun.names[index])
            table.remove(M.fun.names, index)
        local index = table.indexOf(M.fun.names, STR['editor.list.fun.len_table'])
            table.insert(M.fun.names, M.fun.names[index])
            table.remove(M.fun.names, index)
        local index = table.indexOf(M.fun.names, STR['editor.list.fun.encode'])
            table.insert(M.fun.names, M.fun.names[index])
            table.remove(M.fun.names, index)
    end

    for i = 1, #M.math.keys do
        M.math.names[i] = STR['editor.list.math.' .. M.math.keys[i]]
    end

    for i = 1, #M.log.keys do
        M.log.names[i] = STR['editor.list.log.' .. M.log.keys[i]]
    end

    for i = 1, #M.device.keys do
        M.device.names[i] = STR['editor.list.device.' .. M.device.keys[i]]
    end
end

return M
