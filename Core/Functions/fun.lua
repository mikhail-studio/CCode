local M = {}

M['get_text'] = function(name)
    local isComplete, result = pcall(function()
        return GAME.group.texts[name or '0'] and GAME.group.texts[name or '0'].text or ''
    end) return isComplete and result or ''
end

M['read_save'] = function(key)
    local isComplete, result = pcall(function()
        return GET_GAME_SAVE(CURRENT_LINK)[tostring(key)]
    end) return isComplete and result or nil
end

M['random_str'] = function(...)
    local args = {...}

    local isComplete, result = pcall(function()
        if #args > 0 then
            return args[math.random(1, #args)]
        else
            return nil
        end
    end) return isComplete and result or ''
end

M['concat'] = function(...)
    local args, str = {...}, ''

    local isComplete, result = pcall(function()
        for i = 1, #args do
            str = str .. args[i]
        end

        return str
    end) return isComplete and result or ''
end

M['tonumber'] = function(str)
    local isComplete, result = pcall(function()
        return tonumber(str) or 0
    end) return isComplete and result or 0
end

M['tostring'] = function(any)
    return tostring(any)
end

M['totable'] = function(str)
    return JSON.decode(str)
end

M['len_table'] = function(t)
    return table.len(t)
end

M['encode'] = function(t, prettify)
    local isComplete, result = pcall(function()
        return JSON[prettify and 'prettify' or 'encode'](t)
    end) return isComplete and result or '{}'
end

M['gsub'] = function(str, pattern, replace, n)
    local isComplete, result = pcall(function()
        return UTF8.gsub(str, pattern, replace, n)
    end) return isComplete and result or str
end

M['sub'] = function(str, i, j)
    local isComplete, result = pcall(function()
        return UTF8.sub(str, i, j)
    end) return isComplete and result or str
end

M['len'] = function(str)
    local isComplete, result = pcall(function()
        return UTF8.len(str)
    end) return isComplete and result or 0
end

M['find'] = function(str, pattern, i, plain)
    local isComplete, result = pcall(function()
        return UTF8.find(str, pattern, i, plain)
    end) return isComplete and result or str
end

M['split'] = function(str, sep)
    local isComplete, result = pcall(function()
        return UTF8.split(str, sep)
    end) return isComplete and result or {}
end

M['match'] = function(str, pattern, i)
    local isComplete, result = pcall(function()
        return UTF8.match(str, pattern, i)
    end) return isComplete and result or str
end

M['get_ip'] = function(any)
    local isComplete, result = pcall(function()
        return SERVER.getIP()
    end) return isComplete and result or nil
end

M['color_pixel'] = function(x, y)
    local isComplete, result = pcall(function()
        local x = x or 0
        local y = y or 0
        local colors = {0, 0, 0, 0}

        if coroutine.status(GAME.CO) ~= 'running' then
            display.colorSample(CENTER_X + x, CENTER_Y - y, function(e)
                colors = {math.round(e.r * 255), math.round(e.g * 255), math.round(e.b * 255), math.round(e.a * 255)}
            end)
        end

        return colors
    end) return isComplete and result or {0, 0, 0, 0}
end

M['unix_time'] = function()
    return os.time()
end

return M
