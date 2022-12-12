local M = {}

M.resize = function()
    pcall(function()
        if M.count > 5 then M.count = 5 end
        M.bg.height = M.bg._height + 44 * M.count
        M.box.height = not IS_SIM and 36 + 44 * M.count or 72 + 44 * M.count
        M.line.y = CENTER_Y - 75 + 22 * M.count
        M.buttonOK.y = (M.bg.y + M.bg.height / 2 + M.line.y) / 2 + 2
        M.text.y = M.buttonOK.y
    end)
end

M.new = function(title, textListener, inputListener, oldText, textCheckbox, isTextEditor)
    if not M.group then
        ALERT = false
        M.listener = inputListener
        M.timer = timer.performWithDelay(0, function() M.group:toFront() end, 0)
        M.group, M.count = display.newGroup(), 0

        local isAddHeight = textCheckbox or isTextEditor

        M.bg = display.newRoundedRect(CENTER_X, CENTER_Y - (isAddHeight and 75 or 100), DISPLAY_WIDTH - 100, isAddHeight and 150 or 100, 20)
            M.bg:setFillColor(0.2, 0.2, 0.22)
            M.bg._height = M.bg.height
        M.group:insert(M.bg)

        if isTextEditor then
            M.box = native.newTextBox(5000, CENTER_Y - 110, DISPLAY_WIDTH - 150, not IS_SIM and 36 or 72)
        else
            M.box = native.newTextField(5000, CENTER_Y - 110, DISPLAY_WIDTH - 150, not IS_SIM and 36 or 72)
        end

        timer.performWithDelay(0, function()
            if not ALERT then
                M.box.x = CENTER_X
                M.box.isEditable = true
                M.box.hasBackground = false
                M.box.placeholder = title
                M.box.font = native.newFont('ubuntu.ttf', 36)
                M.box.text = type(oldText) == 'string' and oldText or ''

                if system.getInfo 'platform' == 'android' and not IS_SIM then
                    M.box:setTextColor(0.9)
                else
                    M.box:setTextColor(0.1)
                end
            end
        end)

        M.box:addEventListener('userInput', textListener)
        M.box:setSelection(UTF8.len(M.box.text))
        M.group:insert(M.box)

        M.line = display.newRect(M.group, CENTER_X, CENTER_Y - 75, DISPLAY_WIDTH - 150, 2)
        M.group:insert(M.line)

        if textCheckbox then
            M.checkbox = WIDGET.newSwitch({
                    x = M.line.x - M.line.width / 2 + 35, y = (M.bg.y + M.bg.height / 2 + M.line.y) / 2,
                    style = 'checkbox', width = 70, height = 70
                })
            M.group:insert(M.checkbox)

            M.text = display.newText(textCheckbox, M.checkbox.x + 35, M.checkbox.y - 1, 'ubuntu', 28)
                M.text.anchorX = 0
            M.group:insert(M.text)
        elseif isTextEditor then
            M.buttonOK = display.newRoundedRect(M.line.x + M.line.width / 2 - 50, (M.bg.y + M.bg.height / 2 + M.line.y) / 2 + 2, 100, 60, 10)
                M.text = display.newText(M.group, STR['button.okay'], M.buttonOK.x, M.buttonOK.y, 'ubuntu', 28)
                M.buttonOK.alpha = 0.005
            M.group:insert(M.buttonOK)

            M.buttonOK:addEventListener('touch', function(e)
                if e.phase == 'began' then
                    display.getCurrentStage():setFocus(e.target)
                    e.target.click = true
                    e.target.alpha = 0.1
                elseif e.phase == 'moved' and (math.abs(e.xDelta) > 30 or math.abs(e.yDelta) > 30) then
                    display.getCurrentStage():setFocus(nil)
                    e.target.click = false
                    e.target.alpha = 0.005
                elseif e.phase == 'ended' or e.phase == 'cancelled' then
                    display.getCurrentStage():setFocus(nil)
                    e.target.alpha = 0.005
                    if e.target.click then
                        e.target.click = false
                        M.remove(true, M.box.text)
                    end
                end

                return true
            end)
        end

        local text = oldText
        local count = 0

        while text do
            local isStroke = UTF8.find(text, '\n')
            if not isStroke then break end
            text = UTF8.sub(text, isStroke + 1)
            count = count + 1
        end

        if count ~= INPUT.count then
            INPUT.count = count
            INPUT.resize()
        end

        EXITS.add(M.remove, false)
    end
end

M.remove = function(input, text)
    if M and M.group then
        ALERT = true
        native.setKeyboardFocus(nil)
        M.listener({input = input, text = text, checkbox = M.checkbox and M.checkbox.isOn})
        timer.cancel(M.timer)
        M.group:removeSelf()
        M.group = nil
    end
end

return M
