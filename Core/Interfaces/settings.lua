local LIST = require 'Core.Modules.interface-list'
local listeners = {}

listeners.title = function(target)
    EXITS.settings()
end

listeners.orientation = function(e)
    LOCAL.orientation = LOCAL.orientation == 'portrait' and 'landscape' or 'portrait'
    e.target.rotation = e.target.rotation + 90 NEW_DATA() native.requestExit()
end

listeners.pos = function(e)
    local list = LOCAL.pos_top_ads and {STR['settings.topads'], STR['settings.bottomads']} or {STR['settings.bottomads'], STR['settings.topads']}

    LIST.new(list, e.target.x, e.target.y - e.target.height / 2, 'down', function(e)
        if e.index > 0 then
            LOCAL.pos_top_ads = e.text == STR['settings.topads']

            SETTINGS.group:removeSelf()
            SETTINGS.group = nil
            SETTINGS.create() BACK.front()
            SETTINGS.group.isVisible = true

            NEW_DATA()
        end
    end, nil, nil, 0.5)
end

listeners.show = function(e)
    local list = LOCAL.show_ads and {STR['button.yes'], STR['button.no']} or {STR['button.no'], STR['button.yes']}

    LIST.new(list, e.target.x, e.target.y - e.target.height / 2, 'down', function(e)
        if e.index > 0 then
            LOCAL.show_ads = e.text == STR['button.yes']

            SETTINGS.group:removeSelf()
            SETTINGS.group = nil
            SETTINGS.create() BACK.front()
            SETTINGS.group.isVisible = true

            NEW_DATA()
        end
    end, nil, nil, 0.5)
end

listeners.confirm = function(e)
    local list = LOCAL.confirm and {STR['button.yes'], STR['button.no']} or {STR['button.no'], STR['button.yes']}

    LIST.new(list, e.target.x, e.target.y - e.target.height / 2, 'down', function(e)
        if e.index > 0 then
            LOCAL.confirm = e.text == STR['button.yes']

            SETTINGS.group:removeSelf()
            SETTINGS.group = nil
            SETTINGS.create() BACK.front()
            SETTINGS.group.isVisible = true

            NEW_DATA()
        end
    end, nil, nil, 0.5)
end

listeners.lang = function(e)
    local list = {{STR['lang.' .. LOCAL.lang]}, {LOCAL.lang}}

    for i = 1, #LANGS do
        if LOCAL.lang ~= LANGS[i] then
            list[1][#list[1] + 1] = STR['lang.' .. LANGS[i]]
            list[2][#list[2] + 1] = LANGS[i]
        end
    end

    LIST.new(list[1], e.target.x, e.target.y - e.target.height / 2, 'down', function(e)
        if e.index > 0 then
            LOCAL.lang = list[2][e.index]
            STR = LANG[LOCAL.lang]

            for k, v in pairs(LANG.ru) do
                if not STR[k] then
                    STR[k] = v
                end
            end

            MENU.group:removeSelf()
            MENU.group = nil
            MENU.create()

            pcall(function()
                NEW_BLOCK.remove()
            end)

            SETTINGS.group:removeSelf()
            SETTINGS.group = nil
            SETTINGS.create() BACK.front()
            SETTINGS.group.isVisible = true

            NEW_DATA()
        end
    end, nil, nil, 0.5)
end

return function(e, type)
    if ALERT then
        if e.phase == 'began' then
            display.getCurrentStage():setFocus(e.target)
            if type == 'title' then e.target.alpha = 0.6
            elseif type ~= 'orientation' then e.target:setFillColor(0.22, 0.22, 0.24) end
            e.target.click = true
        elseif e.phase == 'moved' and (math.abs(e.x - e.xStart) > 30 or math.abs(e.y - e.yStart) > 30) then
            display.getCurrentStage():setFocus(nil)
            if type == 'title' then e.target.alpha = 1
            elseif type ~= 'orientation' then e.target:setFillColor(0, 0, 0, 0.005) end
            e.target.click = false
        elseif e.phase == 'ended' or e.phase == 'cancelled' then
            display.getCurrentStage():setFocus(nil)
            if type == 'title' then e.target.alpha = 1
            elseif type ~= 'orientation' then e.target:setFillColor(0, 0, 0, 0.005) end
            if e.target.click then
                e.target.click = false
                listeners[type](e)
            end
        end
    end

    return true
end
