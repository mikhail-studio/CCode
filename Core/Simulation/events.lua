local CALC = require 'Core.Simulation.calc'
local INFO = require 'Data.info'
local M = {BLOCKS = {}}

for i = 3, #INFO.listType - 3 do
    M.BLOCKS = table.merge(M.BLOCKS, require('Core.Simulation.' .. INFO.listType[i]))
end

M.requestNestedBlock = function(nested)
    for i = 1, #nested do
        local name = nested[i].name
        local params = nested[i].params
        pcall(function() M.BLOCKS[name](params) end)
    end
end

M['onStart'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() local function event() local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end event() end)'
end

M['onFun'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function() local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onFunParams'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(...)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE_P({...})'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onTouchBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = p.target.name, x = p.x, y = p.y, xStart = p.xStart, yStart = p.yStart,'
    GAME.lua = GAME.lua .. ' id = p.id, xDelta = p.xDelta, yDelta = p.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'ended\''
    GAME.lua = GAME.lua .. ' or p.phase == \'cancelled\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p) '
    GAME.lua = GAME.lua .. CALC(params[2], 'a', true) .. ' = {name = p.target.name, x = p.x, y = p.y,'
    GAME.lua = GAME.lua .. ' xStart = p.xStart, yStart = p.yStart, id = p.id, xDelta = p.xDelta, yDelta = p.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'moved\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = p.target.name, x = p.x, y = p.y, xStart = p.xStart, yStart = p.yStart,'
    GAME.lua = GAME.lua .. ' id = p.id, xDelta = p.xDelta, yDelta = p.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onSliderMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(value)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = value'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onWebViewCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, name)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = name, type = p.type, url = p.url, errorCode = p.errorCode, errorMessage = p.errorMessage}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

return M
