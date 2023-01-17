local function export(name, link)
    GIVE_PERMISSION_DATA()
    EXPORT.export({
        path = DOC_DIR .. '/export.zip', name = name .. '.ccode',
        listener = function(event)
            OS_REMOVE(DOC_DIR .. '/' .. link .. '/hash.txt')
            OS_REMOVE(DOC_DIR .. '/' .. link .. '/custom.json')
            OS_REMOVE(DOC_DIR .. '/export.zip') WINDOW.remove()
        end
    })
end

return {
    new = function(link)
        local data, dataCustom, custom = GET_GAME_CODE(link), {}, GET_GAME_CUSTOM()
        local name, code = data.title, JSON.encode3(data, {keyorder = KEYORDER})
        local hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, code, '?.cc_ode-123%'), '%^()*cc.ode_?')

        for i = 1, #data.scripts do
            local script = GET_GAME_SCRIPT(CURRENT_LINK, i, data)
            for j = 1, #script.params do
                local name = script.params[j].name
                local index = UTF8.sub(name, 7, UTF8.len(name))
                dataCustom[index] = UTF8.sub(name, 1, 6) == 'custom'

                if not dataCustom[index] then
                    for u = 1, #script.params[j].params do
                        for o = #script.params[j].params[u], 1, -1 do
                            if script.params[j].params[u][o][2] == 'fC' then
                                local name = script.params[j].params[u][o][1]
                                dataCustom[UTF8.sub(name, 7, UTF8.len(name))] = true
                            end
                        end
                    end
                end
            end
        end

        for index, block in pairs(custom) do
            if not dataCustom[index] and index ~= 'len' then
                custom[index] = nil
                custom.len = custom.len - 1
            end
        end

        PROGRAMS.group[8]:setIsLocked(true, 'vertical')
        WINDOW.new(STR['export.start'], {}, function() PROGRAMS.group[8]:setIsLocked(false, 'vertical') end, 1)

        WRITE_FILE(DOC_DIR .. '/' .. link .. '/hash.txt', hash)
        WRITE_FILE(DOC_DIR .. '/' .. link .. '/custom.json', JSON.encode3(custom, {keyorder = KEYORDER}))

        if IS_SIM or IS_WIN then
            OS_REMOVE(DOC_DIR .. '/' .. link .. '/hash.txt') OS_REMOVE(DOC_DIR .. '/' .. link .. '/custom.json') WINDOW.remove()
        else
            GANIN.compress(DOC_DIR .. '/' .. link, DOC_DIR .. '/export.zip', 'cc.ode_?-?.cc_ode', function() export(name, link) end)
        end
    end
}
