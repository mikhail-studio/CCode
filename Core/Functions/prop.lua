local M = {}

M['touch'] = function(name)
    return GAME.group.objects[name]._touch
end

M['tag'] = function(name)
    return GAME.group.objects[name]._tag
end

M['pos_x'] = function(name)
    return select(1, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['pos_y'] = function(name)
    return 0 - select(2, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['width'] = function(name)
    return GAME.group.objects[name].width
end

M['height'] = function(name)
    return GAME.group.objects[name].height
end

M['rotation'] = function(name)
    return GAME.group.objects[name].rotation
end

M['alpha'] = function(name)
    return GAME.group.objects[name].alpha * 100
end

M['name_texture'] = function(name)
    return GAME.group.objects[name]._name
end

M['velocity_x'] = function(name)
    return GAME.group.objects[name]._body ~= '' and select(1, GAME.group.objects[name]:getLinearVelocity()) or 0
end

M['velocity_y'] = function(name)
    return GAME.group.objects[name]._body ~= '' and 0 - select(2, GAME.group.objects[name]:getLinearVelocity()) or 0
end

M['angular_velocity'] = function(name)
    return GAME.group.objects[name]._body ~= '' and GAME.group.objects[name].angularVelocity or 0
end

return M
