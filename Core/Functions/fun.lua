local M = {}

M['get_text'] = function(name)
    return GAME.group.texts[name or '0'] and GAME.group.texts[name or '0'].text or 'nil'
end

M['read_save'] = function(key)
    return GET_GAME_SAVE(CURRENT_LINK)[tostring(key)]
end

M['random_str'] = function(...)
    local args = {...}

    if #args > 0 then
        return args[math.random(1, #args)]
    else
        return 'nil'
    end
end

M['tonumber'] = function(str)
    return tonumber(str) or 0
end

M['tostring'] = function(any)
    return tostring(any)
end

M['encode'] = function(t, prettify)
    return JSON[prettify and 'prettify' or 'encode'](t)
end

M['gsub'] = function(str, pattern, replace, n)
    return UTF8.gsub(str, pattern, replace, n)
end

M['sub'] = function(str, i, j)
    return UTF8.sub(str, i, j)
end

M['len'] = function(str)
    return UTF8.len(str)
end

M['find'] = function(str, pattern, i, plain)
    return UTF8.find(str, pattern, i, plain)
end

M['match'] = function(str, pattern, i)
    return UTF8.match(str, pattern, i)
end

M['color_pixel'] = function(x, y)
    local colors = {0, 0, 0}

    display.colorSample(CENTER_X + x, CENTER_Y - y, function(e)
        colors = {math.round(e.r * 255), math.round(e.g * 255), math.round(e.b * 255)}
    end)

    return colors
end

M['unix_time'] = function()
    return os.time()
end

return M
