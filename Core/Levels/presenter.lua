local M = {}
local P = {}

-- P.size = 1.1
P.size = 1.02
P.localSize = 0

M.enterNewConfig = function(type, img, value)
    local obj = img.data
    local enterConfig = {
        name = function()
            local value = tostring(value)
            M.model:saveName(value, obj)
        end,

        x = function()
            local value = tonumber(value)
            M.model:saveMove({x = value + CENTER_X, y = CENTER_Y - obj.y}, obj)
            M.view:updateImage(img)
        end,

        y = function()
            local value = tonumber(value)
            M.model:saveMove({y = CENTER_Y - value, x = obj.x + CENTER_X}, obj)
            M.view:updateImage(img)
        end,

        width = function()
            local value = tonumber(value)
            M.model:saveScale({width = value, height = obj.height}, obj)
            M.view:updateImage(img)
        end,

        height = function()
            local value = tonumber(value)
            M.model:saveScale({height = value, width = obj.width}, obj)
            M.view:updateImage(img)
        end,

        text = function()
            local value = tostring(value)
            M.model:saveText({text = value}, obj)
            M.view:updateImage(img)
        end,

        size = function()
            local value = tonumber(value)
            M.model:saveSize({size = value}, obj)
            M.view:updateImage(img)
        end,

        rotate2 = function()
            local value = tonumber(value)
            M.model:saveRotation({rotation = value}, obj)
            M.view:updateImage(img)
        end,

        layer = function()
            local value = tonumber(value)
            M.model:saveLayer(value, img)
            M.view:setLayer(value, img)
        end,

        body = function()
            M.model:saveBody({body = value}, obj)
        end,

        fixed = function()
            M.model:saveFixed({isFixedRotation = value}, obj)
        end,

        sensor = function()
            M.model:saveSensor({isSensor = value}, obj)
        end,

        gravity = function()
            local value = tonumber(value)
            M.model:saveGravity({gravity = value}, obj)
        end,

        density = function()
            local value = tonumber(value)
            M.model:saveDensity({density = value}, obj)
        end,

        bounce = function()
            local value = tonumber(value)
            M.model:saveBounce({bounce = value}, obj)
        end,

        friction = function()
            local value = tonumber(value)
            M.model:saveFriction({friction = value}, obj)
        end
    }

    enterConfig[type]()
end

M.enterListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.view:openEnterWindow(M.model:getActiveBool(),
                img, M.model:getScene().params)
        end
    end

    return true
end

M.cloneListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)

            if img.data.type[1] == 'text' then
                M.view:cloneText(M.model:saveClone(img.data))
            else
                M.view:cloneImage(M.model:saveClone(img.data))
            end
        end
    end

    return true
end

M.deleteListener = function(e)
    handlerTouch(e)

    local actImgGroup = e.target.parent.parent
    local imgGroup = actImgGroup.imgGroup
    local layerGroup = imgGroup.parent
    local img = imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveDelete(img.data)
            M.view:updLayer(img.index)
            layerGroup:removeSelf() layerGroup = nil
            actImgGroup:removeSelf() actImgGroup = nil
        end
    end

    return true
end

M.cRectListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            img.rotation = 0
            M.model:saveRotation(img, img.data)
        end
    end

    return true
end

M.cListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.pr = img.rotation
    elseif e.phase == 'moved' and e.target.isFocus then
        img.rotation = e.target.pr + e.yDelta * 0.5
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveRotation(img, img.data)
        end
    end

    return true
end

M.scaleListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.pw = img.width
        e.target.ph = img.height
    elseif e.phase == 'moved' and e.target.isFocus then
        img.width = e.target.pw + e.xDelta * 4
        img.height = e.target.ph - e.yDelta * 4
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveScale(img, img.data)
        end
    end

    return true
end

M.yScaleListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.ph = img.height
    elseif e.phase == 'moved' and e.target.isFocus then
        img.height = e.target.ph - e.yDelta * 4
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveScale(img, img.data)
        end
    end

    return true
end

M.xScaleListener = function(e)
    handlerTouch(e)

    local img = e.target.parent.parent.imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.pw = img.width
    elseif e.phase == 'moved' and e.target.isFocus then
        img.width = e.target.pw + e.xDelta * 4
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveScale(img, img.data)
        end
    end

    return true
end

M.moveListener = function(e)
    handlerTouch(e)

    local actImgGroup = e.target.parent.parent
    local imgGroup = actImgGroup.imgGroup
    local xScale = imgGroup.parent.parent.parent.sizeGroup.xScale
    local yScale = imgGroup.parent.parent.parent.sizeGroup.yScale
    local img = imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.px = imgGroup.x
        e.target.py = imgGroup.y
    elseif e.phase == 'moved' and e.target.isFocus then
        imgGroup.x = e.target.px + (e.x - e.xStart) / xScale
        imgGroup.y = e.target.py + (e.y - e.yStart) / yScale
        actImgGroup.x = imgGroup.x
        actImgGroup.y = imgGroup.y
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveMove(imgGroup, img.data)
        end
    end

    return true
end

M.yListener = function(e)
    handlerTouch(e)

    local actImgGroup = e.target.parent.parent
    local imgGroup = actImgGroup.imgGroup
    local yScale = imgGroup.parent.parent.parent.sizeGroup.yScale
    local img = imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.py = imgGroup.y
    elseif e.phase == 'moved' and e.target.isFocus then
        imgGroup.y = e.target.py + (e.y - e.yStart) / yScale
        actImgGroup.y = imgGroup.y
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveMove(imgGroup, img.data)
        end
    end

    return true
end

