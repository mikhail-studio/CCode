local CUSTOM = require 'Core.Modules.custom-block'
local BLOCK = require 'Core.Modules.logic-block'
local INFO = require 'Data.info'
local M = {}

local function showTypeScroll(event)
    if event.phase == 'began' then
        display.getCurrentStage():setFocus(event.target)
        event.target.click = true
    elseif event.phase == 'moved' then
        if math.abs(event.x - event.xStart) > 30 or math.abs(event.y - event.yStart) > 30 then
            display.getCurrentStage():setFocus(nil)
            event.target.click = false
        end
    elseif event.phase == 'ended' or event.phase == 'cancelled' then
        display.getCurrentStage():setFocus(nil)
        if event.target.click and M.group.currentIndex ~= event.target.index then
            event.target.click = false

            if M.group.types[event.target.index].currentScroll == 2 then
                M.group.types[event.target.index].scroll2.isVisible = true
            else
                M.group.types[event.target.index].scroll.isVisible = true
            end

            if M.group.types[M.group.currentIndex].currentScroll == 2 then
                M.group.types[M.group.currentIndex].scroll2.isVisible = false
            else
                M.group.types[M.group.currentIndex].scroll.isVisible = false
            end

            M.group[4].isVisible = event.target.index == 1
            M.group[3].isVisible = event.target.index == 1 or event.target.index == 15
            or event.target.index == 9 or event.target.index == 6 or event.target.index == 3
            for i = 5, 10 do M.group[i].isVisible = event.target.index == 15 end
            for i = 19, 20 do M.group[i].isVisible = event.target.index == 15 end
            for i = 11, 14 do M.group[i].isVisible = event.target.index == 9 end
            for i = 15, 18 do M.group[i].isVisible = event.target.index == 6 end
            for i = 21, 24 do M.group[i].isVisible = event.target.index == 3 end
            M.group.currentIndex = event.target.index
        end
    end

    return true
end

