return {
    new = function(listener)
        local completeImportProject = function(import)
            if import.done and import.done == 'ok' then
                local numApp = 1
                while true do
                    local file = io.open(DOC_DIR .. '/App' .. numApp .. '/game.json', 'r')
                    if file then
                        numApp = numApp + 1
                        io.close(file)
                    else
                        local link = 'App' .. numApp
                        GANIN.uncompress(DOC_DIR .. '/import.ccode', DOC_DIR .. '/' .. link, function()
                            local hash = READ_FILE(DOC_DIR .. '/' .. link .. '/hash.txt')
                            local data = READ_FILE(DOC_DIR .. '/' .. link .. '/game.json')
                            local current_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, data, '?.cc_ode'), 'cc.ode_?')
                            local data = JSON.decode(data) local title = data.title

                            if current_hash == hash then
                                LOCAL.apps[#LOCAL.apps + 1], data.link = link, link
                                LFS.mkdir(DOC_DIR .. '/' .. link .. '/Documents')
                                LFS.mkdir(DOC_DIR .. '/' .. link .. '/Temps')

                                NEW_DATA()
                                SET_GAME_SAVE(link, {})
                                SET_GAME_CODE(link, data)
                                PROGRAMS.new(title, link)

                                OS_REMOVE(DOC_DIR .. '/' .. link .. '/hash.txt')
                                OS_REMOVE(DOC_DIR .. '/import.ccode')
                                listener({isError = false})
                            else
                                OS_REMOVE(DOC_DIR .. '/' .. link, true)
                                OS_REMOVE(DOC_DIR .. '/import.ccode')
                                listener({isError = true, idError = 2})
                            end
                        end) break
                    end
                end
            else
                listener({isError = true, idError = 1})
            end
        end

        if system.getInfo 'environment' ~= 'simulator' then
            FILE.pickFile(DOC_DIR, completeImportProject, 'import.ccode', '', '*/*', nil, nil, nil)
        else
            completeImportProject({done = 'ok'})
        end
    end
}
