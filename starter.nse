if IS_SIM then
    if true then
        MENU.create()
        MENU.group.isVisible = false

        PROGRAMS = require 'Interfaces.programs'
        PROGRAMS.create()
        -- PROGRAMS.group.isVisible = true

        local data = GET_GAME_CODE(CURRENT_LINK)
        local script = GET_GAME_SCRIPT(CURRENT_LINK, 1, data)

        PROGRAM = require 'Interfaces.program'
        PROGRAM.create('Test', data.noobmode)
        -- PROGRAM.group.isVisible = true

        -- PSETTINGS = require 'Interfaces.program-settings'
        -- PSETTINGS.create()
        -- PSETTINGS.group.isVisible = true

        if script and script.custom then
            DEL_GAME_SCRIPT(CURRENT_LINK, 1, data)
            table.remove(data.scripts, 1)
            SET_GAME_CODE(CURRENT_LINK, data)
        end

        SCRIPTS = require 'Interfaces.scripts'
        SCRIPTS.create()
        -- SCRIPTS.group.isVisible = true

        -- IMAGES = require 'Interfaces.images'
        -- IMAGES.create()
        -- IMAGES.group.isVisible = true

        -- RESOURCES = require 'Interfaces.resources'
        -- RESOURCES.create()
        -- RESOURCES.group.isVisible = true

        CURRENT_SCRIPT = 1
        BLOCKS = require 'Interfaces.blocks'
        BLOCKS.create()
        BLOCKS.group.isVisible = true

        -- SETTINGS = require 'Interfaces.settings'
        -- SETTINGS.create()
        -- SETTINGS.group.isVisible = true

        -- ROBODOG = require 'Interfaces.robodog'
        -- ROBODOG.create()
        -- ROBODOG.group.isVisible = true

        -- EDITOR = require 'Core.Editor.interface'
        -- EDITOR.create('newText', 3, {}, 1)

        -- NEW_BLOCK = require 'Interfaces.new-block'
        -- NEW_BLOCK.create()

        -- NEW_BLOCK.group.types[15].scroll.isVisible = true
        -- NEW_BLOCK.group.types[1].scroll.isVisible = false
        -- NEW_BLOCK.group[4].isVisible = false
        -- for i = 5, 10 do NEW_BLOCK.group[i].isVisible = true end
        -- for i = 19, 20 do NEW_BLOCK.group[i].isVisible = true end
        -- NEW_BLOCK.group.currentIndex = 15

        -- local CUSTOM_BLOCK = require('Core.Modules.custom-block')
        --     CUSTOM_BLOCK.newBlock('Поставить для текста позицию Y', {
        --         {{'hello world', 't'}},
        --         {{'hello world', 't'}}
        --     }, {
        --         'Имя текста:', 'Позиция Y:'
        --     })
        -- timer.performWithDelay(0, function() CUSTOM_BLOCK.addBlock({}) end)
    end
end

local ccodeUpdate = function()
    network.request('https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1Cigzy-fFJywTnGpY1PLyWN3E67uZNSaE', 'GET', function(e)
        pcall(function()
            if e.phase == 'ended' and not e.isError then
                local response = JSON.decode(e.response)
                local name = response[DEVICE_ID]
                local lua_version = response.lua_version
                local version = response.version
                local link = response.link
                local url = response.url

                if LOCAL.name_tester == '' and name then
                    LOCAL.name_tester = name NEW_DATA()
                    if DEVELOPERS[name] then
                        MENU.group[3].text = STR['menu.developers'] .. '  ' .. name
                    elseif LOCAL.name_tester ~= '' then
                        MENU.group[3].text = STR['menu.testers'] .. '  ' .. name
                    end
                end

                -- if LOCAL.name_tester == '' then
                --     DEVICE_ID = CRYPTO.hmac(CRYPTO.sha256, system.getInfo('deviceID'), system.getInfo('deviceID') .. 'md5')
                --     if not IS_SIM then PASTEBOARD.copy('string', tostring(DEVICE_ID)) end
                --     display.newText('DeviceID скопирован в буфер обмена', CENTER_X, CENTER_Y, 'ubuntu', 30)
                --     display.newImage('Sprites/amogus.png', ZERO_X + 75, ZERO_Y + 75)
                -- end

                if lua_version > LUA_BUILD then
                    network.download(url, 'GET', function(e)
                        if e.phase == 'ended' and not e.isError then
                            GANIN.lua(DOC_DIR .. '/ccodus.zip', RES_PATH)
                            timer.performWithDelay(1000, function() data_require = {} end)
                        end
                    end, 'ccodus.zip', system.DocumentsDirectory)
                end

                if version > BUILD then
                    WINDOW.new(STR['menu.version.new'], {STR['button.download']}, function(event)
                        network.download(link, 'GET', function(e)
                            if e.isError then
                                system.openURL(link)
                                native.requestExit()
                            elseif e.phase == 'progress' then
                                local text = STR['menu.version.wait'] .. '\n' .. STR['menu.version.download'] .. ': '
                                local text = text .. math.round(e.bytesTransferred / 1048576, 2) .. 'mb / '
                                local text = text .. math.round(e.bytesEstimated / 1048576, 2) .. 'mb'
                                WINDOW.remove() WINDOW.new(text, {}, function() end, 3)
                            elseif e.phase == 'ended' then
                                WINDOW.remove()
                                EXPORT.export({
                                    path = DOC_DIR .. '/tester.apk', name = 'CCode b' .. version .. '.apk',
                                    listener = function(event)
                                        OS_REMOVE(DOC_DIR .. '/tester.apk')
                                        native.requestExit()
                                    end
                                })
                            end
                        end, {progress = true}, 'tester.apk', system.DocumentsDirectory)
                    end, 2)
                    WINDOW.buttons[1].x = WINDOW.bg.x + WINDOW.bg.width / 4 - 5
                    WINDOW.buttons[1].text.x = WINDOW.buttons[1].x
                end
            end
        end)
    end)
end

_CCODE_UPDATE = function()
    timer.performWithDelay(600000, function() ccodeUpdate() end, 0)
end

if not IS_SIM and not LIVE and true then
    local function testersListener()
        DEVICE_ID = CRYPTO.hmac(CRYPTO.sha256, system.getInfo('deviceID'), system.getInfo('deviceID') .. 'md5')
        MENU.create() MENU.group.isVisible = true

        if DEVICE_ID == '1d598b1d63aad048652a3256c6874b2ad4aa3bacbcb5d56b013eeeffa7ece8d2' then
            MENU.group.isVisible = false
        end

        if DEVICE_ID ~= '28703ca9a4eb27d54d50afa4d06e28a8bb64932f6917497550f91f8234e9546d' then
            _CCODE_UPDATE() ccodeUpdate()
        end
    end

    -- display.newImageRect('Sprites/nolik.png', DISPLAY_WIDTH, DISPLAY_HEIGHT):translate(CENTER_X, CENTER_Y)
    testersListener()
end
