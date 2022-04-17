local M = {}

local sin = math.sin
local cos = math.cos
local tan = math.tan

M.random = math.random
M.radical = math.sqrt
M.module = math.abs
M.power = math.pow
M.max = math.max
M.min = math.min
M.pi = math.pi

M['round'] = function(num, count)
    return tonumber(string.format('%.' .. (count or '0') .. 'f', tostring(num))) or num
end

M['remainder'] = function(num, count)
    return num % count
end

M['sin'] = function(num)
    return sin(num * M.pi / 180)
end

M['cos'] = function(num)
    return cos(num * M.pi / 180)
end

M['tan'] = function(num)
    return tan(num * M.pi / 180)
end

M['ctan'] = function(num)
    return 1 / tan(num * M.pi / 180)
end

return M
