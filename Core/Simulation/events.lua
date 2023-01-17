local CALC = require 'Core.Simulation.calc'
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
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE_P({...}, true)'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onCondition'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.conditions, function()'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} if ' .. CALC(params[1]) .. ' then'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onTouchBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = p.target.name, x = GET_X(p.x), y = GET_Y(p.y), xStart = GET_X(p.xStart), yStart = GET_Y(p.yStart),'
    GAME.lua = GAME.lua .. ' id = p.id, xDelta = GET_X(p.xDelta), yDelta = GET_Y(p.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'ended\' or p.phase =='
    GAME.lua = GAME.lua .. ' \'cancelled\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = p.target.name, x = GET_X(p.x), y = GET_Y(p.y), xStart = GET_X(p.xStart),'
    GAME.lua = GAME.lua .. ' yStart = GET_Y(p.yStart), id = p.id, xDelta = GET_X(p.xDelta), yDelta = GET_Y(p.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'moved\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = p.target.name, x = GET_X(p.x), y = GET_Y(p.y), xStart = GET_X(p.xStart), yStart = GET_Y(p.yStart),'
    GAME.lua = GAME.lua .. ' id = p.id, xDelta = GET_X(p.xDelta), yDelta = GET_Y(p.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onTouchDisplayBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e)'
    GAME.lua = GAME.lua .. ' if e.phase == \'began\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. ' yStart = GET_Y(e.yStart), id = e.id, xDelta = GET_X(e.xDelta), yDelta = GET_Y(e.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onTouchDisplayEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e) if e.phase == \'ended\''
    GAME.lua = GAME.lua .. ' or e.phase == \'cancelled\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. ' yStart = GET_Y(e.yStart), id = e.id, xDelta = GET_X(e.xDelta), yDelta = GET_Y(e.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onTouchDisplayMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.displays, function(e)'
    GAME.lua = GAME.lua .. ' if e.phase == \'moved\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. ' yStart = GET_Y(e.yStart), id = e.id, xDelta = GET_X(e.xDelta), yDelta = GET_Y(e.yDelta)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end) end)'
end

M['onFirebase'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(response)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = response'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onSliderMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(value)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = value'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onSwitchCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = e.target.isOn'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onWebViewCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n)'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {name = n, type = p.type, url = p.url, errorCode = p.errorCode, errorMessage = p.errorMessage}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end)'
end

M['onFieldBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true) .. ' = {name = n}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onFieldEditing'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'editing\' then local'
    GAME.lua = GAME.lua .. ' varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {numDeleted = p.numDeleted, startPosition = p.startPosition, name = n,'
    GAME.lua = GAME.lua .. ' text = p.text, oldText = p.oldText, newCharacters = p.newCharacters}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onFieldEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if p.phase == \'ended\''
    GAME.lua = GAME.lua .. ' or p.phase == \'submitted\' then local varsE, tablesE, p = {}, {},'
    GAME.lua = GAME.lua .. ' COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true) .. ' = {name = n, text = GAME.group.widgets[n].text}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onBackPress'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() GAME.needBack = false table.insert(GAME.group.backs, function()'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end) end)'
end

M['onSuspend'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.suspends, function()'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end) end)'
end

M['onResume'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.resumes, function()'
    GAME.lua = GAME.lua .. ' local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end) end)'
end

M['onLocalCollisionBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. ' = p.contact.tangentSpeed}, name = p.target.name, other = p.other.name, x = GET_X(p.x), y = GET_Y(p.y)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onLocalCollisionEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'ended\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. ' = p.contact.tangentSpeed}, name = p.target.name, other = p.other.name, x = 0, y = 0}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onLocalPreCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'pre\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction},'
    GAME.lua = GAME.lua .. ' name = p.target.name, other = p.other.name, x = GET_X(p.x), y = GET_Y(p.y)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onLocalPostCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'post\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction}, name'
    GAME.lua = GAME.lua .. ' = p.target.name, other = p.other.name, x = GET_X(p.x), y = GET_Y(p.y), force = p.force, friction = p.friction}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onGlobalCollisionBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. ' = p.contact.tangentSpeed}, name1 = p.object1.name, name2 = p.object2.name, x = GET_X(p.x), y = GET_Y(p.y)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onGlobalCollisionEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'ended\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. ' = p.contact.tangentSpeed}, name1 = p.object1.name, name2 = p.object2.name, x = 0, y = 0}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onGlobalPreCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'pre\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction},'
    GAME.lua = GAME.lua .. ' name1 = p.object1.name, name2 = p.object2.name, x = GET_X(p.x), y = GET_Y(p.y)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

M['onGlobalPostCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. ' pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if p.phase == \'post\' then'
    GAME.lua = GAME.lua .. ' local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. ' = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. ' {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction}, name1'
    GAME.lua = GAME.lua .. ' = p.object1.name, name2 = p.object2.name, x = GET_X(p.x), y = GET_Y(p.y), force = p.force, friction = p.friction}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. ' end end end)'
end

return M
