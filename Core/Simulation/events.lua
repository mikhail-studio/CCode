local CALC = require 'Core.Simulation.calc'
local M, LIST_TYPES  = {BLOCKS = {}}, {'filters'}

for i = 3, 14 do
    M.BLOCKS = table.merge(M.BLOCKS, require('Core.Simulation.' .. INFO.listType[i]))
end

for i = 1, #LIST_TYPES do
    M.BLOCKS = table.merge(M.BLOCKS, require('Core.Simulation.' .. LIST_TYPES[i]))
end

M.requestNestedBlock = function(nested)
    for i = 1, #nested do
        local name = nested[i].name
        local params = nested[i].params
        pcall(function() M.BLOCKS[name](params) end)
    end
end

M['onStart'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() local function event() local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end event() end)'
end

M['onFun'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function()'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onFunParams'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(...) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE_P({...}, true)'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onCondition'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_conditions, function() if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} if ' .. CALC(params[1]) .. ' then'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end) end)'
end

M['onUpdateVar'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true, nil, true) .. ' = function(_, oldValue)'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = oldValue'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onTouchBegan2'] = function(nested, params)
    local guid = GUID() M['onTouchBegan'](nested, {{{guid, 'fP'}}, params[2]})
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function()'
    M.BLOCKS['setListener']({params[1], {{guid, 'fP'}}}) GAME.lua = GAME.lua .. '\n end)'
end

