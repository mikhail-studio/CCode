return {
    new = function(link)
        local folders = {'Images', 'Sounds', 'Videos', 'Fonts'}
        local list_in = {'Export/game.json', 'Export/hash.txt', 'Export/list.json'}
        local list_out, name = {}, GET_GAME_CODE(link).title
        local data = READ_FILE(DOC_DIR .. '/' .. link .. '/game.json')
        local hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, data, '?.cc_ode'), 'cc.ode_?')

        LFS.mkdir(DOC_DIR .. '/Export')
        PROGRAMS.group[8]:setIsLocked(true, 'vertical')
        WINDOW.new(STR['export.start'], {}, function() PROGRAMS.group[8]:setIsLocked(false, 'vertical') end, 1)

        for i = 1, #folders do
            for file in LFS.dir(DOC_DIR .. '/' .. link .. '/' .. folders[i]) do
                if file ~= '.' and file ~= '..' then
                    list_out[#list_out + 1] = folders[i] .. '.' .. file
                    list_in[#list_in + 1] = 'Export/' .. folders[i] .. '.' .. file
                    OS_COPY(DOC_DIR .. '/' .. link .. '/' .. folders[i] .. '/' .. file, DOC_DIR .. '/Export/' .. folders[i] .. '.' .. file)
                end
            end
        end

        WRITE_FILE(DOC_DIR .. '/Export/hash.txt', hash)
        WRITE_FILE(DOC_DIR .. '/Export/game.json', data)
        WRITE_FILE(DOC_DIR .. '/Export/list.json', JSON.encode(list_out))

        if IS_IMAGE(link .. '/icon.png') then
            list_out[#list_out + 1] = 'icon.png'
            list_in[#list_in + 1] = 'Export/icon.png'
            OS_COPY(DOC_DIR .. '/' .. link .. '/icon.png', DOC_DIR .. '/Export/icon.png')
        end

        ZIP.compress({
            zipFile = name .. '.zip', srcFiles = list_in,
            zipBaseDir = system.DocumentsDirectory,
            srcBaseDir = system.DocumentsDirectory,
            listener = function(event)
                if system.getInfo 'environment' ~= 'simulator' then
                    EXPORT.export({
                        path = DOC_DIR .. '/' .. name .. '.zip', name = name .. '.ccode',
                        listener = function(event)
                            OS_REMOVE(DOC_DIR .. '/' .. name .. '.zip') WINDOW.remove()
                        end
                    }) OS_REMOVE(DOC_DIR .. '/Export', true)
                else
                    OS_REMOVE(DOC_DIR .. '/Export', true) WINDOW.remove()
                    OS_MOVE(DOC_DIR .. '/' .. name .. '.zip', DOC_DIR .. '/' .. name .. '.ccode')
                end
            end
        })
    end
}
