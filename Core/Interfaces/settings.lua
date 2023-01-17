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

listeners.back = function(e)
    local list = LOCAL.back == 'System' and {STR['settings.backSystem'], STR['settings.backCCode'], STR['settings.backNo']}
    or LOCAL.back == 'CCode' and {STR['settings.backCCode'], STR['settings.backSystem'], STR['settings.backNo']}
    or {STR['settings.backNo'], STR['settings.backSystem'], STR['settings.backCCode']}

    LIST.new(list, e.target.x, e.target.y - e.target.height / 2, 'down', function(e)
        if e.index > 0 then
            LOCAL.back = LOCAL.back == 'System' and (e.index == 2 and 'CCode' or e.index == 3 and 'No' or 'System')
            or LOCAL.back == 'CCode' and (e.index == 2 and 'System' or e.index == 3 and 'No' or 'CCode')
            or (e.index == 2 and 'System' or e.index == 3 and 'CCode' or 'No')

            if LOCAL.back == 'System' then
                native.setProperty('androidSystemUiVisibility', 'default')
            else
                native.setProperty('androidSystemUiVisibility', 'immersiveSticky')
            end

            local _, _, bottom_height = display.getSafeAreaInsets()
            BOTTOM_HEIGHT = LOCAL.back == 'System' and bottom_height or LOCAL.back == 'CCode' and 100 or 0
            MAX_Y = CENTER_Y + DISPLAY_HEIGHT / 2 - BOTTOM_HEIGHT

            MENU.group:removeSelf()
            MENU.group = nil
            MENU.create()

            SETTINGS.group:removeSelf()
            SETTINGS.group = nil
            SETTINGS.create()
            SETTINGS.group.isVisible = true

            pcall(function() NEW_BLOCK.remove() end)
            NEW_DATA() BACK.create() BACK.front()
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
        local function changeLang()
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

        if e.text == STR['lang.custom'] then
            local completeImportLanguage = function(import)
                if import.done and import.done == 'ok' then
                    local langData = JSON.decode(READ_FILE(DOC_DIR .. '/lang.json'))

                    if langData then
                        for _, langT in pairs(langData) do
                            for key, str in pairs(langT) do
                                LANG['custom'][key] = str
                            end
                        end
                    end

                    OS_REMOVE(DOC_DIR .. '/lang.json') changeLang()
                end
            end

            GIVE_PERMISSION_DATA()
            FILE.pickFile(DOC_DIR, completeImportLanguage, 'lang.json', '', '*/*', nil, nil, nil)
        elseif e.index > 0 then
            changeLang()
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
