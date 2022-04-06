return {
    new = function(listener)
        local completeImportProject = function(import)
            if import.done and import.done == 'ok' then
                ZIP.uncompress({
                    zipFile = 'import.ccode', files = {'list.json', 'game.json', 'hash.txt'},
                    zipBaseDir = system.DocumentsDirectory,
                    dstBaseDir = system.DocumentsDirectory,
                    listener = function(event)
                        if not event.isError then
                            local list = JSON.decode(READ_FILE(DOC_DIR .. '/list.json'))
                            local data = READ_FILE(DOC_DIR .. '/game.json')
                            local hash = READ_FILE(DOC_DIR .. '/hash.txt')
                            local hash_data, data = data, JSON.decode(data)
                            local folders, title = 'Images Sounds Videos Fonts', data.title
                            local current_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, hash_data, '?.cc_ode'), 'cc.ode_?')

                            if current_hash == hash then
                                local numApp = 1
                                while true do
                                    local file = io.open(DOC_DIR .. '/App' .. numApp .. '/game.json', 'r')
                                    if file then
                                        numApp = numApp + 1
                                        io.close(file)
                                    else
                                        local link = 'App' .. numApp
                                        LOCAL.apps[#LOCAL.apps + 1], data.link = link, link
                                        LFS.mkdir(DOC_DIR .. '/' .. link)
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Documents')
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Temps')
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Images')
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Sounds')
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Videos')
                                        LFS.mkdir(DOC_DIR .. '/' .. link .. '/Fonts')

                                        ZIP.uncompress({
                                            zipFile = 'import.ccode', files = list,
                                            zipBaseDir = system.DocumentsDirectory,
                                            dstBaseDir = system.DocumentsDirectory,
                                            listener = function(event)
                                                OS_REMOVE(DOC_DIR .. '/list.json')
                                                OS_REMOVE(DOC_DIR .. '/hash.txt')

                                                if not event.isError then
                                                    OS_MOVE(DOC_DIR .. '/game.json', DOC_DIR .. '/' .. link)
                                                    OS_MOVE(DOC_DIR .. '/icon.png', DOC_DIR .. '/' .. link)

                                                    for file in LFS.dir(DOC_DIR) do
                                                        local folder = UTF8.match(file, '(.*)%.') or 'nil'
                                                        local filename = UTF8.match(file, '%.(.*)') or 'nil'
                                                        local path = folder .. '/' .. filename

                                                        if UTF8.find(folders, folder) then
                                                            OS_MOVE(DOC_DIR .. '/' .. file, DOC_DIR .. '/' .. link .. '/' .. path)
                                                        end
                                                    end

                                                    NEW_DATA()
                                                    SET_GAME_SAVE(link, {})
                                                    SET_GAME_CODE(link, data)
                                                    PROGRAMS.new(title, link)
                                                    listener({isError = false})
                                                else
                                                    LOCAL.apps[#LOCAL.apps] = nil
                                                    OS_REMOVE(DOC_DIR .. '/game.json')
                                                    OS_REMOVE(DOC_DIR .. '/' .. link, true)
                                                    listener({isError = true, idError = 3})
                                                end
                                            end
                                        })

                                        break
                                    end
                                end
                            else
                                listener({isError = true, idError = 2})
                            end
                        else
                            listener({isError = true, idError = 1})
                        end
                    end
                })
            else
                listener({isError = false})
            end
        end

        if system.getInfo 'environment' ~= 'simulator' then
            FILE.pickFile(DOC_DIR, completeImportProject, 'import.ccode', '', '*/*', nil, nil, nil)
        else
            completeImportProject({done = 'ok'})
        end
    end
}
