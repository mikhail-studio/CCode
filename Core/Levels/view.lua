local M = require('Core.Levels.generate', true)
local P = {}

local LevelPresenter = require('Core.Levels.presenter', true)

local Themes = require('Data.themes')

local Filter = require('Core.Modules.name-filter')

function M:destroyOverride()
    system.deactivate('multitouch')
    P.map:removeSelf() P.map = nil
    P.bottbar:removeSelf() P.bottbar = nil
    P.sidebar:removeSelf() P.sidebar = nil
end

function M:toFront()
    P.phone:toFront()
    P.app:toFront()
end

function M:create(levelLink)
    M.group = display.newGroup()

    P.map = display.newGroup()
    M.group:insert(P.map)

    P.map.sizeGroup = display.newGroup()
    P.map.sizeGroup:insert(P.map)

    P.map.x = -CENTER_X - 100
    P.map.y = -CENTER_Y
    P.map.sizeGroup.x = CENTER_X
    P.map.sizeGroup.y = CENTER_Y

    local theme = Themes.list.default

    display.setDefault('background', unpack(theme.bgAdd3Color))
    LevelPresenter:constructor(self)

    local grid = 45
    local countLines = 100
    local size = DISPLAY_HEIGHT * countLines

    P.lineCenterY = display.newRect(P.map,
        CENTER_X, CENTER_Y, 12, size)
    P.lineCenterY.alpha = 0.4

    P.lineCenterX = display.newRect(P.map,
        CENTER_X, CENTER_Y, size, 12)
    P.lineCenterX.alpha = 0.4

    local xPlus = CENTER_X + grid
    local xMinus = CENTER_X - grid
    local yPlus = CENTER_Y + grid
    local yMinus = CENTER_Y - grid

    for i = 1, countLines * 10 do
        local lineY = display.newRect(P.map, xPlus, CENTER_Y, 6, size)
        lineY.alpha = 0.1
        xPlus = xPlus + grid
    end

    for i = 1, countLines * 10 do
        local lineY = display.newRect(P.map, xMinus, CENTER_Y, 6, size)
        lineY.alpha = 0.1
        xMinus = xMinus - grid
    end

    for i = 1, countLines * 10 do
        local lineX = display.newRect(P.map, CENTER_X, yPlus, size, 6)
        lineX.alpha = 0.1
        yPlus = yPlus + grid
    end

    for i = 1, countLines * 10 do
        local lineX = display.newRect(P.map, CENTER_X, yMinus, size, 6)
        lineX.alpha = 0.1
        yMinus = yMinus - grid
    end

    P.phone = display.newRect(P.map,
        CENTER_X, CENTER_Y, DISPLAY_WIDTH, DISPLAY_HEIGHT)
    P.phone:setFillColor(0, 0, 0, 0)
    P.phone:setStrokeColor(0.8, 0.5, 0.3, 0.7)
    P.phone.strokeWidth = 12

    P.app = display.newRect(P.map,
        CENTER_X, CENTER_Y, 720, 1280)
    P.app:setFillColor(0, 0, 0, 0)
    P.app:setStrokeColor(0.3, 0.8, 0.5, 0.7)
    P.app.strokeWidth = 12

    P.map.sizeGroup.xScale = P.map.sizeGroup.xScale * 0.6
    P.map.sizeGroup.yScale = P.map.sizeGroup.yScale * 0.6

    P:createSidebar()
    P:createBottbar()
    M:createLevel(LevelPresenter, levelLink)

    Runtime:addEventListener('touch', LevelPresenter.canvasListener)
    Runtime:addEventListener('mouse', LevelPresenter.mouseListener)
end

function M:getMap()
    return P.map
end