local function newBlockListener(event)
    pcall(function()
        if event.phase == 'began' then
            display.getCurrentStage():setFocus(event.target)
            event.target.click = true
        elseif event.phase == 'moved' then
            if math.abs(event.x - event.xStart) > 30 or math.abs(event.y - event.yStart) > 30 then
                if M.group.types[event.target.index[1]].currentScroll == 2 then
                    M.group.types[event.target.index[1]].scroll2:takeFocus(event)
                else
                    M.group.types[event.target.index[1]].scroll:takeFocus(event)
                end
                event.target.click = false
            end
        elseif event.phase == 'ended' or event.phase == 'cancelled' then
            display.getCurrentStage():setFocus(nil)
            if event.target.click then
                event.target.click = false
                if M.group[7].isOn and event.target.index[1] == 15 then
                    local custom, name = GET_GAME_CUSTOM(), INFO.listBlock[INFO.listType[event.target.index[1]]][event.target.index[2]]
                    local params = (function() local t = {} for i = 1, #INFO.listName[name] - 1 do t[i] = {} end return t end)()

                    for index, block in pairs(custom) do
                        if 'custom' .. index == name then
                            CUSTOM.newBlock(block[1], params, block[2], index) break
                        end
                    end
                elseif M.group[19].isOn and event.target.index[1] == 15 then
                    local name = INFO.listBlock[INFO.listType[event.target.index[1]]][event.target.index[2]]
                    local custom = GET_GAME_CUSTOM() local _index = tostring(custom.len + 1)

                    for i = 1, custom.len do
                        if not custom[tostring(i)] then
                            _index = tostring(i) break
                        end
                    end

                    for index, block in pairs(custom) do
                        if 'custom' .. index == name then
                            local blockParams = (function() local t = {} for i = 1, #custom[index][2] do t[i] = 'value' end return t end)()

                            custom.len = custom.len + 1
                            custom[_index] = {
                                custom[index][1],
                                COPY_TABLE(custom[index][2]),
                                type(custom[index][3]) == 'table' and COPY_TABLE(custom[index][3]) or custom[index][3],
                                os.time()
                            }

                            STR['blocks.custom' .. _index] = custom[_index][1]
                            STR['blocks.custom' .. _index .. '.params'] = custom[_index][2]
                            LANG.ru['blocks.custom' .. _index] = custom[_index][1]
                            LANG.ru['blocks.custom' .. _index .. '.params'] = custom[_index][2]
                            INFO.listName['custom' .. _index] = {'custom', unpack(blockParams)}

                            table.insert(INFO.listBlock.custom, 1, 'custom' .. _index)
                            table.insert(INFO.listBlock.everyone, 'custom' .. _index)

                            SET_GAME_CUSTOM(custom)
                            M.remove() M.create()
                            M.group.types[1].scroll.isVisible = false
                            M.group.types[15].scroll.isVisible = true
                            M.group[3].isVisible = true
                            M.group[4].isVisible = false
                            for i = 5, 10 do M.group[i].isVisible = true end
                            for i = 19, 20 do M.group[i].isVisible = true end
                            M.group.currentIndex = 15 break
                        end
                    end
                elseif M.group[9].isOn and event.target.index[1] == 15 then
                    local name = INFO.listBlock[INFO.listType[event.target.index[1]]][event.target.index[2]]
                    local custom, data = GET_GAME_CUSTOM(), GET_GAME_CODE(CURRENT_LINK)

                    for index, block in pairs(custom) do
                        if 'custom' .. index == name then
                            for i = 1, #INFO.listBlock.custom do
                                if INFO.listBlock.custom[i] == name then table.remove(INFO.listBlock.custom, i) break end
                            end

                            for i = 1, #INFO.listBlock.everyone do
                                if INFO.listBlock.everyone[i] == name then table.remove(INFO.listBlock.everyone, i) break end
                            end

                            for i = 1, #data.scripts do
                                for j = 1, #data.scripts[i].params do
                                    if data.scripts[i].params[j].name == 'custom' .. index then
                                        table.remove(data.scripts[i].params, j)
                                    end
                                end
                            end

                            SET_GAME_CODE(CURRENT_LINK, data)
                            BLOCKS.group:removeSelf() BLOCKS.group = nil
                            BLOCKS.create() BLOCKS.custom = nil
                            BLOCKS.group.isVisible = false
                            custom[index] = nil custom.len = custom.len - 1
                            SET_GAME_CUSTOM(custom)

                            M.remove() M.create()
                            M.group.types[1].scroll.isVisible = false
                            M.group.types[15].scroll.isVisible = true
                            M.group[3].isVisible = true
                            M.group[4].isVisible = false
                            for i = 5, 10 do M.group[i].isVisible = true end
                            for i = 19, 20 do M.group[i].isVisible = true end
                            M.group.currentIndex = 15 break
                        end
                    end
                else
                    EXITS.new_block()

                    local data = GET_GAME_CODE(CURRENT_LINK)
                    local scrollY = select(2, BLOCKS.group[8]:getContentPosition())
                    local diffY = BLOCKS.group[8].y - BLOCKS.group[8].height / 2
                    local targetY = math.abs(scrollY) + diffY + CENTER_Y - 150
                    local blockName = INFO.listBlock[INFO.listType[event.target.index[1]]][event.target.index[2]]
                    local blockEvent = M.group.currentIndex == 2 or INFO.getType(blockName) == 'events'
                    local blockIndex = #BLOCKS.group.blocks + 1
                    local blockParams = {
                        name = blockName, params = {}, event = blockEvent, comment = false,
                        nested = blockEvent and {} or nil, vars = blockEvent and {} or nil, tables = blockEvent and {} or nil
                    }

                    for i = 1, #INFO.listName[blockName] - 1 do
                        blockParams.params[i] = {}
                    end

                    for i = 1, #BLOCKS.group.blocks do
                        if BLOCKS.group.blocks[i].y > targetY then
                            blockIndex = i break
                        end
                    end

                    if not blockEvent and #BLOCKS.group.blocks == 0 then
                        table.insert(data.scripts[CURRENT_SCRIPT].params, 1, {
                            name = 'onStart', params = {{}}, event = true, comment = false,
                            nested = {}, vars = {}, tables = {}
                        }) BLOCKS.new('onStart', 1, true, {{}}, false, {}) blockIndex = 2
                    end

                    if INFO.listNested[blockName] then
                        blockParams.nested = {}
                        for i = 1, #INFO.listNested[blockName] do
                            table.insert(data.scripts[CURRENT_SCRIPT].params, blockIndex, {
                                name = INFO.listNested[blockName][i], params = {{}}, event = false, comment = false
                            }) BLOCKS.new(INFO.listNested[blockName][i], blockIndex, false, {{}}, false)
                        end
                    end

                    native.setKeyboardFocus(nil)
                    table.insert(data.scripts[CURRENT_SCRIPT].params, blockIndex, blockParams)
                    SET_GAME_CODE(CURRENT_LINK, data)
                    BLOCKS.new(blockName, blockIndex, blockEvent, COPY_TABLE(blockParams.params), false, blockParams.nested)

                    if #BLOCKS.group.blocks > 2 then
                        display.getCurrentStage():setFocus(BLOCKS.group.blocks[blockIndex])
                        BLOCKS.group.blocks[blockIndex].click = true
                        BLOCKS.group.blocks[blockIndex].move = true
                        newMoveLogicBlock({target = BLOCKS.group.blocks[blockIndex]}, BLOCKS.group, BLOCKS.group[8], true)
                    end
                end
            end
        end
    end)

    return true
end

local function textListener(event)
    if event.phase == 'editing' then
        M.group.types[1].scroll:removeSelf()
        M.group.types[1].scroll = WIDGET.newScrollView({
                x = CENTER_X, y = (M.group[3].y + 2 + M.group[2].y) / 2,
                width = DISPLAY_WIDTH, height = M.group[2].y - M.group[3].y + 2,
                hideBackground = true, hideScrollBar = false,
                horizontalScrollDisabled = true, isBounceEnabled = true,
            })
        M.group:insert(M.group.types[1].scroll)

        local lastY = 90
        local scrollHeight = 50

        for j = 1, #INFO.listBlock.everyone do
            local notCustom = not (BLOCKS.custom and INFO.getType(INFO.listBlock.everyone[j]) == 'custom' and j ~= 1)

            if UTF8.find(UTF8.lower(STR['blocks.' .. INFO.listBlock.everyone[j]]), UTF8.lower(event.target.text), 1, true) and notCustom then
                local event = INFO.getType(INFO.listBlock.everyone[j]) == 'events'

                M.group.types[1].blocks[j] = display.newPolygon(0, 0, BLOCK.getPolygonParams(event, DISPLAY_WIDTH - RIGHT_HEIGHT - 60, event and 102 or 116))
                    M.group.types[1].blocks[j].x = DISPLAY_WIDTH / 2
                    M.group.types[1].blocks[j].y = lastY
                    M.group.types[1].blocks[j]:setFillColor(INFO.getBlockColor(INFO.listBlock.everyone[j]))
                    M.group.types[1].blocks[j]:setStrokeColor(0.3)
                    M.group.types[1].blocks[j].strokeWidth = 4
                    M.group.types[1].blocks[j].index = {1, j}
                    M.group.types[1].blocks[j]:addEventListener('touch', newBlockListener)
                M.group.types[1].scroll:insert(M.group.types[1].blocks[j])

                M.group.types[1].blocks[j].text = display.newText({
                        text = STR['blocks.' .. INFO.listBlock.everyone[j]],
                        x = DISPLAY_WIDTH / 2 - M.group.types[1].blocks[j].width / 2 + 20,
                        y = lastY, width = M.group.types[1].blocks[j].width - 40,
                        height = 40, font = 'ubuntu', fontSize = 32, align = 'left'
                    }) M.group.types[1].blocks[j].text.anchorX = 0
                M.group.types[1].scroll:insert(M.group.types[1].blocks[j].text)

                lastY = lastY + 140
                scrollHeight = scrollHeight + 140
            end
        end

        M.group.types[1].scroll:setScrollHeight(scrollHeight)
    end
end

M.remove = function()
    pcall(function()
        M.group[4]:removeSelf()
        M.group:removeSelf()
        M.group = nil
    end)
end

M.create = function()
    if M.group then
        M.group.isVisible = true

        if M.group.types[M.group.currentIndex].currentScroll == 2 then
            M.group.types[M.group.currentIndex].scroll2.isVisible = true
        else
            M.group.types[M.group.currentIndex].scroll.isVisible = true
        end

        M.group[3].isVisible = M.group.currentIndex == 1 or M.group.currentIndex == 15
        or M.group.currentIndex == 9 or M.group.currentIndex == 6 or M.group.currentIndex == 3
        M.group[4].isVisible, M.group[5].alpha = M.group.currentIndex == 1, 0.1
        M.group[7].alpha, M.group[7].isOn = 0.1, false
        M.group[9].alpha, M.group[9].isOn = 0.1, false
        M.group[19].alpha, M.group[19].isOn = 0.1, false
        for i = 5, 10 do M.group[i].isVisible = M.group.currentIndex == 15 end
        for i = 19, 20 do M.group[i].isVisible = M.group.currentIndex == 15 end
        for i = 11, 14 do M.group[i].isVisible = M.group.currentIndex == 9 end
        for i = 15, 18 do M.group[i].isVisible = M.group.currentIndex == 6 end
        for i = 21, 24 do M.group[i].isVisible = M.group.currentIndex == 3 end

        if M.group.currentIndex == 1 and M.group[4].text ~= '' then
            M.group[4].text = ''
            textListener({phase = 'editing', target = M.group[4]})
        end
    else
        M.group = display.newGroup()
        M.group.types = {}
        M.group.currentIndex = 1

        local bg = display.newImage('Sprites/bg.png', CENTER_X, CENTER_Y)
            bg.width = CENTER_X == 640 and DISPLAY_HEIGHT or DISPLAY_WIDTH
            bg.height = CENTER_X == 640 and DISPLAY_WIDTH or DISPLAY_HEIGHT
            bg.rotation = CENTER_X == 640 and 90 or 0
        M.group:insert(bg)

        local line = display.newRect(CENTER_X, MAX_Y - 275, DISPLAY_WIDTH, 2)
            line:setFillColor(0.45)
        M.group:insert(line)

        local find = display.newRect(CENTER_X, ZERO_Y + 80, DISPLAY_WIDTH - RIGHT_HEIGHT - 60, 2)
            find:setFillColor(0.9)
        M.group:insert(find)

        local box = native.newTextField(5000, ZERO_Y + 50, DISPLAY_WIDTH - RIGHT_HEIGHT - 70, not IS_SIM and 28 or 56)
            timer.performWithDelay(0, function()
                if M.group and M.group.isVisible and box then
                    box.x = CENTER_X
                    box.isEditable = true
                    box.hasBackground = false
                    box.placeholder = STR['button.block.find']
                    box.font = native.newFont('ubuntu', 28)

                    pcall(function() if system.getInfo 'platform' == 'android' and not IS_SIM and box then
                        box:setTextColor(0.9)
                    else
                        box:setTextColor(0.1)
                    end end)
                end
            end) box:addEventListener('userInput', textListener)
        M.group:insert(box)

        local buttonListeners = function(e)
            if M.group and M.group.isVisible then
                if e.phase == 'began' then
                    display.getCurrentStage():setFocus(e.target)
                    e.target.alpha = ((e.target.tag == 'groups' or e.target.tag == 'tags') and e.target.isOn) and 0.3 or 0.2
                    e.target.click = true
                elseif e.phase == 'moved' and (math.abs(e.xDelta) > 30 or math.abs(e.yDelta) > 30) then
                    display.getCurrentStage():setFocus(nil)
                    e.target.alpha = ((e.target.tag == 'change' or e.target.tag == 'remove') and e.target.isOn) and 0.3
                    or (((e.target.tag == 'groups' or e.target.tag == 'tags') and e.target.isOn) and 0.3 or 0.1)
                    e.target.click = false
                elseif e.phase == 'ended' or e.phase == 'cancelled' then
                    display.getCurrentStage():setFocus(nil)
                    if e.target.click then
                        e.target.click = false
                        e.target.alpha = ((e.target.tag == 'groups' or e.target.tag == 'tags') and e.target.isOn) and 0.3 or 0.1
                        if e.target.tag == 'create' then
                            CUSTOM.newBlock()
                        elseif e.target.tag == 'change' then
                            e.target.alpha = e.target.isOn and 0.1 or 0.3
                            e.target.isOn = not e.target.isOn
                            M.group[9].alpha = e.target.isOn and 0.1 or M.group[9].alpha
                            M.group[9].isOn = (function() if e.target.isOn then return false else return M.group[9].isOn end end)()
                            M.group[19].alpha = e.target.isOn and 0.1 or M.group[19].alpha
                            M.group[19].isOn = (function() if e.target.isOn then return false else return M.group[19].isOn end end)()
                        elseif e.target.tag == 'remove' then
                            e.target.alpha = e.target.isOn and 0.1 or 0.3
                            e.target.isOn = not e.target.isOn
                            M.group[7].alpha = e.target.isOn and 0.1 or M.group[7].alpha
                            M.group[7].isOn = (function() if e.target.isOn then return false else return M.group[7].isOn end end)()
                            M.group[19].alpha = e.target.isOn and 0.1 or M.group[19].alpha
                            M.group[19].isOn = (function() if e.target.isOn then return false else return M.group[19].isOn end end)()
                        elseif e.target.tag == 'copy' then
                            e.target.alpha = e.target.isOn and 0.1 or 0.3
                            e.target.isOn = not e.target.isOn
                            M.group[7].alpha = e.target.isOn and 0.1 or M.group[7].alpha
                            M.group[7].isOn = (function() if e.target.isOn then return false else return M.group[7].isOn end end)()
                            M.group[9].alpha = e.target.isOn and 0.1 or M.group[9].alpha
                            M.group[9].isOn = (function() if e.target.isOn then return false else return M.group[9].isOn end end)()
                        elseif e.target.tag == 'tags' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[11].isOn = false M.group[11].alpha = 0.1
                            M.group.types[9].scroll.isVisible = false M.group.types[9].scroll2.isVisible = true M.group.types[9].currentScroll = 2
                        elseif e.target.tag == 'groups' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[13].isOn = false M.group[13].alpha = 0.1
                            M.group.types[9].scroll.isVisible = true M.group.types[9].scroll2.isVisible = false M.group.types[9].currentScroll = 1
                        elseif e.target.tag == 'control2' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[15].isOn = false M.group[15].alpha = 0.1
                            M.group.types[6].scroll.isVisible = false M.group.types[6].scroll2.isVisible = true M.group.types[6].currentScroll = 2
                        elseif e.target.tag == 'control1' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[17].isOn = false M.group[17].alpha = 0.1
                            M.group.types[6].scroll.isVisible = true M.group.types[6].scroll2.isVisible = false M.group.types[6].currentScroll = 1
                        elseif e.target.tag == 'vars2' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[21].isOn = false M.group[21].alpha = 0.1
                            M.group.types[3].scroll.isVisible = false M.group.types[3].scroll2.isVisible = true M.group.types[3].currentScroll = 2
                        elseif e.target.tag == 'vars1' and not e.target.isOn then
                            e.target.isOn = true e.target.alpha = 0.3 M.group[23].isOn = false M.group[23].alpha = 0.1
                            M.group.types[3].scroll.isVisible = true M.group.types[3].scroll2.isVisible = false M.group.types[3].currentScroll = 1
                        end
                    end
                end
            else
                display.getCurrentStage():setFocus(nil)
            end

            return true
        end

        local width = (DISPLAY_WIDTH - RIGHT_HEIGHT - 60) * 0.25
        local width3 = (DISPLAY_WIDTH - RIGHT_HEIGHT - 60) * 0.5

        local button = display.newRect(find.x - find.width / 2 + width / 2, ZERO_Y + 50, width, 56)
            button.alpha = 0.1
            button.tag = 'create'
            button:addEventListener('touch', buttonListeners)
        M.group:insert(button)

        local buttonText = display.newText(STR['blocks.create.block'], button.x, button.y, 'ubuntu', 28)
            button.isVisible = false
            buttonText.isVisible = false
        M.group:insert(buttonText)

        local button2 = display.newRect(button.x + width / 2 + width / 2, ZERO_Y + 50, width, 56)
            button2.isOn = false
            button2.alpha = 0.1
            button2.tag = 'change'
            button2:addEventListener('touch', buttonListeners)
        M.group:insert(button2)

        local button2Text = display.newText(STR['button.change'], button2.x, button2.y, 'ubuntu', 28)
            button2.isVisible = false
            button2Text.isVisible = false
        M.group:insert(button2Text)

        local button3 = display.newRect(button2.x + width, ZERO_Y + 50, width, 56)
            button3.isOn = false
            button3.alpha = 0.1
            button3.tag = 'remove'
            button3:addEventListener('touch', buttonListeners)
        M.group:insert(button3)

        local button3Text = display.newText(STR['button.remove'], button3.x, button3.y, 'ubuntu', 28)
            button3.isVisible = false
            button3Text.isVisible = false
        M.group:insert(button3Text)

        local buttonGroup = display.newRect(find.x - find.width / 2 + width3 / 2, ZERO_Y + 50, width3, 56)
            buttonGroup.isOn = true
            buttonGroup.alpha = 0.3
            buttonGroup.tag = 'groups'
            buttonGroup:addEventListener('touch', buttonListeners)
        M.group:insert(buttonGroup)

        local buttonGroupText = display.newText(STR['blocks.create.groups'], buttonGroup.x, buttonGroup.y, 'ubuntu', 28)
            buttonGroup.isVisible = false
            buttonGroupText.isVisible = false
        M.group:insert(buttonGroupText)

        local buttonTag = display.newRect(buttonGroup.x + width3, ZERO_Y + 50, width3, 56)
            buttonTag.isOn = false
            buttonTag.alpha = 0.1
            buttonTag.tag = 'tags'
            buttonTag:addEventListener('touch', buttonListeners)
        M.group:insert(buttonTag)

        local buttonTagText = display.newText(STR['blocks.create.tags'], buttonTag.x, buttonTag.y, 'ubuntu', 28)
            buttonTag.isVisible = false
            buttonTagText.isVisible = false
        M.group:insert(buttonTagText)

        local buttonControl1 = display.newRect(find.x - find.width / 2 + width3 / 2, ZERO_Y + 50, width3, 56)
            buttonControl1.isOn = true
            buttonControl1.alpha = 0.3
            buttonControl1.tag = 'control1'
            buttonControl1:addEventListener('touch', buttonListeners)
        M.group:insert(buttonControl1)

        local buttonControl1Text = display.newText('1', buttonControl1.x, buttonControl1.y, 'ubuntu', 28)
            buttonControl1.isVisible = false
            buttonControl1Text.isVisible = false
        M.group:insert(buttonControl1Text)

        local buttonControl2 = display.newRect(buttonControl1.x + width3, ZERO_Y + 50, width3, 56)
            buttonControl2.isOn = false
            buttonControl2.alpha = 0.1
            buttonControl2.tag = 'control2'
            buttonControl2:addEventListener('touch', buttonListeners)
        M.group:insert(buttonControl2)

        local buttonControl2Text = display.newText('2', buttonControl2.x, buttonControl2.y, 'ubuntu', 28)
            buttonControl2.isVisible = false
            buttonControl2Text.isVisible = false
        M.group:insert(buttonControl2Text)

        local button4 = display.newRect(button3.x + width, ZERO_Y + 50, width, 56)
            button4.isOn = false
            button4.alpha = 0.1
            button4.tag = 'copy'
            button4:addEventListener('touch', buttonListeners)
        M.group:insert(button4)

        local button4Text = display.newText(STR['blocks.create.copy'], button4.x, button4.y, 'ubuntu', 28)
            button4.isVisible = false
            button4Text.isVisible = false
        M.group:insert(button4Text)

        local buttonVars1 = display.newRect(find.x - find.width / 2 + width3 / 2, ZERO_Y + 50, width3, 56)
            buttonVars1.isOn = true
            buttonVars1.alpha = 0.3
            buttonVars1.tag = 'vars1'
            buttonVars1:addEventListener('touch', buttonListeners)
        M.group:insert(buttonVars1)

        local buttonVars1Text = display.newText('1', buttonVars1.x, buttonVars1.y, 'ubuntu', 28)
            buttonVars1.isVisible = false
            buttonVars1Text.isVisible = false
        M.group:insert(buttonVars1Text)

        local buttonVars2 = display.newRect(buttonVars1.x + width3, ZERO_Y + 50, width3, 56)
            buttonVars2.isOn = false
            buttonVars2.alpha = 0.1
            buttonVars2.tag = 'vars2'
            buttonVars2:addEventListener('touch', buttonListeners)
        M.group:insert(buttonVars2)

        local buttonVars2Text = display.newText('2', buttonVars2.x, buttonVars2.y, 'ubuntu', 28)
            buttonVars2.isVisible = false
            buttonVars2Text.isVisible = false
        M.group:insert(buttonVars2Text)

        local width = CENTER_X == 360 and DISPLAY_WIDTH / 5 - 24 or DISPLAY_WIDTH / 6
        local x, y = ZERO_X + 20, MAX_Y - 220

        for i = 1, BLOCKS.custom and #INFO.listType - 1 or #INFO.listType do
            M.group.types[i] = display.newRoundedRect(x, y, width, 62, 11)
                M.group.types[i].index = i
                M.group.types[i].blocks = {}
                M.group.types[i].anchorX = 0
                M.group.types[i]:setFillColor(INFO.getBlockColor(nil, nil, INFO.listType[i]))
                M.group.types[i]:addEventListener('touch', showTypeScroll)
            M.group:insert(M.group.types[i])

            local text = display.newText({
                text = STR['blocks.' .. INFO.listType[i]],
                x = 0, y = 0, width = width - 5, font = 'sans.ttf', fontSize = 19
            }) local textheight = text.height > 48 and 48 or text.height text:removeSelf()

            M.group.types[i].text = display.newText({
                    text = STR['blocks.' .. INFO.listType[i]],
                    x = x + width / 2, y = y, width = width - 5, height = textheight,
                    font = 'ubuntu', fontSize = 19, align = 'center'
                })
            M.group:insert(M.group.types[i].text)

            M.group.types[i].scroll = WIDGET.newScrollView({
                    x = CENTER_X, y = (((i == 1 or i == 15 or i == 9 or i == 6 or i == 3) and find.y + 2 or ZERO_Y + 1) + line.y) / 2,
                    width = DISPLAY_WIDTH, height = line.y - ((i == 1 or i == 15 or i == 9 or i == 6 or i == 3) and find.y + 2 or ZERO_Y + 1),
                    hideBackground = true, hideScrollBar = false,
                    horizontalScrollDisabled = true, isBounceEnabled = true
                }) M.group.types[i].currentScroll = 1
            M.group:insert(M.group.types[i].scroll)

            if INFO.listDelimiter[INFO.listType[i]] then
                M.group.types[i].scroll2 = WIDGET.newScrollView({
                        x = CENTER_X, y = (((i == 1 or i == 15 or i == 9 or i == 6 or i == 3) and find.y + 2 or ZERO_Y + 1) + line.y) / 2,
                        width = DISPLAY_WIDTH, height = line.y - ((i == 1 or i == 15 or i == 9 or i == 6 or i == 3) and find.y + 2 or ZERO_Y + 1),
                        hideBackground = true, hideScrollBar = false,
                        horizontalScrollDisabled = true, isBounceEnabled = true
                    }) M.group.types[i].scroll2.isVisible = false
                M.group:insert(M.group.types[i].scroll2)
            end

            if i ~= 1 then M.group.types[i].scroll.isVisible = false end
            if i % 5 == 0 then y, x = y + 85, ZERO_X + 20 else x = x + width + 20 end

            local lastY = 90
            local scrollHeight = 50
            local scroll2Height = 50
            local startDelimiter = false

            if INFO.listType[i] ~= 'none' then
                for j = 1, #INFO.listBlock[INFO.listType[i]] do
                    local name = INFO.listBlock[INFO.listType[i]][j]
                    local notCustom = not (BLOCKS.custom and INFO.getType(name) == 'custom' and j ~= 1)

                    if INFO.listDelimiter[INFO.listType[i]] and name == INFO.listDelimiter[INFO.listType[i]][1] and not startDelimiter then
                        startDelimiter = true
                        lastY = 90
                    end

                    if UTF8.sub(name, UTF8.len(name) - 2, UTF8.len(name)) ~= 'End' and name ~= 'ifElse' and notCustom then
                        local event = INFO.listType[i] == 'events' or INFO.getType(name) == 'events'

                        M.group.types[i].blocks[j] = display.newPolygon(0, 0, BLOCK.getPolygonParams(event, DISPLAY_WIDTH - LEFT_HEIGHT - RIGHT_HEIGHT - 60, event and 102 or 116))
                            M.group.types[i].blocks[j].x = DISPLAY_WIDTH / 2
                            M.group.types[i].blocks[j].y = lastY
                            M.group.types[i].blocks[j]:setFillColor(INFO.getBlockColor(name))
                            M.group.types[i].blocks[j]:setStrokeColor(0.3)
                            M.group.types[i].blocks[j].strokeWidth = 4
                            M.group.types[i].blocks[j].index = {i, j}
                        M.group.types[i].blocks[j]:addEventListener('touch', newBlockListener)

                        if startDelimiter then
                            M.group.types[i].scroll2:insert(M.group.types[i].blocks[j])
                        else
                            M.group.types[i].scroll:insert(M.group.types[i].blocks[j])
                        end

                        M.group.types[i].blocks[j].text = display.newText({
                                text = STR['blocks.' .. name],
                                x = DISPLAY_WIDTH / 2 - M.group.types[i].blocks[j].width / 2 + 20,
                                y = lastY, width = M.group.types[i].blocks[j].width - 40,
                                height = 40, font = 'ubuntu', fontSize = 32, align = 'left'
                            })
                        M.group.types[i].blocks[j].text.anchorX = 0

                        if startDelimiter then
                            M.group.types[i].scroll2:insert(M.group.types[i].blocks[j].text)
                        else
                            M.group.types[i].scroll:insert(M.group.types[i].blocks[j].text)
                        end

                        lastY = lastY + 140
                        scrollHeight = startDelimiter and scrollHeight or scrollHeight + 140
                        scroll2Height = startDelimiter and scroll2Height + 140 or scroll2Height
                    end
                end
            end

            if startDelimiter then
                M.group.types[i].scroll2:setScrollHeight(scroll2Height)
            end M.group.types[i].scroll:setScrollHeight(scrollHeight)
        end
    end
end

return M
