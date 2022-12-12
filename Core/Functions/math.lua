local M = {}

local sin = math.sin
local cos = math.cos
local tan = math.tan
local asin = math.asin
local acos = math.acos
local atan = math.atan
local atan2 = math.atan2

M.getMaskBits = math.getMaskBits
M.randomseed = math.randomseed
M.factorial = math.factorial
M.random = math.random
M.getBit = math.getBit
M.radical = math.sqrt
M.log10 = math.log10
M.round = math.round
M.module = math.abs
M.power = math.pow
M.log0 = math.log
M.hex = math.hex
M.exp = math.exp
M.sum = math.sum
M.max = math.max
M.min = math.min
M.pi = math.pi

M['remainder'] = function(num, count)
    local isComplete, result = pcall(function()
        return num % count
    end) return isComplete and result or 0
end

M['asin'] = function(num)
    local isComplete, result = pcall(function()
        return asin(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['acos'] = function(num)
    local isComplete, result = pcall(function()
        return acos(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['atan'] = function(num)
    local isComplete, result = pcall(function()
        return atan(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['atan2'] = function(x, y)
    local isComplete, result = pcall(function()
        return atan2(x * M.pi / 180, y * M.pi / 180)
    end) return isComplete and result or 0
end

M['sin'] = function(num)
    local isComplete, result = pcall(function()
        return sin(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['cos'] = function(num)
    local isComplete, result = pcall(function()
        return cos(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['tan'] = function(num)
    local isComplete, result = pcall(function()
        return tan(num * M.pi / 180)
    end) return isComplete and result or 0
end

M['ctan'] = function(num)
    local isComplete, result = pcall(function()
        return 1 / tan(num * M.pi / 180)
    end) return isComplete and result or 0
end

return M