function P:createSidebar()
    P.sidebar = display.newGroup()

    local theme = Themes.list.default
    local size = DISPLAY_WIDTH / 8
    local y = size / 2 + size / 4 -- ZERO_Y + size - size / 4
    local conf = {
        'name', 'x', 'y', 'width', 'height',
        'text', 'size', 'rotate2', 'layer', 'body'
    }

    P.bgSidebar = display.newRect(P.sidebar,
        MAX_X - (size + 20) / 2, CENTER_Y, size + 20, DISPLAY_HEIGHT)
    P.bgSidebar:setFillColor(unpack(Themes.list.default.bgAdd2Color))

    P.scrollSidebar = WIDGET.newScrollView({
            x = P.bgSidebar.x, width = P.bgSidebar.width,
            y = P.bgSidebar.y - (DISPLAY_WIDTH / 11 + 20) / 2 + TOP_HEIGHT,
            height = P.bgSidebar.height - DISPLAY_WIDTH / 11 - 20,
            hideBackground = true, hideScrollBar = true,
            horizontalScrollDisabled = true, isBounceEnabled = true
        })
    P.sidebar:insert(P.scrollSidebar)

    for _, _type in ipairs(conf) do
        local type = _type .. 'Level'

        P[type] = display.newRoundedRect(P.sidebar,
            P.bgSidebar.width / 2, y, size, size, size / 5)
        P[type].id = type
        P[type].alpha = 0.005

        P[type].icon = display.newImage(P.sidebar, Themes[_type .. 'Object'](),
            P[type].x, P[type].y)
        P[type].icon.width = size / 1.4
        P[type].icon.height = size / 1.4

        P.scrollSidebar:insert(P[type])
        P.scrollSidebar:insert(P[type].icon)

        P[type]:addEventListener('touch', function(e)
            return LevelPresenter.sidebarButtonsListener(e, P.scrollSidebar)
        end)

        y = y + 20 + size
    end
end

