local M = {}

M.getPhysicsParams = function(friction, bounce, density, hitbox)
    local params = {friction = friction, bounce = bounce, density = density}

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
        params.shape = hitbox.shape
    end

    return params
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
