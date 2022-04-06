local M = {}

M['device_id'] = function()
    return system.getInfo('deviceID')
end

M['width_screen'] = function()
    return DISPLAY_WIDTH
end

M['height_screen'] = function()
    return DISPLAY_HEIGHT
end

M['top_point_screen'] = function()
    return CENTER_Y * 2 - DISPLAY_HEIGHT / 2
end

M['bottom_point_screen'] = function()
    return CENTER_Y * 2 + DISPLAY_HEIGHT / 2
end

M['right_point_screen'] = function()
    return DISPLAY_WIDTH / 2
end

M['left_point_screen'] = function()
    return -DISPLAY_WIDTH / 2
end

M['height_top'] = function()
    return CURRENT_ORIENTATION == 'portrait' and TOP_HEIGHT or TOP_WIDTH
end

M['height_bottom'] = function()
    return CURRENT_ORIENTATION == 'portrait' and BOTTOM_HEIGHT or BOTTOM_WIDTH
end

M['finger_touching_screen'] = function()
    return GAME.group.const.touch
end

M['finger_touching_screen_x'] = function()
    return GAME.group.const.touch_x - CENTER_X
end

M['finger_touching_screen_y'] = function()
    return CENTER_Y - GAME.group.const.touch_y
end

return M
