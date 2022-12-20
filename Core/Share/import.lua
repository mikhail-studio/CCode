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
                            local INFO, changeDataCustom = require 'Data.info', {}
                            local data, hash = GET_GAME_CODE(link), READ_FILE(DOC_DIR .. '/' .. link .. '/hash.txt')
                            local new_custom = JSON.decode(READ_FILE(DOC_DIR .. '/' .. link .. '/custom.json'))
                            local code, custom, dataCustom = JSON.encode3(data, {keyorder = KEYORDER}), GET_GAME_CUSTOM(), {}
                            local current_hash = CRYPTO.hmac(CRYPTO.sha256, CRYPTO.hmac(CRYPTO.md5, code, '?.cc_ode-'), '*cc.ode_?')

                            for index, block in pairs(new_custom) do
                                if tonumber(index) then
                                    local new_index = tostring(custom.len + 1)

                                    for i = 1, custom.len do
                                        if not custom[tostring(i)] then
                                            new_index = tostring(i) break
                                        end
                                    end

                                    if custom.len == 0 then
                                        custom.len = 1
                                        custom[new_index] = block
                                        custom[new_index][4] = os.time()
                                        dataCustom[index] = new_index
                                    else
                                        for _index, _block in pairs(custom) do
                                            if tonumber(_index) and _block[1] == block[1] then
                                                local t1 = JSON.encode3(_block[3], {keyorder = KEYORDER})
                                                local t2 = JSON.encode3(block[3], {keyorder = KEYORDER})

                                                if t1 == t2 then
                                                    if _block[4] < block[4] then
                                                        custom[_index] = COPY_TABLE(block)
                                                        custom[_index][4] = os.time()
                                                        dataCustom[index] = _index
                                                        changeDataCustom[_index] = true
                                                    end break
                                                end
                                            elseif tonumber(_index) == custom.len then
                                                custom.len = custom.len + 1
                                                custom[new_index] = block
                                                custom[new_index][4] = os.time()
                                                dataCustom[index] = new_index
                                            end
                                        end
                                    end
                                end
                            end

                            for _, index in ipairs(dataCustom) do
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
                                for j = 1, #data.scripts[i].params do
                                    local name = data.scripts[i].params[j].name
                                    if UTF8.sub(name, 1, 6) == 'custom' then
                                        local index = UTF8.sub(name, 7, UTF8.len(name))
                                        data.scripts[i].params[j].name = dataCustom[index] and 'custom' .. dataCustom[index] or name
                                    end
                                end
                            end

                            if current_hash == hash then
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


        FILE.pickFile(DOC_DIR, completeImportProject, 'import.ccode', '', (IS_SIM or IS_WIN) and 'ccode/*' or '*/*', nil, nil, nil)
    end
}
