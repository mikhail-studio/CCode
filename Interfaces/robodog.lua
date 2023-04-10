local LISTENER = require 'Core.Interfaces.robodog'
local M = {}

M.getPath = function(type, id)
    local ids = {'Face', 'Eyes', 'Ears', 'Mouth', 'Accessories'}
    if not id then id = LOCAL.dog[ids[type]:lower()] end
    return 'Sprites/' .. ids[type] .. '/cdog' .. ids[type] .. id .. '.png'
end

M.getDog = function(x, y, width, height)
    local dog, a = display.newGroup()

    a = display.newImage(dog, M.getPath(1), x, y)
    pcall(function() a.width, a.height = width, height end)
    a = display.newImage(dog, M.getPath(2), x, y)
    pcall(function() a.width, a.height = width, height end)
    a = display.newImage(dog, M.getPath(3), x, y)
    pcall(function() a.width, a.height = width, height end)
    a = display.newImage(dog, M.getPath(4), x, y)
    pcall(function() a.width, a.height = width, height end)
    a = display.newImage(dog, M.getPath(5), x, y)
    pcall(function() a.width, a.height = width, height end)

    return dog
end

M.create = function()
    M.group = display.newGroup()
    M.group.isVisible = false
    M.group.isOpen = false

    local bg = display.newImage('Sprites/bg.png', CENTER_X, CENTER_Y)
        bg.width = CENTER_X == 641 and DISPLAY_HEIGHT or DISPLAY_WIDTH
        bg.height = CENTER_X == 641 and DISPLAY_WIDTH or DISPLAY_HEIGHT
        bg.rotation = CENTER_X == 641 and 90 or 0
    M.group:insert(bg)

    local title = display.newText(STR['menu.dogs'], ZERO_X + 40, ZERO_Y + 30, 'ubuntu', 50)
        title.anchorX = 0
        title.anchorY = 0
    M.group:insert(title)

    M.dog = {LOCAL.dog.face, LOCAL.dog.eyes, LOCAL.dog.ears, LOCAL.dog.mouth, LOCAL.dog.accessories}
    M.face = display.newImage(M.getPath(1), CENTER_X - 18, title.y + 300)
    M.eyes = display.newImage(M.getPath(2), CENTER_X - 18, title.y + 300)
    M.ears = display.newImage(M.getPath(3), CENTER_X - 18, title.y + 300)
    M.mouth = display.newImage(M.getPath(4), CENTER_X - 18, title.y + 300)
    M.accessories = display.newImage(M.getPath(5), CENTER_X - 18, title.y + 300)

    if M.face then M.group:insert(M.face) end
    if M.eyes then M.group:insert(M.eyes) end
    if M.ears then M.group:insert(M.ears) end
    if M.mouth then M.group:insert(M.mouth) end
    if M.accessories then M.group:insert(M.accessories) end

    M.frames = {}
    local x_frame = DISPLAY_WIDTH / 6
    local y_frame = M.face.y + M.face.height / 2 + 50

    for i = 1, 5 do
        M.frames[i] = display.newImage('Sprites/ccdogBg.png', x_frame, y_frame)
            M.frames[i].width = 100
            M.frames[i].height = 100
        M.group:insert(M.frames[i])

        M.frames[i].content = display.newImage(M.getPath(i), x_frame - 3, y_frame - 3)
            if M.frames[i].content then M.frames[i].content.width = 100 end
            if M.frames[i].content then M.frames[i].content.height = 100 end
        if M.frames[i].content then M.group:insert(M.frames[i].content) end

        x_frame = x_frame + DISPLAY_WIDTH / 6
        M.frames[i]:addEventListener('touch', function(e) e.i = i LISTENER(e, 'frame') end)

        M['frames' .. i] = {}
        local _x_frame = DISPLAY_WIDTH / 7
        local _y_frame = MAX_Y + DISPLAY_HEIGHT / 2

        for j = 1, (i == 1 and 25 or i == 2 and 38 or i == 3 and 35 or i == 4 and 35 or 11) do
            M['frames' .. i][j] = display.newImage('Sprites/ccdogBg.png', _x_frame, _y_frame)
                M['frames' .. i][j].width = 100
                M['frames' .. i][j].height = 100
            M.group:insert(M['frames' .. i][j])

            M['frames' .. i][j].content = display.newImage(M.getPath(i, j), _x_frame - 3, _y_frame - 3)
                if M['frames' .. i][j].content then M['frames' .. i][j].content.width = 100 end
                if M['frames' .. i][j].content then M['frames' .. i][j].content.height = 100 end
            if M['frames' .. i][j].content then M.group:insert(M['frames' .. i][j].content) end

            _x_frame = j % 6 == 0 and DISPLAY_WIDTH / 7 or _x_frame + DISPLAY_WIDTH / 7
            _y_frame = j % 6 == 0 and _y_frame + DISPLAY_WIDTH / 7 or _y_frame
            M['frames' .. i][j]:addEventListener('touch', function(e) e.j, e.i = j, i LISTENER(e, 'frames') end)
        end
    end

    title:addEventListener('touch', function(e) LISTENER(e, 'title') end)
    M.face:addEventListener('touch', function(e) LISTENER(e, 'face') end)
end

return M
