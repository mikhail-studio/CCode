GLOBAL = require 'Data.global'
MENU = require 'Interfaces.menu'

MENU.create()
MENU.group.isVisible = LOCAL.name_tester ~= '' or LIVE or system.getInfo('deviceID') == 'd5e815039ddf2736'

-- При смене языка удалять загруженную сцены выбора нового блока
-- Добавить настройку для оптимизации под экраны
-- Поставить == заместо = в редакторе выражений
-- Убрать удаление сцены выбора нового блока при выборе нового блока
-- Изменить блоки для пикселей (добавить непрозрачность)
-- В список выбора переменных/таблиц/функций вселился демон, изгнать его нахуй (logic-input 176)
-- Изменить блоки для пикселей, центрировать 0,0 пиксель
-- Также демон вселился в редактор выражений после добавления нового списка, тоже изгнать нахуй (list 81/139, listener 246)
-- Центрировать настройки (основные)
-- Изменить баг с одинаковой подсказкой в настройках (проекта)
-- При горизонтальной ориентации выбор цвета решает нахуяриться
-- Изменить текстовое поле для ввода текста в редакторе выражений на многострочное
-- Интегрировать блоки Дани, Семки и Терры в нужные категории
-- Ещё баг с изменением перевода для редактора выражений
-- Добавить https://google.com как ссылку по-умолчанию в WebView
-- Починить блок 'Вернуть значение' во вложенных блоках
-- Runtime error на Editor/test 18
-- Добавить блок 'Установить сид для рандома'
-- Runtime error от цвета_пикселя
-- Добавить экспоненту
-- Изменить систему повторяющихся блоков, просто добавив параметр для выбора типа экранного объекта для взаимодействия
-- Добавить физические Joint'ы
-- Создать универсальный CGame.apk

if system.getInfo 'environment' ~= 'simulator' and system.getInfo('deviceID') ~= 'd5e815039ddf2736' and not LIVE then
    network.request('https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1Cigzy-fFJywTnGpY1PLyWN3E67uZNSaE', 'GET', function(e)
        pcall(function()
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
