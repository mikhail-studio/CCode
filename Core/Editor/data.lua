local M = {}

M.fun = {
    names = {},
    keys = {
        'get_text', 'random_str', 'concat', 'tonumber', 'tostring', 'totable', 'unix_time',
        'encode', 'gsub', 'sub', 'len', 'find', 'color_pixel', 'read_save', 'match'
    }
}

M.math = {
    names = {},
    keys = {
        'random', 'radical', 'power', 'round', 'remainder',
        'module', 'max', 'min', 'sin', 'cos', 'tan', 'ctan', 'pi',
        'exp', 'factorial', 'log', 'log10', 'asin', 'acos', 'atan', 'atan2'
    }
}

M.prop = {
    names = {},
    keys = {
        'touch', 'tag', 'pos_x', 'pos_y', 'width', 'height', 'rotation',
        'alpha', 'name_texture', 'velocity_x', 'velocity_y', 'angular_velocity'
    }
}

M.log = {
    names = {},
    keys = {'true', 'false', '~=', '>', '<', '>=', '<=', 'and', 'or', 'not'}
}

M.device = {
    names = {},
    keys = {
        'fps', 'device_id', 'width_screen', 'height_screen', 'top_point_screen', 'bottom_point_screen', 'right_point_screen',
        'left_point_screen', 'height_top', 'height_bottom', 'finger_touching_screen', 'finger_touching_screen_x', 'finger_touching_screen_y'
    }
}

M.set = function(key, name)
    if (not (EDITOR.data[EDITOR.cursor[1] + 1] and EDITOR.data[EDITOR.cursor[1] + 1][1] == '(' and EDITOR.data[EDITOR.cursor[1] + 1][2] == 's'))
    and (key == 'fS' or key == 'fP' or key == 'f' or key == 'm' or key == 'p'
    --[[or name == 'finger_touching_screen_x' or name == 'finger_touching_screen_y']]) and name ~= 'unix_time' and name ~= 'pi' then
        EDITOR.cursor[1] = EDITOR.cursor[1] + 1
        table.remove(EDITOR.data, EDITOR.cursor[1] - 1)
        table.insert(EDITOR.data, EDITOR.cursor[1] - 1, {'(', 's'})
        table.insert(EDITOR.data, EDITOR.cursor[1], {'|', '|'})
        table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {')', 's'})

        if name == 'gsub' or name == 'sub' then
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
        elseif name == 'find' or name == 'match' or name == 'color_pixel' or name == 'random'
        or name == 'power' or name == 'remainder' or name == 'atan2' then
            table.insert(EDITOR.data, EDITOR.cursor[1] + 1, {',', 's'})
        end
    end
end

M.new = function()
    for i = 1, #M.fun.keys do
        M.fun.names[i] = STR['editor.list.fun.' .. M.fun.keys[i]]
    end

    for i = 1, #M.math.keys do
        M.math.names[i] = STR['editor.list.math.' .. M.math.keys[i]]
    end

    for i = 1, #M.prop.keys do
        M.prop.names[i] = STR['editor.list.prop.' .. M.prop.keys[i]]
    end

    for i = 1, #M.log.keys do
        M.log.names[i] = STR['editor.list.log.' .. M.log.keys[i]]
    end

    for i = 1, #M.device.keys do
        M.device.names[i] = STR['editor.list.device.' .. M.device.keys[i]]
    end
end

return M
