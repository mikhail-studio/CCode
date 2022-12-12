local M = {}

M['get_text'] = function(name)
    local result = pcall(function()
        return GAME.group.texts[name or '0'] and GAME.group.texts[name or '0'].text or 'nil'
    end) return result or 'nil'
end

M['read_save'] = function(key)
    local result = pcall(function()
        return GET_GAME_SAVE(CURRENT_LINK)[tostring(key)]
    end) return result or 'nil'
end

M['random_str'] = function(...)
    local result = pcall(function()
        local args = {...}

        if #args > 0 then
            return args[math.random(1, #args)]
        else
            return 'nil'
        end
    end) return result or 'nil'
end

M['concat'] = function(...)
    local result = pcall(function()
        local args, str = {...}, ''

        for i = 1, #args do
            str = str .. args[i]
        end

        return str
    end) return result or 'nil'
end

M['tonumber'] = function(str)
    local result = pcall(function()
        return tonumber(str) or 0
    end) return result or 0
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
    local result = pcall(function()
        return JSON[prettify and 'prettify' or 'encode'](t)
    end) return result or '{}'
end

M['gsub'] = function(str, pattern, replace, n)
    local result = pcall(function()
        return UTF8.gsub(str, pattern, replace, n)
    end) return result or (str or 'nil')
end

M['sub'] = function(str, i, j)
    local result = pcall(function()
        return UTF8.sub(str, i, j)
    end) return result or (str or 'nil')
end

M['len'] = function(str)
    local result = pcall(function()
        return UTF8.len(str)
    end) return result or 0
end

M['find'] = function(str, pattern, i, plain)
    local result = pcall(function()
        return UTF8.find(str, pattern, i, plain)
    end) return result or (str or 'nil')
end

M['match'] = function(str, pattern, i)
    local result = pcall(function()
        return UTF8.match(str, pattern, i)
    end) return result or (str or 'nil')
end

M['get_ip'] = function(any)
    local result = pcall(function()
        return SERVER.getIP()
    end) return result or 'nil'
end

M['color_pixel'] = function(x, y)
    local result = pcall(function()
        local x = x or 0
        local y = y or 0
        local colors = {0, 0, 0, 0}

        if coroutine.status(GAME.CO) ~= 'running' then
            display.colorSample(CENTER_X + x, CENTER_Y - y, function(e)
                colors = {math.round(e.r * 255), math.round(e.g * 255), math.round(e.b * 255), math.round(e.a * 255)}
            end)
        end

        return colors
    end) return result or {0, 0, 0, 0}
end

M['unix_time'] = function()
    return os.time()
end

return M
