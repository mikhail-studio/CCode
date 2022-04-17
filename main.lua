GLOBAL = require 'Data.global'
MENU = require 'Interfaces.menu'

MENU.create()
MENU.group.isVisible = LOCAL.name_tester ~= ''

if system.getInfo 'environment' ~= 'simulator' then
    network.request('https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1Cigzy-fFJywTnGpY1PLyWN3E67uZNSaE', 'GET', function(e)
        if e.phase == 'ended' and not e.isError then
            local response = JSON.decode(e.response)
            local name = response[system.getInfo('deviceID')]
            local version = response.version
            local link = response.link

            if LOCAL.name_tester == '' and name then
                MENU.group.isVisible = name
                LOCAL.name_tester = name
                NEW_DATA()
            end

            if LOCAL.name_tester == '' then
                local PASTEBOARD, id = require 'plugin.pasteboard', system.getInfo('deviceID')
                if system.getInfo 'environment' ~= 'simulator' then PASTEBOARD.copy('string', tostring(id)) end
                display.newText('DeviceID скопирован в буфер обмена\nЕсли этого не произошло\nТо вот: ' .. id, CENTER_X, CENTER_Y, 'ubuntu', 30)
                display.newImage('Sprites/amogus.png', ZERO_X + 75, ZERO_Y + 75)
            elseif version > BUILD then
                WINDOW.new(STR['menu.version.new'], {STR['button.close'], STR['button.download']}, function(event)
                    timer.performWithDelay(1, function()
                        WINDOW.new(STR['menu.version.wait'], {}, function(event)
                            EXPORT.export({
                                path = DOC_DIR .. '/tester.apk', name = 'CCode.apk',
                                listener = function(event)
                                    OS_REMOVE(DOC_DIR .. '/tester.apk')
                                    native.requestExit()
                                end
                            })
                        end, 3)
                    end)

                    network.download(link, 'GET', function(e)
                        if e.phase == 'ended' and e.isError then
                            system.openURL(link)
                            native.requestExit()
                        elseif e.phase == 'ended' then
                            WINDOW.remove()
                        end
                    end, 'tester.apk', system.DocumentsDirectory)
                end, 2)
            end
        end
    end)
elseif system.getInfo 'environment' == 'simulator' and true then
    MENU.group.isVisible = false
    PROGRAMS = require 'Interfaces.programs'
    PROGRAMS.create()
    -- PROGRAMS.group.isVisible = true

    PROGRAM = require 'Interfaces.program'
    PROGRAM.create('App')
    -- PROGRAM.group.isVisible = true

    -- PSETTINGS = require 'Interfaces.program-settings'
    -- PSETTINGS.create()
    -- PSETTINGS.group.isVisible = true

    SCRIPTS = require 'Interfaces.scripts'
    SCRIPTS.create()
    -- SCRIPTS.group.isVisible = true

    -- IMAGES = require 'Interfaces.images'
    -- IMAGES.create()
    -- IMAGES.group.isVisible = true

    CURRENT_SCRIPT = 1
    BLOCKS = require 'Interfaces.blocks'
    BLOCKS.create()
    BLOCKS.group.isVisible = true

    -- SETTINGS = require 'Interfaces.settings'
    -- SETTINGS.create()
    -- SETTINGS.group.isVisible = true

    -- EDITOR = require 'Core.Editor.interface'
    -- EDITOR.create('newText', 3, {{'hello world', 't'}}, 2)

    -- NEW_BLOCK = require 'Interfaces.new-block'
    -- NEW_BLOCK.create()
end
