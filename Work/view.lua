local map = {}

local _colors = {'A', 'B', 'C', 'D', 'E', 'F'}

local random = math.random

--[[
    libjli.so
    libz.so.1
]]

function init()
    for y = 0, 9 do
        map[y] = {}

        for x = 0, 9 do
            local colors = table.copy(_colors)

            if y > 0 then
                table.remove(colors, table.indexOf(colors, map[y - 1][x]))
            end

            if x > 0 then
                table.remove(colors, table.indexOf(colors, map[y][x - 1]))
            end

            map[y][x] = colors[random(1, #colors)]
        end
    end
end

function tick()
    dump()
end

function dump()
    local s = '  0123456789\n  ----------\n'

    for y = 0, 9 do
        s = s .. y .. '|'
        for  x = 0, 9 do
            s = s .. map[y][x]
        end
        s = s .. '\n'
    end

    print(s)
end

init()
dump()
