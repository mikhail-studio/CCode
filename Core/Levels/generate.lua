local M = {}
local P = {}

function P:createEnterButton(LevelPresenter, img, imgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.enterGroup = display.newGroup()
    imgGroup:insert(img.enterGroup)

    local actGroup = img.enterGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint = display.newCircle(actGroup,
        img.x, img.y, size / 10)
    actGroup.cPoint:setFillColor(0, 1, 0)

    actGroup.cPoint2 = display.newCircle(actGroup,
        img.x + 20, img.y, size / 10)
    actGroup.cPoint2:setFillColor(0, 1, 0)

    actGroup.cPoint3 = display.newCircle(actGroup,
        img.x - 20, img.y, size / 10)
    actGroup.cPoint3:setFillColor(0, 1, 0)

    actGroup.isVisible = false
    actGroup.type = 'enter'

    actGroup.cRect:addEventListener('touch', LevelPresenter.enterListener)
end

function P:createCloneButton(LevelPresenter, img, imgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.cloneGroup = display.newGroup()
    imgGroup:insert(img.cloneGroup)

    local actGroup = img.cloneGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint = display.newCircle(actGroup,
        img.x, img.y, size / 4)
    actGroup.cPoint:setFillColor(0, 0, 0, 0)
    actGroup.cPoint:setStrokeColor(0, 1, 0)
    actGroup.cPoint.strokeWidth = 8

    actGroup.isVisible = false
    actGroup.type = 'clone'

    actGroup.cRect:addEventListener('touch', LevelPresenter.cloneListener)
end

function P:createDeleteButton(LevelPresenter, img, imgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.deleteGroup = display.newGroup()
    imgGroup:insert(img.deleteGroup)

    local actGroup = img.deleteGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint45 = display.newRect(actGroup,
        img.x, img.y, size / 1.5, size / 8)
    actGroup.cPoint45:setFillColor(1, 0, 0)
    actGroup.cPoint45.rotation = 45

    actGroup.cPoint135 = display.newRect(actGroup,
        img.x, img.y, size / 1.5, size / 8)
    actGroup.cPoint135:setFillColor(1, 0, 0)
    actGroup.cPoint135.rotation = 135

    actGroup.isVisible = false
    actGroup.type = 'delete'

    actGroup.cRect:addEventListener('touch', LevelPresenter.deleteListener)
end

function P:createRotateCircle(LevelPresenter, img, imgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.rotateGroup = display.newGroup()
    imgGroup:insert(img.rotateGroup)

    local actGroup = img.rotateGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint = display.newRect(actGroup,
        img.x, img.y, size / 8, size / 8)
    actGroup.cPoint:setFillColor(0)

    actGroup.yLine = display.newRect(actGroup,
        img.x, img.y - size / 2, size / 6, sizeL)
    actGroup.yLine.anchorY = 1
    actGroup.yLine:setFillColor(0.5, 1, 0.5)

    actGroup.xLine = display.newRect(actGroup,
        img.x + size / 2, img.y, sizeL, size / 6)
    actGroup.xLine.anchorX = 0
    actGroup.xLine:setFillColor(1, 0.5, 0.5)

    actGroup.circle = display.newCircle(actGroup,
        img.x, img.y, sizeL + size / 2)
    actGroup.circle:setFillColor(0, 0, 0, 0)
    actGroup.circle:setStrokeColor(1)
    actGroup.circle.strokeWidth = size / 6

    actGroup.circle.hitbox = display.newCircle(actGroup,
        img.x, img.y, sizeL + size / 2)
    actGroup.circle.hitbox:setFillColor(0, 0, 0, 0)
    actGroup.circle.hitbox:setStrokeColor(0, 0, 0, 0.005)
    actGroup.circle.hitbox.strokeWidth = size

    actGroup.isVisible = false
    actGroup.type = 'rotate'

    actGroup.cRect:addEventListener('touch', LevelPresenter.cRectListener)
    actGroup.circle.hitbox:addEventListener('touch', LevelPresenter.cListener)
end

function P:createScaleArrow(LevelPresenter, img, imgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.scaleGroup = display.newGroup()
    imgGroup:insert(img.scaleGroup)

    local actGroup = img.scaleGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint = display.newRect(actGroup,
        img.x, img.y, size / 8, size / 8)
    actGroup.cPoint:setFillColor(0)

    actGroup.yLine = display.newGroup()
    actGroup:insert(actGroup.yLine)

    actGroup.yLine.line = display.newRect(actGroup.yLine,
        img.x, img.y - size / 2, size / 6, sizeL)
    actGroup.yLine.line.anchorY = 1
    actGroup.yLine.line:setFillColor(0.5, 1, 0.5)

    actGroup.yLine.polygon = display.newPolygon(actGroup.yLine,
        img.x, img.y - size / 2 - sizeL, {0, 0, 0, -80, 80, -80, 80, 0})
    actGroup.yLine.polygon.anchorY = 1
    actGroup.yLine.polygon:setFillColor(0.5, 1, 0.5)

    actGroup.xLine = display.newGroup()
    actGroup:insert(actGroup.xLine)

    actGroup.xLine.line = display.newRect(actGroup.xLine,
        img.x + size / 2, img.y, sizeL, size / 6)
    actGroup.xLine.line.anchorX = 0
    actGroup.xLine.line:setFillColor(1, 0.5, 0.5)

    actGroup.xLine.polygon = display.newPolygon(actGroup.xLine,
        img.x + size / 2 + sizeL, img.y, {0, 0, 0, -80, 80, -80, 80, 0})
    actGroup.xLine.polygon.anchorX = 0
    actGroup.xLine.polygon:setFillColor(1, 0.5, 0.5)

    actGroup.isVisible = false
    actGroup.type = 'scale'

    actGroup.cRect:addEventListener('touch', LevelPresenter.scaleListener)
    actGroup.yLine:addEventListener('touch', LevelPresenter.yScaleListener)
    actGroup.xLine:addEventListener('touch', LevelPresenter.xScaleListener)
end

function P:createMoveArrow(LevelPresenter, img, actImgGroup)
    local size = DISPLAY_WIDTH / 10
    local sizeL = DISPLAY_HEIGHT / 5

    img.moveGroup = display.newGroup()
    actImgGroup:insert(img.moveGroup)

    local actGroup = img.moveGroup

    actGroup.cRect = display.newRect(actGroup,
        img.x, img.y, size, size)

    actGroup.cPoint = display.newRect(actGroup,
        img.x, img.y, size / 8, size / 8)
    actGroup.cPoint:setFillColor(0)

    actGroup.yLine = display.newGroup()
    actGroup:insert(actGroup.yLine)

    actGroup.yLine.line = display.newRect(actGroup.yLine,
        img.x, img.y - size / 2, size / 6, sizeL)
    actGroup.yLine.line.anchorY = 1
    actGroup.yLine.line:setFillColor(0.5, 1, 0.5)

    actGroup.yLine.polygon = display.newPolygon(actGroup.yLine,
        img.x, img.y - size / 2 - sizeL, {0, 0, 40, -80, 80, 0})
    actGroup.yLine.polygon.anchorY = 1
    actGroup.yLine.polygon:setFillColor(0.5, 1, 0.5)

    actGroup.xLine = display.newGroup()
    actGroup:insert(actGroup.xLine)

    actGroup.xLine.line = display.newRect(actGroup.xLine,
        img.x + size / 2, img.y, sizeL, size / 6)
    actGroup.xLine.line.anchorX = 0
    actGroup.xLine.line:setFillColor(1, 0.5, 0.5)

    actGroup.xLine.polygon = display.newPolygon(actGroup.xLine,
        img.x + size / 2 + sizeL, img.y, {0, 0, 0, -80, 80, -40})
    actGroup.xLine.polygon.anchorX = 0
    actGroup.xLine.polygon:setFillColor(1, 0.5, 0.5)

    actGroup.isVisible = false
    actGroup.type = 'move'

    actGroup.cRect:addEventListener('touch', LevelPresenter.moveListener)
    actGroup.yLine:addEventListener('touch', LevelPresenter.yListener)
    actGroup.xLine:addEventListener('touch', LevelPresenter.xListener)
end

function P:createText(LevelPresenter, obj, isClone, index)
    local group = self.imagesGroup
    local group2 = self.arrowsAndButtonsGroup
    local text = obj.type[2]

    local layerGroup = display.newGroup()
    group:insert(layerGroup)

    local imgGroup = display.newGroup()
    layerGroup:insert(imgGroup)

    local actLayerGroup = display.newGroup()
    group2:insert(actLayerGroup)

    local actImgGroup = display.newGroup()
    actImgGroup.imgGroup = imgGroup
    imgGroup.actImgGroup = actImgGroup
    actLayerGroup:insert(actImgGroup)

    local img = display.newText(imgGroup, text, 0, 0, obj.font, obj.size)

    imgGroup.x = obj.x + CENTER_X
    imgGroup.y = CENTER_Y - obj.y
    actImgGroup.x = imgGroup.x
    actImgGroup.y = imgGroup.y

    img.rotation = obj.rotation
    img.index = index
    img.data = obj

    self:createMoveArrow(LevelPresenter, img, actImgGroup)
    self:createScaleArrow(LevelPresenter, img, actImgGroup)
    self:createRotateCircle(LevelPresenter, img, actImgGroup)
    self:createDeleteButton(LevelPresenter, img, actImgGroup)
    self:createCloneButton(LevelPresenter, img, actImgGroup)
    self:createEnterButton(LevelPresenter, img, actImgGroup)
    M:toFront()

    if isClone then
        img.cloneGroup.isVisible = true
    end

    -- img:addEventListener('touch', function() return true end)

    group[obj.name] = img
end

function P:createImage(LevelPresenter, obj, isClone, index)
    local group = self.imagesGroup
    local group2 = self.arrowsAndButtonsGroup
    local sprite = LevelPresenter.getSprite(obj.type[2])

    local layerGroup = display.newGroup()
    group:insert(layerGroup)

    local imgGroup = display.newGroup()
    layerGroup:insert(imgGroup)

    local actLayerGroup = display.newGroup()
    group2:insert(actLayerGroup)

    local actImgGroup = display.newGroup()
    actImgGroup.imgGroup = imgGroup
    imgGroup.actImgGroup = actImgGroup
    actLayerGroup:insert(actImgGroup)

    local img = display.newImage(imgGroup, sprite, system.DocumentsDirectory)

    imgGroup.x = obj.x + CENTER_X
    imgGroup.y = CENTER_Y - obj.y
    actImgGroup.x = imgGroup.x
    actImgGroup.y = imgGroup.y

    img.width = obj.width
    img.height = obj.height
    img.rotation = obj.rotation
    img.index = index
    img.data = obj

    self:createMoveArrow(LevelPresenter, img, actImgGroup)
    self:createScaleArrow(LevelPresenter, img, actImgGroup)
    self:createRotateCircle(LevelPresenter, img, actImgGroup)
    self:createDeleteButton(LevelPresenter, img, actImgGroup)
    self:createCloneButton(LevelPresenter, img, actImgGroup)
    self:createEnterButton(LevelPresenter, img, actImgGroup)
    M:toFront()

    if isClone then
        img.cloneGroup.isVisible = true
    end

    -- img:addEventListener('touch', function() return true end)

    group[obj.name] = img
end

function M:setVisibleActionGroup(isVisible, type, objType)
    if not P.imagesGroup then
        return
    end

    for i = 1, P.imagesGroup.numChildren do
        local child = P.imagesGroup[i][1][1]
        local moveGroup = child.moveGroup
        local scaleGroup = child.scaleGroup
        local rotateGroup = child.rotateGroup
        local deleteGroup = child.deleteGroup
        local cloneGroup = child.cloneGroup
        local enterGroup = child.enterGroup
        local checkObjType = objType == 'all' or child.data.type[1] == objType

        moveGroup.isVisible = false
        scaleGroup.isVisible = false
        rotateGroup.isVisible = false
        deleteGroup.isVisible = false
        cloneGroup.isVisible = false
        enterGroup.isVisible = false

        if type == 'move' then
            moveGroup.isVisible = isVisible
        elseif type == 'scale' and checkObjType then
            scaleGroup.isVisible = isVisible
        elseif type == 'rotate' then
            rotateGroup.isVisible = isVisible
        elseif type == 'delete' then
            deleteGroup.isVisible = isVisible
        elseif type == 'clone' then
            cloneGroup.isVisible = isVisible
        elseif checkObjType and not (type == 'eye') then
            enterGroup.isVisible = isVisible
        end
    end
end

function M:createLevel(LevelPresenter, guid)
    local map = self:getMap()
    local level = LevelPresenter.getScene(guid)
    local objs = level.params

    self.LevelPresenter = LevelPresenter

    P.imagesGroup = display.newGroup()
    P.arrowsAndButtonsGroup = display.newGroup()

    map:insert(P.imagesGroup)
    map:insert(P.arrowsAndButtonsGroup)

    for index, obj in ipairs(objs) do
        if obj.type[1] == 'image' then
            P:createImage(LevelPresenter, obj, nil, index)
        elseif obj.type[1] == 'text' then
            P:createText(LevelPresenter, obj, nil, index)
        end
    end
end

function M:updLayer(startLayer)
    for layer = startLayer + 1, P.imagesGroup.numChildren do
        P.imagesGroup[layer][1][1].index = layer - 1
    end
end

function M:setLayer(newLayer, img)
    local oldLayer = img.index
    local imgGroup = img.parent
    local actImgGroup = imgGroup.actImgGroup

    P.imagesGroup[newLayer]:insert(imgGroup)
    P.arrowsAndButtonsGroup[newLayer]:insert(actImgGroup)
    img.index = newLayer

    if newLayer < oldLayer then
        for layer = newLayer, oldLayer - 1 do
            local imgGroup = P.imagesGroup[layer][1]
            local actImgGroup = P.arrowsAndButtonsGroup[layer][1]
            P.imagesGroup[layer + 1]:insert(imgGroup)
            P.arrowsAndButtonsGroup[layer + 1]:insert(actImgGroup)
            imgGroup[1].index = layer + 1
        end
    else
        for layer = newLayer, oldLayer + 1, -1 do
            local imgGroup = P.imagesGroup[layer][1]
            local actImgGroup = P.arrowsAndButtonsGroup[layer][1]
            P.imagesGroup[layer - 1]:insert(imgGroup)
            P.arrowsAndButtonsGroup[layer - 1]:insert(actImgGroup)
            imgGroup[1].index = layer - 1
        end
    end
end

function M:cloneImage(obj)
    if not obj then return end
    P:createImage(self.LevelPresenter, obj, true, P.imagesGroup.numChildren + 1)
end

function M:newImage(obj)
    if not obj then return end
    P:createImage(self.LevelPresenter, obj, nil, P.imagesGroup.numChildren + 1)
end

function M:cloneText(obj)
    if not obj then return end
    P:createText(self.LevelPresenter, obj, true, P.imagesGroup.numChildren + 1)
end

function M:newText(obj)
    if not obj then return end
    P:createText(self.LevelPresenter, obj, nil, P.imagesGroup.numChildren + 1)
end

function M:updateImage(img)
    if not img then return end
    local imgGroup = img.parent
    local actImgGroup = imgGroup.actImgGroup
    local obj = img.data

    imgGroup.x = obj.x + CENTER_X
    imgGroup.y = CENTER_Y - obj.y
    actImgGroup.x = imgGroup.x
    actImgGroup.y = imgGroup.y

    if obj.type[1] == 'image' then
        img.width = obj.width
        img.height = obj.height
        img.rotation = obj.rotation
    elseif obj.type[1] == 'text' then
        img.size = obj.size
        img.text = obj.type[2]
        img.rotation = obj.rotation
    end
end

return M