function P:createBottbar()
    P.bottbar = display.newGroup()

    local theme = Themes.list.default
    local size = DISPLAY_WIDTH / 11

    P.bgBottbar = display.newRect(P.bottbar,
        CENTER_X, MAX_Y - (size + 20) / 2, DISPLAY_WIDTH, size + 20)
    P.bgBottbar:setFillColor(unpack(theme.bgAdd2Color))

    P.bgBottbar2 = display.newRect(P.bottbar,
        CENTER_X, MAX_Y + BOTTOM_HEIGHT, DISPLAY_WIDTH,
        MAX_Y + BOTTOM_HEIGHT - P.bgBottbar.y - (size + 20) / 2)
    P.bgBottbar2:setFillColor(unpack(theme.bgAdd2Color))
    P.bgBottbar2.anchorY = 1

    P.addLevel = display.newRoundedRect(P.bottbar,
        ZERO_X + size - 6, P.bgBottbar.y, size, size, size / 5)
    P.addLevel.id = 'addLevel'
    P.addLevel.alpha = 0.005

    P.addLevel.icon = display.newImage(P.bottbar, Themes.addLevel(),
        P.addLevel.x, P.addLevel.y)
    P.addLevel.icon.width = size / 1.4
    P.addLevel.icon.height = size / 1.4

    P.eyeLevel = display.newRoundedRect(P.bottbar,
        P.addLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.eyeLevel.id = 'eyeLevel'
    P.eyeLevel.alpha = 0.005

    P.eyeLevel.icon = display.newImage(P.bottbar, Themes.eyeLevel(),
        P.eyeLevel.x, P.eyeLevel.y)
    P.eyeLevel.icon.width = size / 1.4
    P.eyeLevel.icon.height = size / 1.4

    P.moveLevel = display.newRoundedRect(P.bottbar,
        P.eyeLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.moveLevel.id = 'moveLevel'
    P.moveLevel.alpha = 0.005

    P.moveLevel.icon = display.newImage(P.bottbar, Themes.moveLevel(),
        P.moveLevel.x, P.moveLevel.y)
    P.moveLevel.icon.width = size / 1.4
    P.moveLevel.icon.height = size / 1.4

    P.scaleLevel = display.newRoundedRect(P.bottbar,
        P.moveLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.scaleLevel.id = 'scaleLevel'
    P.scaleLevel.alpha = 0.005

    P.scaleLevel.icon = display.newImage(P.bottbar, Themes.scaleLevel(),
        P.scaleLevel.x, P.scaleLevel.y)
    P.scaleLevel.icon.width = size / 1.4
    P.scaleLevel.icon.height = size / 1.4

    P.rotateLevel = display.newRoundedRect(P.bottbar,
        P.scaleLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.rotateLevel.id = 'rotateLevel'
    P.rotateLevel.alpha = 0.005

    P.rotateLevel.icon = display.newImage(P.bottbar, Themes.rotateLevel(),
        P.rotateLevel.x, P.rotateLevel.y)
    P.rotateLevel.icon.width = size / 1.4
    P.rotateLevel.icon.height = size / 1.4

    P.cloneLevel = display.newRoundedRect(P.bottbar,
        P.rotateLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.cloneLevel.id = 'cloneLevel'
    P.cloneLevel.alpha = 0.005

    P.cloneLevel.icon = display.newImage(P.bottbar, Themes.cloneLevel(),
        P.cloneLevel.x, P.cloneLevel.y)
    P.cloneLevel.icon.width = size / 1.4
    P.cloneLevel.icon.height = size / 1.4

    P.deleteLevel = display.newRoundedRect(P.bottbar,
        P.cloneLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.deleteLevel.id = 'deleteLevel'
    P.deleteLevel.alpha = 0.005

    P.deleteLevel.icon = display.newImage(P.bottbar, Themes.deleteLevel(),
        P.deleteLevel.x, P.deleteLevel.y)
    P.deleteLevel.icon.width = size / 1.4
    P.deleteLevel.icon.height = size / 1.4

    P.saveLevel = display.newRoundedRect(P.bottbar,
        P.deleteLevel.x + 20 + size, P.bgBottbar.y, size, size, size / 5)
    P.saveLevel.id = 'saveLevel'
    P.saveLevel.alpha = 0.005

    P.saveLevel.icon = display.newImage(P.bottbar, Themes.saveLevel(),
        P.saveLevel.x, P.deleteLevel.y)
    P.saveLevel.icon.width = size / 1.4
    P.saveLevel.icon.height = size / 1.4

    -- timer.new(1, 1, function()
    --     LevelPresenter.cloneLevel(P.cloneLevel, 'ended')
    -- end)

    P.addLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.eyeLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.moveLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.scaleLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.rotateLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.cloneLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.deleteLevel:addEventListener('touch', LevelPresenter.buttonsListener)
    P.saveLevel:addEventListener('touch', LevelPresenter.buttonsListener)
end

local enterConfig = {
    name = {STR['levels.enterobjname'], function(event, data, oldText)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.simpleCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end, data, oldText)
        end
    end, 'name'},

    x = {STR['levels.enterobjx'], function(event, data, oldText)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.numberCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end)
        end
    end, 'x'},

    layer = {STR['levels.enterobjlayer'], function(event, data, oldText)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.numberCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    local conditionFalse = tonumber(event.target.text) < 1
                    local conditionFalse2 = tonumber(event.target.text) > #data

                    if not (conditionFalse or conditionFalse2) then
                        INPUT.remove(true, ev.text)
                    end
                end
            end)
        end
    end, 'layer'},

    y = {STR['levels.enterobjy'], nil, 'y'},
    width = {STR['levels.enterobjwidth'], nil, 'width'},
    height = {STR['levels.enterobjheight'], nil, 'height'},
    size = {STR['levels.enterobjsize'], nil, 'size'},
    rotate2 = {STR['levels.enterobjrotate'], nil, 'rotation'},

    text = {STR['levels.enterobjname'], function(event, data, oldText)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.simpleCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end, data, oldText)
        end
    end, 'text'},

    body = {STR['levels.enterobjname'], function(event, data, oldText)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.simpleCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end, data, oldText)
        end
    end, 'body'}
}

enterConfig.y[2] = enterConfig.x[2]
enterConfig.width[2] = enterConfig.x[2]
enterConfig.height[2] = enterConfig.x[2]
enterConfig.size[2] = enterConfig.x[2]
enterConfig.rotate2[2] = enterConfig.x[2]

function M:openEnterWindow(type, img, data)
    local inputText = enterConfig[type][1]
    local textEnterListener = enterConfig[type][2]
    local oldText = img.data[enterConfig[type][3]]
    local checkbox

    if type == 'layer' then
        oldText = img.index
        checkbox = {
            STR['levels.enterobjlayerall'] .. ' ' .. #data,
            STR['levels.enterobjlayercurrent'] .. ' ' .. img.index
        }
    elseif type == 'text' then
        oldText = img.data.type[2]
    end

    local inputEnterListener = function(e)
        if e.input then
            LevelPresenter.enterNewConfig(type, img, e.text)
        end
    end

    INPUT.new(inputText, function(event)
            textEnterListener(event, data, oldText)
        end, inputEnterListener, tostring(oldText), checkbox)
    INPUT.bg:setFillColor(unpack(LOCAL.themes.bgAdd4Color))

    if type == 'layer' then
        INPUT.checkbox[1].listener = function()
            INPUT.checkbox[1]:setState({isOn = false})
        end

        INPUT.checkbox[2].listener = function()
            INPUT.checkbox[2]:setState({isOn = false})
        end
    end
end

function M:openSaveWindow(listener)
    local buttons = {STR['button.no'], STR['button.yes']}
    WINDOW.new(STR['levels.save'], buttons, listener, 4)
end

function M:openExitWindow(listener)
    local buttons = {STR['button.no'], STR['button.yes']}
    WINDOW.new(STR['levels.exit'], buttons, listener, 4)
end

function M:save()
    LevelPresenter.save()
end

local function openAddSpriteWindow(data)
    local inputText = STR['levels.enterobjname']
    local checkboxText = STR['images.pixel' .. (NOOBMODE and '.noob' or '')]

    local textAddObjectListener = function(event)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.simpleCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end, data)
        end
    end

    local inputAddObjectListener = function(e)
        if e.input then
            LevelPresenter.addObjectInLevel(e.text, e.checkbox)
        end
    end

    INPUT.new(inputText, textAddObjectListener,
        inputAddObjectListener, nil, checkboxText)
    INPUT.bg:setFillColor(unpack(LOCAL.themes.bgAdd4Color))
