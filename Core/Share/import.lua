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
                            local changeDataCustom, data = {}, GET_GAME_CODE(link)
                            local hash = READ_FILE(DOC_DIR .. '/' .. link .. '/hash.txt')
                            local new_custom = JSON.decode(READ_FILE(DOC_DIR .. '/' .. link .. '/custom.json'))
                            local code, custom, dataCustom = JSON.encode3(data, {keyorder = KEYORDER}), GET_GAME_CUSTOM(), {}
                            local older_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, code, '?.cc_ode'), 'cc.ode_?')
                            local older2_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, code, '?.cc_ode-'), '*cc.ode_?')
                            local current_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, code, '?.cc_ode-123%'), '%^()*cc.ode_?')

                            if older_hash == hash or older2_hash == hash then
                                if tonumber(data.build) < 1215 then
                                    local scripts = COPY_TABLE(data.scripts) data.build = BUILD
                                    LFS.mkdir(DOC_DIR .. '/' .. link .. '/Scripts')

                                    for i = 1, #scripts do
                                        data.scripts[i] = i
                                        SET_GAME_SCRIPT(link, scripts[i], i, data)
                                    end
                                end current_hash = older_hash == hash and older_hash or older2_hash
                            end

                            if current_hash == hash then
                                for index, block in pairs(new_custom) do
                                    if tonumber(index) then
                                        local new_index, change_custom = tostring(custom.len + 1)

                                        for i = 1, custom.len do
                                            if not custom[tostring(i)] then
                                                new_index = tostring(i) break
                                            end
                                        end

                                        for _index, _block in pairs(custom) do
                                            if tonumber(_index) and _block[1] == block[1] then
                                                local t1, t2 = _block[3], block[3]

                                                if _G.type(_block[3]) == 'table' and _G.type(block[3]) == 'table' then
                                                    t1 = JSON.encode3(_block[3], {keyorder = KEYORDER})
                                                    t2 = JSON.encode3(block[3], {keyorder = KEYORDER})
                                                end

                                                if t1 == t2 then
                                                    if _block[4] < block[4] then
                                                        custom[_index] = COPY_TABLE(block)
                                                        custom[_index][4] = os.time()
                                                        dataCustom[index] = _index
                                                        changeDataCustom[_index] = false
                                                    end change_custom = true break
                                                end
                                            end
                                        end

                                        if not change_custom then
                                            custom.len = custom.len + 1
                                            custom[new_index] = COPY_TABLE(block)
                                            custom[new_index][4] = os.time()
                                            dataCustom[index] = new_index
                                            changeDataCustom[new_index] = true
                                        end
                                    end
                                end

                                for _, index in pairs(dataCustom) do
                                    local block = custom[index]
                                    local typeBlock = 'custom' .. index
                                    local blockParams = {} for i = 1, #block[2] do blockParams[i] = 'value' end

                                    STR['blocks.' .. typeBlock] = block[1]
                                    STR['blocks.' .. typeBlock .. '.params'] = block[2]
                                    LANG.ru['blocks.' .. typeBlock] = block[1]
                                    LANG.ru['blocks.' .. typeBlock .. '.params'] = block[2]
                                    INFO.listName[typeBlock] = {'custom', unpack(blockParams)}

                                    if changeDataCustom[index] then
                                        table.insert(INFO.listBlock.custom, 1, typeBlock)
                                        table.insert(INFO.listBlock.everyone, typeBlock)
                                    end
                                end

                                for i = 1, #data.scripts do
                                    local script, isChange = GET_GAME_SCRIPT(link, i, data)
                                    for j = 1, #script.params do
                                        local name = script.params[j].name

                                        if UTF8.sub(name, 1, 6) == 'custom' then
                                            local index = UTF8.sub(name, 7, UTF8.len(name)) isChange = true
                                            script.params[j].name = 'custom' .. dataCustom[index]
                                        end

                                        for u = 1, #script.params[j].params do
                                            for o = #script.params[j].params[u], 1, -1 do
                                                if script.params[j].params[u][o][2] == 'fC' then
                                                    local name = script.params[j].params[u][o][1]
                                                    local index = UTF8.sub(name, 7, UTF8.len(name)) isChange = true
                                                    script.params[j].params[u][o][1] = 'custom' .. dataCustom[index]
                                                end
                                            end
                                        end
                                    end if isChange then SET_GAME_SCRIPT(link, script, i, data) end
                                end

                                LOCAL.apps[#LOCAL.apps + 1], data.link = link, link
                                LFS.mkdir(DOC_DIR .. '/' .. link .. '/Documents')
                                LFS.mkdir(DOC_DIR .. '/' .. link .. '/Temps')

                                NEW_DATA()
                                SET_GAME_CUSTOM(custom)
                                SET_GAME_SAVE(link, {})
                                SET_GAME_CODE(link, data)
                                PROGRAMS.new(data.title, link)

                                OS_REMOVE(DOC_DIR .. '/' .. link .. '/hash.txt')
                                OS_REMOVE(DOC_DIR .. '/' .. link .. '/custom.json')
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


        GIVE_PERMISSION_DATA()
        FILE.pickFile(DOC_DIR, completeImportProject, 'import.ccode', '', (IS_SIM or IS_WIN) and 'ccode/*' or '*/*', nil, nil, nil)
    end
}
