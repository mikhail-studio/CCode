local listeners = {}

listeners.but_myprogram = function(target)
    MENU.group.isVisible = false
    PROGRAMS = require 'Interfaces.programs'
    PROGRAMS.create()
    PROGRAMS.group.isVisible = true
end

function _supportOldestVersion(data, link)
    if tonumber(data.build) < 1215 then
        local scripts = COPY_TABLE(data.scripts)
        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Scripts')

        for i = 1, #scripts do
            data.scripts[i] = i
            SET_GAME_SCRIPT(link, scripts[i], i, data)
        end

        SET_GAME_CODE(link, data)
    end

    local script = GET_GAME_SCRIPT(link, 1, data)

    if tonumber(data.build) > 1232 and tonumber(data.build) < 1244 then
        for i = 1, #data.scripts do
            local script, nestedInfo, isChange = GET_FULL_DATA(GET_GAME_SCRIPT(link, i, data))

            if tonumber(data.build) < 1244 then
                script.comment = false
                isChange = true
            end

            if tonumber(data.build) < 1242 then
                for j = 1, #script.params do
                    local name = script.params[j].name

                    if name == 'readFileRes' then
                        script.params[j].params[1], script.params[j].params[2] = script.params[j].params[2], script.params[j].params[1]
                        script.params[j].params[3], isChange = {{'inputDefault', 'sl'}}, true
                    end
                end
            end

            if isChange then SET_GAME_SCRIPT(link, GET_NESTED_DATA(script, nestedInfo, INFO), i, data) end
        end
    end

    if not data.resources.others then
        data.resources.others = {}
        data.id = DEVICE_ID

        if not data.created then
            data.created = '1223'
            data.noobmode = false
        end

        SET_GAME_CODE(link, data)
    end

    if script and script.custom then
        DEL_GAME_SCRIPT(link, 1, data)
        table.remove(data.scripts, 1)
        SET_GAME_CODE(link, data)
    end

    if tonumber(data.build) < BUILD then
        data.build = tostring(BUILD)
        SET_GAME_CODE(link, data)
    end
end

listeners.but_continue = function(target)
    if LOCAL.last == '' then
        MENU.group.isVisible = false
        PROGRAMS = require 'Interfaces.programs'
        PROGRAMS.create()
        PROGRAMS.group.isVisible = true
    else
        local data = GET_GAME_CODE(LOCAL.last_link)

        if tonumber(data.build) > 1170 then
            _supportOldestVersion(data, LOCAL.last_link)

            MENU.group.isVisible = false
            PROGRAMS = require 'Interfaces.programs'
            PROGRAMS.create()
            CURRENT_LINK = LOCAL.last_link

            PROGRAMS.group.isVisible = false
            PROGRAM = require 'Interfaces.program'
            PROGRAM.create(LOCAL.last, data.noobmode)
            PROGRAM.group.isVisible = true
        end
    end
end

listeners.but_settings = function(target)
    MENU.group.isVisible = false
    SETTINGS = require 'Interfaces.settings'
    SETTINGS.create()
    SETTINGS.group.isVisible = true
end

listeners.but_social = function(target)
    system.openURL('https://discord.gg/7eYnvAgXdX')
end

listeners.but_dogs = function(target)
    MENU.group.isVisible = false
    ROBODOG = require 'Interfaces.robodog'
    ROBODOG.create()
    ROBODOG.group.isVisible = true
end

return function(e)
    if MENU.group.isVisible and ALERT then
        if e.phase == 'began' then
            display.getCurrentStage():setFocus(e.target)
            e.target.click = true
            if e.target.button == 'but_social'
            then e.target.alpha = 0.7
            else e.target.alpha = 0.6 end
        elseif e.phase == 'moved' and (math.abs(e.x - e.xStart) > 30 or math.abs(e.y - e.yStart) > 30) then
            e.target.click = false
            if e.target.button == 'but_social'
            then e.target.alpha = 1
            else e.target.alpha = 0.9 end
        elseif e.phase == 'ended' or e.phase == 'cancelled' then
            display.getCurrentStage():setFocus(nil)
            if e.target.click then
                e.target.click = false
                if e.target.button == 'but_social'
                then e.target.alpha = 1
                else e.target.alpha = 0.9 end
                listeners[e.target.button](e.target)
            end
        end
        return true
    end
end
