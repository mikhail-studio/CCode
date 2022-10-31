local M = {}

local sin = math.sin
local cos = math.cos
local tan = math.tan
local asin = math.asin
local acos = math.acos
local atan = math.atan
local atan2 = math.atan2

M.factorial = math.factorial
M.random = math.random
M.radical = math.sqrt
M.log10 = math.log10
M.module = math.abs
M.power = math.pow
M.log = math.log
M.max = math.max
M.min = math.min
M.pi = math.pi

M['round'] = function(num, count)
    return tonumber(string.format('%.' .. (count or '0') .. 'f', tostring(num))) or num
end

M['remainder'] = function(num, count)
    return num % count
end

M['asin'] = function(num)
    return asin(num * M.pi / 180)
end

M['acos'] = function(num)
    return acos(num * M.pi / 180)
end

M['atan'] = function(num)
    return atan(num * M.pi / 180)
end

M['atan2'] = function(num)
    return atan2(num * M.pi / 180)
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
