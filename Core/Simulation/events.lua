local CALC = require 'Core.Simulation.calc'
local INFO = require 'Data.info'
local M = {BLOCKS = {}}

for i = 3, 14 do
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

M['onTouchDisplayBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e)'
    GAME.lua = GAME.lua .. ' if e.phase == \'began\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = e.x, y = e.y, xStart = e.xStart, yStart = e.yStart,'
    GAME.lua = GAME.lua .. ' id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onTouchDisplayEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e) if e.phase == \'ended\''
    GAME.lua = GAME.lua .. ' or e.phase == \'cancelled\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = e.x, y = e.y, xStart = e.xStart, yStart = e.yStart,'
    GAME.lua = GAME.lua .. ' id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onTouchDisplayMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e)'
    GAME.lua = GAME.lua .. ' if e.phase == \'moved\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = e.x, y = e.y, xStart = e.xStart, yStart = e.yStart,'
    GAME.lua = GAME.lua .. ' id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onSliderMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(value)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = value'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onWebViewCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = n, type = p.type, url = p.url, errorCode = p.errorCode, errorMessage = p.errorMessage}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onFieldBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true) .. ' = {name = n}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onFieldEditing'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'editing\' then local'
    GAME.lua = GAME.lua .. ' varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true) .. ' = {numDeleted = p.numDeleted,'
    GAME.lua = GAME.lua .. ' startPosition = p.startPosition, name = n, text = p.text, oldText = p.oldText, newCharacters = p.newCharacters}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onFieldEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'ended\''
    GAME.lua = GAME.lua .. ' or p.phase == \'submitted\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = n, text = GAME.group.widgets[n].text}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

return M
