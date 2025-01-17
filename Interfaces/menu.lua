local M = {}

M.create = function()
    M.group = display.newGroup()
    M.group.isVisible = false

    local bg = display.newImage(THEMES.menu(), CENTER_X, CENTER_Y)
        bg.width = CENTER_X == 640 + 0 and DISPLAY_HEIGHT or DISPLAY_WIDTH
        bg.height = CENTER_X == 640 + 0 and DISPLAY_WIDTH or DISPLAY_HEIGHT
        bg.rotation = CENTER_X == 640 + 0 and 90 or 0
    M.group:insert(bg)

    local title = display.newText('CCode', CENTER_X, ZERO_Y + 182 - 50, 'ubuntu', 70)
        title:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(title)

    local testers = display.newText('', CENTER_X, title.y + 75, 'ubuntu', 30)
        if DEVELOPERS[LOCAL.name_tester] then
            testers.text = STR['menu.developers'] .. '  ' .. LOCAL.name_tester
        elseif LOCAL.name_tester ~= '' then
            testers.text = STR['menu.testers'] .. '  ' .. LOCAL.name_tester
        end testers:setFillColor(unpack(LOCAL.themes.text))
        testers.isVisible = false
    M.group:insert(testers)

    local but_tg = display.newImage('Sprites/tg.png', CENTER_X - DISPLAY_WIDTH / 4, title.y + 175)
        but_tg.width = 300
        but_tg.button = 'but_tg'
        but_tg:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_tg)

    local but_ad = display.newImage('Sprites/ad.png', CENTER_X + DISPLAY_WIDTH / 4, title.y + 175)
        but_ad.width = 300
        but_ad.button = 'but_ad'
        but_ad:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_ad)

    local but_social = display.newImage(THEMES.discord(), ZERO_X + 60, MAX_Y - 50)
        but_social.width = 70
        but_social.height = 52
        but_social.button = 'but_social'
        but_social:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_social)

    local but_myprogram = display.newImage(THEMES.menubut(), CENTER_X, title.y + 500 + 100, 396, 138)
        but_myprogram.alpha = 0.9
        but_myprogram.button = 'but_myprogram'
        but_myprogram:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_myprogram)

    local text_myprogram = display.newText({
            text = STR['menu.myprogram'],
            x = CENTER_X, y = but_myprogram.y,
            font = 'ubuntu', fontSize = 42,
            width = but_myprogram.width - 10, height = but_myprogram.height / 2.7,
            align = 'center'
        }) text_myprogram:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(text_myprogram)

    local delimiter1 = display.newRect(CENTER_X, title.y + 400 + 100, 300, 5)
        delimiter1:setFillColor(unpack(LOCAL.themes.strokeColor))
    M.group:insert(delimiter1)

    local but_continue = display.newImage(THEMES.menubut(), CENTER_X, title.y + 300 + 100, 396, 138)
        but_continue.alpha = 0.9
        but_continue.button = 'but_continue'
        but_continue:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_continue)

    local text_continue = display.newText({
            text = (LOCAL.last and LOCAL.last ~= '') and LOCAL.last or STR['menu.continue'],
            x = CENTER_X, y = but_continue.y,
            font = 'ubuntu', fontSize = 42,
            width = but_myprogram.width - 10, height = but_myprogram.height / 2.7,
            align = 'center'
        }) text_continue:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(text_continue)

    local delimiter2 = display.newRect(CENTER_X, title.y + 600 + 100, 300, 5)
        delimiter2:setFillColor(unpack(LOCAL.themes.strokeColor))
    M.group:insert(delimiter2)

    local but_settings = display.newImage(THEMES.menubut(), CENTER_X, title.y + 900 + 100, 396, 138)
        but_settings.alpha = 0.9
        but_settings.button = 'but_settings'
        but_settings:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_settings)

    local text_settings = display.newText({
            text = STR['menu.settings'],
            x = CENTER_X, y = but_settings.y,
            font = 'ubuntu', fontSize = 42,
            width = but_myprogram.width - 10, height = but_myprogram.height / 2.7,
            align = 'center'
        }) text_settings:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(text_settings)

    local build = display.newText('Build: ' .. BUILD, MAX_X - 100, MAX_Y - 40, 'sans', 27)
        build:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(build)

    local delimiter3 = display.newRect(CENTER_X, title.y + 800 + 100, 300, 5)
        delimiter3:setFillColor(unpack(LOCAL.themes.strokeColor))
    M.group:insert(delimiter3)

    local but_dogs = display.newImage(THEMES.menubut(), CENTER_X, title.y + 700 + 100, 396, 138)
        but_dogs.alpha = 0.9
        but_dogs.button = 'but_dogs'
        but_dogs:addEventListener('touch', require 'Core.Interfaces.menu')
    M.group:insert(but_dogs)

    local text_dogs = display.newText({
            text = STR['menu.dogs'],
            x = CENTER_X, y = but_dogs.y,
            font = 'ubuntu', fontSize = 42,
            width = but_myprogram.width - 10, height = but_myprogram.height / 2.7,
            align = 'center'
        }) text_dogs:setFillColor(unpack(LOCAL.themes.text))
    M.group:insert(text_dogs)

    -- local snowflakes = display.newImage('Sprites/snowflakes.png', CENTER_X, CENTER_Y)
    --     snowflakes.alpha = 0.6
    --     snowflakes.width = DISPLAY_HEIGHT > DISPLAY_WIDTH and DISPLAY_HEIGHT or DISPLAY_WIDTH
    --     snowflakes.height = DISPLAY_HEIGHT > DISPLAY_WIDTH and DISPLAY_HEIGHT or DISPLAY_WIDTH
    -- M.group:insert(snowflakes)
    --
    -- local hat = display.newImage('Sprites/hat.png', title.x - title.width / 2 + 20, title.y - title.height + 30)
    --     hat.alpha = 0.9
    --     hat.height = hat.height / 5
    --     hat.width = hat.width / 5
    -- M.group:insert(hat)

    -- snowflakes:toBack()
    -- bg:toBack()

    if CENTER_X == 640 + 0 then
        title.y = ZERO_Y + 82 + 220
        title.x = CENTER_X - 350
        but_tg.y = MAX_Y - but_tg.height / 2 - 50
        but_tg.x = CENTER_X - 550
        but_ad.y = MAX_Y - but_ad.height / 2 - 50
        but_ad.x = CENTER_X - 150
        but_social.y = ZERO_Y + 45
        but_social.x = ZERO_X + 47
        build.x, build.y = MAX_X - 100, MAX_Y - 40
        testers.y, testers.x = title.y + 75, title.x
        but_continue.y = title.y + 50 - 200
        but_continue.x = CENTER_X + but_continue.width - 100
        text_continue.y = but_continue.y
        text_continue.x = but_continue.x
        delimiter1.y = title.y + 150 - 200
        delimiter1.x = but_continue.x
        but_myprogram.y = title.y + 250 - 200
        but_myprogram.x = CENTER_X + but_myprogram.width - 100
        text_myprogram.y = but_myprogram.y
        text_myprogram.x = but_myprogram.x
        delimiter2.y = title.y + 350 - 200
        delimiter2.x = but_myprogram.x
        but_settings.y = title.y + 450 - 200
        but_settings.x = CENTER_X + but_settings.width - 100
        text_settings.y = but_settings.y
        text_settings.x = but_settings.x
        -- hat.x = title.x - title.width / 2 + 20
        -- hat.y = title.y - title.height + 30
    end
end

return M
