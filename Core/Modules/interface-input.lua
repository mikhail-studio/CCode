local M = {}

M.new = function(title, textListener, inputListener, oldText, textCheckbox)
    if not M.group then
        ALERT = false
        M.listener = inputListener
        M.timer = timer.performWithDelay(0, function() M.group:toFront() end, 0)
        M.group = display.newGroup()

        M.bg = display.newRoundedRect(CENTER_X, CENTER_Y - (textCheckbox and 75 or 100), DISPLAY_WIDTH - 100, textCheckbox and 150 or 100, 20)
            M.bg:setFillColor(0.2, 0.2, 0.22)
        M.group:insert(M.bg)

        M.box = native.newTextField(5000, CENTER_Y - 110, DISPLAY_WIDTH - 150, system.getInfo 'environment' ~= 'simulator' and 36 or 72)
            timer.performWithDelay(0, function()
                if not ALERT then
                    M.box.x = CENTER_X
                    M.box.isEditable = true
                    M.box.hasBackground = false
                    M.box.placeholder = title
                    M.box.font = native.newFont('ubuntu.ttf', 36)
                    M.box.text = type(oldText) == 'string' and oldText or ''

                    if system.getInfo 'platform' == 'android' and system.getInfo 'environment' ~= 'simulator' then
                        M.box:setTextColor(0.9)
                    else
                        M.box:setTextColor(0.1)
                    end
                end
            end) M.box:addEventListener('userInput', textListener) M.box:setSelection(UTF8.len(M.box.text))
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
