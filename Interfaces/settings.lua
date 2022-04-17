local LISTENER = require 'Core.Interfaces.settings'
local M = {}

M.create = function()
    M.group = display.newGroup()
    M.group.isVisible = false

    local bg = display.newImage('Sprites/bg.png', CENTER_X, CENTER_Y)
        bg.width = CENTER_X == 640 and DISPLAY_HEIGHT or DISPLAY_WIDTH
        bg.height = CENTER_X == 640 and DISPLAY_WIDTH or DISPLAY_HEIGHT
        bg.rotation = CENTER_X == 640 and 90 or 0
    M.group:insert(bg)

    local title = display.newText(STR['menu.settings'], ZERO_X + 40, ZERO_Y + 30, 'ubuntu', 50)
        title.anchorX = 0
        title.anchorY = 0
    M.group:insert(title)

    local lang_text = display.newText(STR['settings.applang'], 20, title.y + 120, 'ubuntu', 30)
        lang_text.anchorX = 0
    M.group:insert(lang_text)

    local lang_button = display.newRect((lang_text.width + MAX_X) / 2 + 10, lang_text.y, MAX_X - lang_text.width - 100, 60)
        lang_button:setFillColor(0, 0, 0, 0.005)
        lang_button.text = display.newText(STR['lang.' .. LOCAL.lang], lang_button.x, lang_button.y, 'ubuntu', 30)
    M.group:insert(lang_button)
    M.group:insert(lang_button.text)

    local confirm_text = display.newText(STR['settings.confirmdelete'], 20, lang_text.y + 70, 'ubuntu', 30)
        confirm_text.anchorX = 0
    M.group:insert(confirm_text)

    local confirm_button = display.newRect((confirm_text.width + MAX_X) / 2 + 10, confirm_text.y, MAX_X - confirm_text.width - 100, 60)
        confirm_button:setFillColor(0, 0, 0, 0.005)
        confirm_button.text = display.newText('', confirm_button.x, confirm_button.y, 'ubuntu', 30)
        confirm_button.text.text = LOCAL.confirm and STR['button.yes'] or STR['button.no']
    M.group:insert(confirm_button)
    M.group:insert(confirm_button.text)

    local show_ads_text = display.newText(STR['settings.showads'], 20, confirm_button.y + 70, 'ubuntu', 30)
        show_ads_text.anchorX = 0
    M.group:insert(show_ads_text)

    local show_ads_button = display.newRect((show_ads_text.width + MAX_X) / 2 + 10, show_ads_text.y, MAX_X - show_ads_text.width - 100, 60)
        show_ads_button:setFillColor(0, 0, 0, 0.005)
        show_ads_button.text = display.newText('', show_ads_button.x, show_ads_button.y, 'ubuntu', 30)
        show_ads_button.text.text = LOCAL.show_ads and STR['button.yes'] or STR['button.no']
    M.group:insert(show_ads_button)
    M.group:insert(show_ads_button.text)

    local pos_top_ads_text = display.newText(STR['settings.posads'], 20, show_ads_button.y + 70, 'ubuntu', 30)
        pos_top_ads_text.anchorX = 0
    M.group:insert(pos_top_ads_text)

    local pos_top_ads_button = display.newRect((pos_top_ads_text.width + MAX_X) / 2 + 10, pos_top_ads_text.y, MAX_X - pos_top_ads_text.width - 100, 60)
        pos_top_ads_button:setFillColor(0, 0, 0, 0.005)
        pos_top_ads_button.text = display.newText('', pos_top_ads_button.x, pos_top_ads_button.y, 'ubuntu', 30)
        pos_top_ads_button.text.text = LOCAL.pos_top_ads and STR['settings.topads'] or STR['settings.bottomads']
    M.group:insert(pos_top_ads_button)
    M.group:insert(pos_top_ads_button.text)

    local orientation_text = display.newText(STR['settings.orientation'], 20, pos_top_ads_button.y + 120, 'ubuntu', 30)
        orientation_text.anchorX = 0
    M.group:insert(orientation_text)

    local orientation_group = display.newGroup()
        orientation_group.x = MAX_X - 150
        orientation_group.y = orientation_text.y
        orientation_group.rotation = LOCAL.orientation == 'portrait' and 90 or 0
    M.group:insert(orientation_group)

    local orientation_icon = display.newRoundedRect(0, 0, 58, 100, 6)
        orientation_icon:setFillColor(0.15, 0.15, 0.17)
        orientation_icon:setStrokeColor(1)
        orientation_icon.strokeWidth = 3
        orientation_icon.rotation = 90
    orientation_group:insert(orientation_icon)

    local orientation_icon_left = display.newRect(0, 15 - orientation_icon.height / 2, 30, 1.5)
        orientation_icon_left:setFillColor(1)
    orientation_group:insert(orientation_icon_left)

    local orientation_icon_right = display.newRect(0, orientation_icon.height / 2 - 15, 30, 1.5)
        orientation_icon_right:setFillColor(1)
    orientation_group:insert(orientation_icon_right)

    if CENTER_X == 360 then
        local splash = display.newImage('Sprites/splash.png', ZERO_X + 10, MAX_Y - 10)
            splash.width = splash.width / 4
            splash.height = splash.height / 4
            splash.anchorX, splash.anchorY = 0, 1
        M.group:insert(splash)
    end

    lang_button:addEventListener('touch', function(e) LISTENER(e, 'lang') end)
    confirm_button:addEventListener('touch', function(e) LISTENER(e, 'confirm') end)
    show_ads_button:addEventListener('touch', function(e) LISTENER(e, 'show') end)
    pos_top_ads_button:addEventListener('touch', function(e) LISTENER(e, 'pos') end)
    orientation_group:addEventListener('touch', function(e) LISTENER(e, 'orientation') end)
end

return M
