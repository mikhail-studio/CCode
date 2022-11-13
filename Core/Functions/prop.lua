local M = {}

M['obj.touch'] = function(name)
    return GAME.group.objects[name]._touch
end

M['obj.tag'] = function(name)
    return GAME.group.objects[name]._tag
end

M['obj.pos_x'] = function(name)
    return select(1, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['obj.pos_y'] = function(name)
    return 0 - select(2, GAME.group.objects[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['obj.width'] = function(name)
    return GAME.group.objects[name]._radius and GAME.group.objects[name].radius or GAME.group.objects[name].width
end

M['obj.height'] = function(name)
    return GAME.group.objects[name]._radius and GAME.group.objects[name].radius or GAME.group.objects[name].height
end

M['obj.rotation'] = function(name)
    return GAME.group.objects[name].rotation
end

M['obj.alpha'] = function(name)
    return GAME.group.objects[name].alpha * 100
end

M['obj.name_texture'] = function(name)
    return GAME.group.objects[name]._name
end

M['obj.velocity_x'] = function(name)
    return GAME.group.objects[name]._body ~= '' and select(1, GAME.group.objects[name]:getLinearVelocity()) or 0
end

M['obj.velocity_y'] = function(name)
    return GAME.group.objects[name]._body ~= '' and 0 - select(2, GAME.group.objects[name]:getLinearVelocity()) or 0
end

M['obj.angular_velocity'] = function(name)
    return GAME.group.objects[name]._body ~= '' and GAME.group.objects[name].angularVelocity or 0
end

M['text.pos_x'] = function(name)
    return select(1, GAME.group.texts[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['text.pos_y'] = function(name)
    return 0 - select(2, GAME.group.texts[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['group.pos_x'] = function(name)
    return select(1, GAME.group.groups[name]:localToContent(-CENTER_X, -CENTER_Y))
end

M['group.pos_y'] = function(name)
    return 0 - select(2, GAME.group.groups[name]:localToContent(-CENTER_X, -CENTER_Y))
end

return M