M['onTouchBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if e.phase == \'began\' then if GAME.hash'
    GAME.lua = GAME.lua .. '\n == hash then local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE(e, true)'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onTouchEnded2'] = function(nested, params)
    local guid = GUID() M['onTouchEnded'](nested, {{{guid, 'fP'}}, params[2]})
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function()'
    M.BLOCKS['setListener']({params[1], {{guid, 'fP'}}}) GAME.lua = GAME.lua .. '\n end)'
end

M['onTouchEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n if (e.phase == \'ended\' or e.phase == \'cancelled\') and e._ccode_event.isTouch then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE(e, true)'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onTouchMoved2'] = function(nested, params)
    local guid = GUID() M['onTouchMoved'](nested, {{{guid, 'fP'}}, params[2]})
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function()'
    M.BLOCKS['setListener']({params[1], {{guid, 'fP'}}}) GAME.lua = GAME.lua .. '\n end)'
end

M['onTouchMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n if e.phase == \'moved\' and e._ccode_event.isTouch then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = COPY_TABLE(e, true)'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onTouchDisplayBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_displays, function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n if e.phase == \'began\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. '\n = {_ccode_event = e, name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. '\n yStart = GET_Y(e.yStart), id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end) end)'
end

M['onTouchDisplayEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_displays, function(e) if GAME.hash == hash then if e.phase =='
    GAME.lua = GAME.lua .. '\n \'ended\' or e.phase == \'cancelled\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. '\n = {_ccode_event = e, name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. '\n yStart = GET_Y(e.yStart), id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end) end)'
end

M['onTouchDisplayMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_displays, function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n if e.phase == \'moved\' then local varsE, tablesE = {}, {} ' .. CALC(params[1], 'a', true)
    GAME.lua = GAME.lua .. '\n = {_ccode_event = e, name = \'_ccode_display\', x = GET_X(e.x), y = GET_Y(e.y), xStart = GET_X(e.xStart),'
    GAME.lua = GAME.lua .. '\n yStart = GET_Y(e.yStart), id = e.id, xDelta = e.xDelta, yDelta = e.yDelta}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end) end)'
end

M['onFirebase'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(response) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = response'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onFileDownload'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n if e.phase == \'ended\' then local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = e'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onSliderMoved'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(value) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = value'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onBluetoothGet'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = e.result'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onSwitchCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(e) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE = {}, {} ' .. CALC(params[2], 'a', true) .. ' = e.target.isOn'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onWebViewCallback'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if GAME.hash == hash then'
    GAME.lua = GAME.lua .. '\n local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {name = n, type = p.type, url = p.url, errorCode = p.errorCode, errorMessage = p.errorMessage}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end)'
end

M['onFieldBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n)'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then if p.phase == \'began\' then local varsE, tablesE,'
    GAME.lua = GAME.lua .. '\n p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true) .. ' = {name = n}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onFieldEditing'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'editing\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {numDeleted = p.numDeleted, startPosition = p.startPosition, name = n,'
    GAME.lua = GAME.lua .. '\n text = p.text, oldText = p.oldText, newCharacters = p.newCharacters}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onFieldEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p, n) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'ended\' or p.phase == \'submitted\' then local varsE, tablesE, p = {}, {},'
    GAME.lua = GAME.lua .. '\n COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true) .. ' = {name = n, text = GAME_widgets[n].text}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onBackPress'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() GAME.needBack = false table.insert(GAME_backs, function() pcall(function()'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end) end) end)'
end

M['onSuspend'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_suspends, function() pcall(function()'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end) end) end)'
end

M['onResume'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() table.insert(GAME_resumes, function() pcall(function()'
    GAME.lua = GAME.lua .. '\n if GAME.hash == hash then local varsE, tablesE = {}, {}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end) end) end)'
end

M['onLocalCollisionBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'began\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. '\n = p.contact.tangentSpeed}, name = p.target.name, other = p.other.name,'
    GAME.lua = GAME.lua .. '\n x = GET_X(p.x, p.target), y = GET_Y(p.y, p.target)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onLocalCollisionEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'ended\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. '\n = p.contact.tangentSpeed}, name = p.target.name, other = p.other.name, x = 0, y = 0}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onLocalPreCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'pre\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction},'
    GAME.lua = GAME.lua .. '\n name = p.target.name, other = p.other.name, x = GET_X(p.x, p.target), y = GET_Y(p.y, p.target)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onLocalPostCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'post\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, selfElement = p.selfElement, otherElement = p.otherElement, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction}, name'
    GAME.lua = GAME.lua .. '\n = p.target.name, other = p.other.name, x = GET_X(p.x, p.target),'
    GAME.lua = GAME.lua .. '\n y = GET_Y(p.y, p.target), force = p.force, friction = p.friction}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onGlobalCollisionBegan'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'began\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. '\n = p.contact.tangentSpeed}, name1 = p.object1.name, name2 = p.object2.name,'
    GAME.lua = GAME.lua .. '\n x = GET_X(p.x, p.target), y = GET_Y(p.y, p.target)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onGlobalCollisionEnded'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'ended\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction, tangentSpeed'
    GAME.lua = GAME.lua .. '\n = p.contact.tangentSpeed}, name1 = p.object1.name, name2 = p.object2.name, x = 0, y = 0}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onGlobalPreCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'pre\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction},'
    GAME.lua = GAME.lua .. '\n name1 = p.object1.name, name2 = p.object2.name,'
    GAME.lua = GAME.lua .. '\n x = GET_X(p.x, p.target), y = GET_Y(p.y, p.target)}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onGlobalPostCollision'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n pcall(function() ' .. CALC(params[1], 'a', true) .. ' = function(p) if GAME.hash == hash then if'
    GAME.lua = GAME.lua .. '\n p.phase == \'post\' then local varsE, tablesE, p = {}, {}, COPY_TABLE(p, true) ' .. CALC(params[2], 'a', true)
    GAME.lua = GAME.lua .. '\n = {contact = p.contact, element1 = p.element1, element2 = p.element2, _contact ='
    GAME.lua = GAME.lua .. '\n {isTouching = p.contact.isTouching, bounce = p.contact.bounce, friction = p.contact.friction}, name1'
    GAME.lua = GAME.lua .. '\n = p.object1.name, name2 = p.object2.name, x = GET_X(p.x, p.target),'
    GAME.lua = GAME.lua .. '\n y = GET_Y(p.y, p.target), force = p.force, friction = p.friction}'
    M.requestNestedBlock(nested) GAME.lua = GAME.lua .. '\n end end end end)'
end

M['onTouchBeganNoob'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:addEventListener(\'touch\', function(e) handlerTouch(e)'
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() if GAME.hash == hash then handlerTouch(e)'
    GAME.lua = GAME.lua .. '\n e.target._touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\' GAME.group.const.touch'
    GAME.lua = GAME.lua .. '\n = e.target._touch GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y if e.target._touch then'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, e.id) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(e.target) end else'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, nil) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(nil) for name, object in pairs(GAME_objects) do'
    GAME.lua = GAME.lua .. '\n if object._touch and object ~= e.target then GAME_objects[name]._touch = false end end end end'
    GAME.lua = GAME.lua .. '\n return (not ((function(p) if p.phase == \'began\' then' M.requestNestedBlock(nested)
    GAME.lua = GAME.lua .. '\n end end)(e) == false)) end end) if isComplete then return result end return true end) end) end)'
end

M['onTouchMovedNoob'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:addEventListener(\'touch\', function(e)'
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() if GAME.hash == hash then handlerTouch(e)'
    GAME.lua = GAME.lua .. '\n e.target._touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\' GAME.group.const.touch'
    GAME.lua = GAME.lua .. '\n = e.target._touch GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y if e.target._touch then'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, e.id) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(e.target) end else'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, nil) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(nil) for name, object in pairs(GAME_objects) do'
    GAME.lua = GAME.lua .. '\n if object._touch and object ~= e.target then GAME_objects[name]._touch = false end end end end'
    GAME.lua = GAME.lua .. '\n return (not ((function(p) if p.phase == \'moved\' then' M.requestNestedBlock(nested)
    GAME.lua = GAME.lua .. '\n end end)(e) == false)) end end) if isComplete then return result end return true end) end) end)'
end

M['onTouchEndedNoob'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() local name = ' .. CALC(params[1])
    GAME.lua = GAME.lua .. '\n GAME_objects[name]:addEventListener(\'touch\', function(e)'
    GAME.lua = GAME.lua .. '\n local isComplete, result = pcall(function() if GAME.hash == hash then handlerTouch(e)'
    GAME.lua = GAME.lua .. '\n e.target._touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\' GAME.group.const.touch'
    GAME.lua = GAME.lua .. '\n = e.target._touch GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y if e.target._touch then'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, e.id) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(e.target) end else'
    GAME.lua = GAME.lua .. '\n if GAME.multi then display.getCurrentStage():setFocus(e.target, nil) else'
    GAME.lua = GAME.lua .. '\n display.getCurrentStage():setFocus(nil) for name, object in pairs(GAME_objects) do'
    GAME.lua = GAME.lua .. '\n if object._touch and object ~= e.target then GAME_objects[name]._touch = false end end end end'
    GAME.lua = GAME.lua .. '\n return (not ((function(p) if p.phase == \'ended\' or p.phase == \'cancelled\' then' M.requestNestedBlock(nested)
    GAME.lua = GAME.lua .. '\n end end)(e) == false)) end end) if isComplete then return result end return true end) end) end)'
end

M['onLocalCollisionBeganNoob'] = function(nested, params)
    GAME.lua = GAME.lua .. '\n timer.new(1, 1, function() pcall(function() local name, name2 = ' .. CALC(params[1]) .. ', ' .. CALC(params[2])
    GAME.lua = GAME.lua .. '\n GAME_objects[name].collision = function(s, e) if GAME.hash == hash then local isComplete, result ='
    GAME.lua = GAME.lua .. '\n pcall(function() return (function(p) if GAME.hash == hash then if p.phase == \'began\' then'
    GAME.lua = GAME.lua .. '\n if p.other.name == name2 then' M.requestNestedBlock(nested)
    GAME.lua = GAME.lua .. '\n end end end end)(e) end) return isComplete and result or false'
    GAME.lua = GAME.lua .. '\n end end GAME_objects[name]:addEventListener(\'collision\') end) end)'
end

M['onFunNoob'] = M['onFun']
M['onConditionNoob'] = M['onCondition']
M['onTouchDisplayBeganNoob'] = M['onTouchDisplayBegan']
M['onTouchDisplayEndedNoob'] = M['onTouchDisplayEnded']
M['onTouchDisplayMovedNoob'] = M['onTouchDisplayMoved']

return M
