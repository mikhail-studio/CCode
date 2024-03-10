local M = {}

M['device_id'] = function()
    return DEVICE_ID
end

M['get_device'] = function()
    return JSON.decode(GANIN.bluetooth('device'))
end

M['get_devices'] = function()
    return JSON.decode(GANIN.bluetooth('devices'))
end

M['width_screen'] = function()
    return DISPLAY_WIDTH
end

M['height_screen'] = function()
    return DISPLAY_HEIGHT
end

M['top_point_screen'] = function()
    return DISPLAY_HEIGHT / 2
end

M['bottom_point_screen'] = function()
    return -DISPLAY_HEIGHT / 2
end

M['right_point_screen'] = function()
    return DISPLAY_WIDTH / 2
end

M['left_point_screen'] = function()
    return -DISPLAY_WIDTH / 2
end

M['height_top'] = function()
    return TOP_HEIGHT == 0 and display.topStatusBarContentHeight or TOP_HEIGHT
end

M['height_bottom'] = function()
    local _, _, bottom_height = display.getSafeAreaInsets()
    return bottom_height
end

M['finger_touching_screen'] = function()
    return GAME.group.const.touch
end

M['finger_touching_screen_count'] = function()
    return #FINGERS_ARRAY
end

M['finger_touching_screen_x'] = function(index)
    if index and FINGERS_ARRAY[index] then
        return FINGERS_ARRAY[index].x - CENTER_X
    else
        return GAME.group.const.touch_x - CENTER_X
    end
end

M['finger_touching_screen_y'] = function()
    if index and FINGERS_ARRAY[index] then
        return FINGERS_ARRAY[index].y - CENTER_Y
    else
        return CENTER_Y - GAME.group.const.touch_y
    end
end

M['fps'] = function()
    return M.FPS
end

M.start = function()
    M.FPS, M._FPS = 60, 0 timer.performWithDelay(0, function() M._FPS = M._FPS + 1 end, 0)
    timer.performWithDelay(1000, function() M.FPS, M._FPS = M._FPS > 60 and 60 or M._FPS, 0 end, 0)
end

return M