end

local function openAddTextWindow(data)
    local inputText = STR['levels.entertextname']
    local inputTextLabel = STR['levels.entertextlabel']
    local nameText = ''

    local textAddTextListener = function(event)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            Filter.simpleCheck(event.target.text, function(ev)
                if ev.isError then
                    INPUT.remove(false)
                    WINDOW.new(STR['errors.' .. ev.typeError],
                        {STR['button.close']}, function() end, 5)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                else
                    INPUT.remove(true, ev.text)
                end
            end, data)
        end
    end

    local textListener = function(event)
        local isEnded = event.phase == 'ended' or event.phase == 'submitted'
        if isEnded and not ALERT then
            INPUT.remove(true, event.target.text)
        end
    end

    local labelListener = function(e)
        if e.input then
            LevelPresenter.addTextInLevel(nameText, e.text)
        end
    end

    local inputAddTextListener = function(e)
        if e.input then
            nameText = e.text
            timer.new(1, 1, function()
                INPUT.new(inputTextLabel, textListener, labelListener)
                INPUT.bg:setFillColor(unpack(LOCAL.themes.bgAdd4Color))
            end)
        end
    end

    INPUT.new(inputText, textAddTextListener, inputAddTextListener)
    INPUT.bg:setFillColor(unpack(LOCAL.themes.bgAdd4Color))
end

function M:openAddObjectWindow(data)
    local windowText = STR['levels.enterobjtype']
    local buttons = {STR['blocks.select.pic'], STR['blocks.select.text']}

    local windowEnterTypeObjectListener = function(e)
        timer.new(1, 1, function()
            if e.index == 1 then
                openAddSpriteWindow(data)
            elseif e.index == 2 then
                openAddTextWindow(data)
            end
        end)
    end

    WINDOW.new(windowText, buttons, windowEnterTypeObjectListener, 1)
end

function M:clear()
    local objs = {
        P.eyeLevel, P.moveLevel, P.scaleLevel,
        P.rotateLevel, P.cloneLevel, P.deleteLevel,
        P.nameLevel, P.xLevel, P.yLevel,
        P.widthLevel, P.heightLevel, P.rotate2Level,
        P.layerLevel, P.textLevel, P.sizeLevel, P.bodyLevel
    }

    for _, obj in pairs(objs) do
        obj.alpha = 0.005
    end
end

function M:setActiveButton(target, isVisible)
    self:clear()

    if isVisible then
        target.alpha = 0.2
    else
        target.alpha = 0.005
    end
end

function M:animationButton(target, phase)
    if phase == 'began' then
        target.icon.xScale = 0.8
        target.icon.yScale = 0.8
    else
        target.icon.xScale = 1.0
        target.icon.yScale = 1.0
    end
end

return table.merge(M, require('Interfaces.scene', true))
