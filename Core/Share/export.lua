return {
    new = function(link)
        local name = GET_GAME_CODE(link).title
        local data = READ_FILE(DOC_DIR .. '/' .. link .. '/game.json')
        local hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, data, '?.cc_ode'), 'cc.ode_?')

        PROGRAMS.group[8]:setIsLocked(true, 'vertical')
        WINDOW.new(STR['export.start'], {}, function() PROGRAMS.group[8]:setIsLocked(false, 'vertical') end, 1)

        WRITE_FILE(DOC_DIR .. '/' .. link .. '/hash.txt', hash)
        WRITE_FILE(DOC_DIR .. '/' .. link .. '/game.json', data)

        if system.getInfo 'environment' ~= 'simulator' then
            GANIN.compress(DOC_DIR .. '/' .. link, DOC_DIR .. '/export.zip', 'cc.ode_?-?.cc_ode', function()
                EXPORT.export({
                    path = DOC_DIR .. '/export.zip', name = name .. '.ccode',
                    listener = function(event)
                        OS_REMOVE(DOC_DIR .. '/' .. link .. '/hash.txt')
                        OS_REMOVE(DOC_DIR .. '/export.zip') WINDOW.remove()
                    end
                })
            end)
        end
    end
}
