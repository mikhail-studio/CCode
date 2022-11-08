local INFO = require 'Data.info'
local M = {}

M.CONTROL = require 'Core.Simulation.control'
M.VARS = require 'Core.Simulation.vars'
M.OBJECTS = require 'Core.Simulation.objects'
M.OBJECTS2 = require 'Core.Simulation.objects2'
M.SHAPES = require 'Core.Simulation.shapes'
M.GROUPS = require 'Core.Simulation.groups'
M.PHYSICS = require 'Core.Simulation.physics'
M.PHYSICS2 = require 'Core.Simulation.physics2'
M.WIDGETS = require 'Core.Simulation.widgets'
M.WIDGETS2 = require 'Core.Simulation.widgets2'

M.requestNestedBlock = function(nested, params)
    for i = 1, #nested do
        local name = nested[i].name
        local params = nested[i].params
        local type = UTF8.upper(INFO.getType(name))
        pcall(function() M[type][name](params) end)
    end
end

M['onStart'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() local function event() local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end event() end)'
end

M['onFun'] = function(nested, params)
    local name = params[1][1][1]
    local type = params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. type .. '[\'' .. name .. '\'] = function() local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end end)'
end

M['onFunParams'] = function(nested, params)
    local nameFun = params[1][1] and params[1][1][1] or '_ccode'
    local nameTable = params[2][1] and params[2][1][1] or '_ccode'
    local typeFun = params[1][1] and params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'] = function(...) local varsE, tablesE = {},'
    GAME.lua = GAME.lua .. ' {[\'' .. nameTable .. '\'] = COPY_TABLE_FP({...})}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end end)'
end

M['onTouchBegan'] = function(nested, params)
    local nameFun = params[1][1] and params[1][1][1] or '_ccode'
    local nameTable = params[2][1] and params[2][1][1] or '_ccode'
    local typeFun = (params[1][1] and params[1][1][2] == 'fS') and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'] = function(p) if p.phase == \'began\' then local varsE, tablesE, p = {},'
    GAME.lua = GAME.lua .. ' {}, COPY_TABLE(p) tablesE[\'' .. nameTable .. '\'] = {name = p.target.name, x = p.x, y = p.y, xStart = p.xStart, yStart = p.yStart}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchEnded'] = function(nested, params)
    local nameFun = params[1][1] and params[1][1][1] or '_ccode'
    local nameTable = params[2][1] and params[2][1][1] or '_ccode'
    local typeFun = params[1][1] and params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'] = function(p) if p.phase == \'ended\' then local varsE, tablesE, p = {},'
    GAME.lua = GAME.lua .. ' {}, COPY_TABLE(p) tablesE[\'' .. nameTable .. '\'] = {name = p.target.name, x = p.x, y = p.y, xStart = p.xStart, yStart = p.yStart}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchMoved'] = function(nested, params)
    local nameFun = params[1][1] and params[1][1][1] or '_ccode'
    local nameTable = params[2][1] and params[2][1][1] or '_ccode'
    local typeFun = params[1][1] and params[1][1][2] == 'fS' and 'funsS' or 'funsP'

    GAME.lua = GAME.lua .. ' pcall(function() ' .. typeFun .. '[\'' .. nameFun .. '\'] = function(p) if p.phase == \'moved\' then local varsE, tablesE, p = {},'
    GAME.lua = GAME.lua .. ' {}, COPY_TABLE(p) tablesE[\'' .. nameTable .. '\'] = {name = p.target.name, x = p.x, y = p.y, xStart = p.xStart, yStart = p.yStart}'
    M.requestNestedBlock(nested, params) GAME.lua = GAME.lua .. ' end end end)'
end

return M