M.xListener = function(e)
    handlerTouch(e)

    local actImgGroup = e.target.parent.parent
    local imgGroup = actImgGroup.imgGroup
    local xScale = imgGroup.parent.parent.parent.sizeGroup.xScale
    local img = imgGroup[1]

    if not ALERT then
        return true
    end

    if e.phase == 'began' then
        SET_FOCUS(e.target)
        e.target.px = imgGroup.x
    elseif e.phase == 'moved' and e.target.isFocus then
        imgGroup.x = e.target.px + (e.x - e.xStart) / xScale
        actImgGroup.x = imgGroup.x
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        if e.target.isFocus then
            NIL_FOCUS(e.target)
            M.model:saveMove(imgGroup, img.data)
        end
    end

    return true
end

M.mouseListener = function(e)
    local map = M.view:getMap()

    if (not M.model:getBool('eye')) or (not ALERT) then
        return
    end

    if e.type == 'scroll' and e.scrollY < 0 and P.localSize < 22 then
        map.sizeGroup.xScale = map.sizeGroup.xScale * P.size
        map.sizeGroup.yScale = map.sizeGroup.yScale * P.size
        P.localSize = P.localSize + P.size
    elseif e.type == 'scroll' and e.scrollY > 0 and P.localSize > -11 then
        map.sizeGroup.xScale = map.sizeGroup.xScale / P.size
        map.sizeGroup.yScale = map.sizeGroup.yScale / P.size
        P.localSize = P.localSize - P.size
    end
end

M.canvasListener = function(e)
    handlerTouch(e)

    local map = M.view:getMap()

    if (not M.model:getBool('eye')) or (not ALERT) then
        return
    end

    if #FINGERS_ARRAY == 2 then
        local x1, y1 = FINGERS_ARRAY[1].x, FINGERS_ARRAY[1].y
        local x2, y2 = FINGERS_ARRAY[2].x, FINGERS_ARRAY[2].y
        local distance = math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)

        if e.phase == 'began' then
            P.distance = distance
        elseif e.phase == 'moved' then
            if distance < P.distance and math.abs(distance - P.distance) > 2 and P.localSize > -11*4 then
                map.sizeGroup.xScale = map.sizeGroup.xScale / P.size
                map.sizeGroup.yScale = map.sizeGroup.yScale / P.size
                P.localSize = P.localSize - P.size
            elseif distance > P.distance and math.abs(distance - P.distance) > 2 and P.localSize < 22*4 then
                map.sizeGroup.xScale = map.sizeGroup.xScale * P.size
                map.sizeGroup.yScale = map.sizeGroup.yScale * P.size
                P.localSize = P.localSize + P.size
            end

            P.distanceMove = true
            P.distance = distance
        end

        return true
    end

    if P.distanceMove and #FINGERS_ARRAY == 0 then
        P.distanceMove = false
    end

    if P.distanceMove then
        return true
    end

    if e.phase == 'began' then
        P.x = map.x
        P.y = map.y
    elseif e.phase == 'moved' then
        map.x = P.x + (e.x - e.xStart) / map.sizeGroup.xScale
        map.y = P.y + (e.y - e.yStart) / map.sizeGroup.yScale
    end

    return true
end

M.addObjectInLevel = function(name, isPixel)
    M.model:addObjectInLevel(name, isPixel, function(obj)
        M.view:newImage(obj)
    end)
end

M.addTextInLevel = function(name, text)
    M.model:addTextInLevel(name, text, function(obj)
        M.view:newText(obj)
    end)
end

M.addLevel = function(target, phase)
    M.view:animationButton(target, phase)

    if phase == 'ended' then
        M.view:openAddObjectWindow(M.model:getScene().params)
    end
end

M.saveLevel = function(target, phase)
    M.view:animationButton(target, phase)

    if phase == 'ended' then
        M.view:openSaveWindow(function(e)
            if e.index == 2 then
                M.model:save()
            end
        end)
    end
end

M.save = function()
    M.model:save()
end

local requestButtonClick = function(e)
    if M[e.target.id] and ALERT then
        M[e.target.id](e.target, e.phase)
    end
end

M.sidebarButtonsListener = function(e, scroll)
    if e.phase == 'began' then
        handlerTouch(e)
        SET_FOCUS(e.target)
        requestButtonClick(e)
    elseif e.phase == 'moved' and (math.abs(e.xDelta) > 30 or math.abs(e.yDelta) > 30) then
        handlerTouch({phase = 'ended', id = e.id})
        scroll:takeFocus(e)
        requestButtonClick(e)
    elseif e.phase == 'ended' or e.phase == 'cancelled' then
        handlerTouch(e)
        if e.target.isFocus then
            e.phase = 'ended'
            NIL_FOCUS(e.target)
            requestButtonClick(e)
        end
    end

    return true
end

M.buttonsListener = function(e)
    return BUTTONS_LISTENER(e, requestButtonClick)
end

M.getSprite = function(guid)
    return M.model:getSprite(guid)
end

M.getScene = function(guid)
    return M.model:getScene(guid)
end

local function initListeners(listTypes)
    for _, opt in ipairs(listTypes) do
        local type = opt[1]
        local objType = opt[2]

        M[type .. 'Level'] = function(target, phase)
            M.view:animationButton(target, phase)

            if phase == 'ended' then
                local isBool = not M.model:getBool(type)

                M.model:setBool(isBool, type)
                M.view:setVisibleActionGroup(isBool, type, objType)
                M.view:setActiveButton(target, isBool)
            end
        end
    end
end

function M:constructor(view)
    M.view = view
    M.model = require('Core.Levels.model', true)
    M.model:init()

    initListeners(M.model:getListTypes())
end

return M
