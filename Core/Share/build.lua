return {
    new = function(link)
        GAME = require 'Core.Simulation.start'
        CURRENT_LINK = 'App'
        LFS.mkdir(DOC_DIR .. '/Build')

        PROGRAMS.group[8]:setIsLocked(true, 'vertical')
        WINDOW.new(STR['build.start'], {}, function() PROGRAMS.group[8]:setIsLocked(false, 'vertical') end, 1)

        local folders = {'Images', 'Sounds', 'Videos', 'Fonts'}
        local icons = {'mipmap-hdpi-v4', 'mipmap-mdpi-v4', 'mipmap-xhdpi-v4', 'mipmap-xxhdpi-v4', 'mipmap-xxxhdpi-v4'}
        local list_in, list_out = {'game.lua', 'list.json'}, {}

        for i = 1, #folders do
            for file in LFS.dir(DOC_DIR .. '/' .. link .. '/' .. folders[i]) do
                if file ~= '.' and file ~= '..' then
                    list_out[#list_out + 1] = folders[i] .. '.' .. file
                    list_in[#list_in + 1] = 'Build/' .. folders[i] .. '.' .. file
                    OS_COPY(DOC_DIR .. '/' .. link .. '/' .. folders[i] .. '/' .. file, DOC_DIR .. '/Build/' .. folders[i] .. '.' .. file)
                end
            end
        end

        WRITE_FILE(DOC_DIR .. '/game.lua', GAME.new(link))
        WRITE_FILE(DOC_DIR .. '/list.json', JSON.encode(list_out))

        local title = GAME.data.title
        local build = GAME.data.settings.build
        local version = GAME.data.settings.version
        local package = GAME.data.settings.package

        GAME = nil
        ZIP.compress({
            zipFile = 'game.cc', srcFiles = list_in,
            zipBaseDir = system.DocumentsDirectory,
            srcBaseDir = system.DocumentsDirectory,
            password = 'cc.ode_?-?.cc_ode', -- CRYPTO.hmac(CRYPTO.md5, 'cc.ode_?', '?.cc_ode') .. CRYPTO.digest(CRYPTO.md5, '_c.?code'),
            listener = function(event)
                if not event.isError then
                    OS_REMOVE(DOC_DIR .. '/game.lua')
                    OS_REMOVE(DOC_DIR .. '/list.json')
                    OS_REMOVE(DOC_DIR .. '/Build', true)
                    OS_MOVE(DOC_DIR .. '/game.cc', MY_PATH .. '/assets/Emitter/game.cc')

                    for i = 1, #icons do
                        OS_COPY(DOC_DIR .. '/' .. link .. '/icon.png', MY_PATH .. '/res/' .. icons[i] .. '/ic_launcher.png')
                        OS_COPY(DOC_DIR .. '/' .. link .. '/icon.png', MY_PATH .. '/res/' .. icons[i] .. '/ic_launcher_foreground.png')
                    end

                    GANIN.build(MY_PATH, package, title, build, version)
                end
            end
        })
    end,

    reset = function()
        LFS.mkdir(MY_PATH)
        LFS.mkdir(MY_PATH .. '/res')
        LFS.mkdir(MY_PATH .. '/assets')
        LFS.mkdir(MY_PATH .. '/assets/Emitter')
        LFS.mkdir(MY_PATH .. '/res/mipmap-hdpi-v4')
        LFS.mkdir(MY_PATH .. '/res/mipmap-mdpi-v4')
        LFS.mkdir(MY_PATH .. '/res/mipmap-xhdpi-v4')
        LFS.mkdir(MY_PATH .. '/res/mipmap-xxhdpi-v4')
        LFS.mkdir(MY_PATH .. '/res/mipmap-xxxhdpi-v4')
    end
}
