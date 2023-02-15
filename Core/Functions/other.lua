local M = {}

M.getBitmapTexture = function(link, name)
    local data, width, height = IMPACK.image.load(link, system.DocumentsDirectory, {req_comp = 3})
    local x, y, size = 1, 1, width * height

    GAME.group.bitmaps[name] = BITMAP.newTexture({width = width, height = height})

    for i = 1, size do
        local args = {data:byte(i * 3 - 2, i * 3)}
        GAME.group.bitmaps[name]:setPixel(x, y, args[1] / 255, args[2] / 255, args[3] / 255, 1)
        x = x == width and 1 or x + 1
        y = x == 1 and y + 1 or y
    end

    GAME.group.bitmaps[name]:invalidate()
end

M.getPhysicsParams = function(friction, bounce, density, hitbox, filter)
    local params = {friction = friction, bounce = bounce, density = density}

    if filter and filter[1] and filter[2] then
        params.filter = {
            categoryBits = math.getBit(filter[1]),
            maskBits = math.getMaskBits(filter[2])
        }
    end

    if hitbox.type == 'box' then
        params.box = {
            halfWidth = hitbox.halfWidth, halfHeight = hitbox.halfHeight,
            x = hitbox.offsetX, y = hitbox.offsetY, angle = hitbox.rotation
        }
    elseif hitbox.type == 'circle' then
        params.radius = hitbox.radius
    elseif hitbox.type == 'mesh' then
        params.outline = hitbox.outline
    elseif hitbox.type == 'polygon' then
        if type(hitbox.shape) == 'table' then
            for i = 1, #hitbox.shape do
                if i % 2 == 0 then
                    hitbox.shape[i] = -hitbox.shape[i]
                end
            end
        end

        params.shape = hitbox.shape
    end

    return params
end

M.getResource = function(link)
    for i = 1, #GAME.RESOURCES.others do
        if GAME.RESOURCES.others[i][1] == link then
            return CURRENT_LINK .. '/Resources/' .. GAME.RESOURCES.others[i][2]
        end
    end
end

M.getSound = function(link)
    for i = 1, #GAME.RESOURCES.sounds do
        if GAME.RESOURCES.sounds[i][1] == link then
            return CURRENT_LINK .. '/Sounds/' .. GAME.RESOURCES.sounds[i][2]
        end
    end
end

M.getVideo = function(link)
    for i = 1, #GAME.RESOURCES.videos do
        if GAME.RESOURCES.videos[i][1] == link then
            return CURRENT_LINK .. '/Videos/' .. GAME.RESOURCES.videos[i][2]
        end
    end
end

M.getImage = function(link)
    for i = 1, #GAME.RESOURCES.images do
        if GAME.RESOURCES.images[i][1] == link then
            return CURRENT_LINK .. '/Images/' .. GAME.RESOURCES.images[i][3], GAME.RESOURCES.images[i][2] or 'nearest'
        end
    end
end

M.getFont = function(font)
    for i = 1, #GAME.RESOURCES.fonts do
        if GAME.RESOURCES.fonts[i][1] == font then
            if CURRENT_LINK ~= 'App' then
                local new_font = io.open(DOC_DIR .. '/' .. CURRENT_LINK .. '/Fonts/' .. GAME.RESOURCES.fonts[i][2], 'rb')
                local main_font = io.open(RES_PATH .. '/' .. GAME.RESOURCES.fonts[i][2], 'wb')

                if new_font and main_font then
                    main_font:write(new_font:read('*a'))
                    io.close(main_font)
                    io.close(new_font)
                end
            end

            return GAME.RESOURCES.fonts[i][2]
        end
    end

    return font
end

return M
