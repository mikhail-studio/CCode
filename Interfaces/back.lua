local M = {}

M.hide = function()
    M.group.isVisible = false
end

M.show = function()
    M.group.isVisible = true
end

M.front = function()
    M.group:toFront()
end

M.create = function()
    if not M.group then
        M.group = display.newGroup()

        local but_back = display.newRect(CENTER_X, MAX_Y + BOTTOM_HEIGHT / 2, DISPLAY_WIDTH, BOTTOM_HEIGHT)
            but_back.alpha = 0.005
        M.group:insert(but_back)

        local img_back = display.newImage('Sprites/back.png', CENTER_X, but_back.y - 5)
            img_back.alpha = 0.9
        M.group:insert(img_back)

        but_back:addEventListener('touch', function(e)
            if e.phase == 'began' then
                display.getCurrentStage():setFocus(e.target)
                e.target.click = true
                e.target.alpha = 0.05
            elseif e.phase == 'moved' and math.abs(e.yDelta) > 30 then
                display.getCurrentStage():setFocus(nil)
                e.target.click = false
                e.target.alpha = 0.005
            elseif e.phase == 'ended' or e.phase == 'cancelled' then
                display.getCurrentStage():setFocus(nil)
                e.target.alpha = 0.005
                if e.target.click then
                    e.target.click = false
                    Runtime:dispatchEvent({name = 'key', keyName = 'back', phase = 'up'})
                end
            end return true
        end)
    end
end

return M
