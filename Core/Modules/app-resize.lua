local function appResize(type, listener)
    if CURRENT_ORIENTATION ~= type then
        CENTER_X, CENTER_Y = CENTER_Y, CENTER_X
        DISPLAY_WIDTH, DISPLAY_HEIGHT = DISPLAY_HEIGHT, DISPLAY_WIDTH
        TOP_HEIGHT, LEFT_HEIGHT = LEFT_HEIGHT, TOP_HEIGHT
        BOTTOM_HEIGHT, RIGHT_HEIGHT = RIGHT_HEIGHT, BOTTOM_HEIGHT

        ZERO_X = CENTER_X - DISPLAY_WIDTH / 2 + LEFT_HEIGHT
        ZERO_Y = CENTER_Y - DISPLAY_HEIGHT / 2 + TOP_HEIGHT
        MAX_X = CENTER_X + DISPLAY_WIDTH / 2 - RIGHT_HEIGHT
        MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT
    end

    CURRENT_ORIENTATION = type
    ORIENTATION.lock(CURRENT_ORIENTATION)
    if listener then listener({orientation = type}) end
end

function setOrientationApp(event)
    appResize(event.type, event.lis)
end
