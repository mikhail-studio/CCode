local data, custom = {}, {}
local file = io.open(system.pathForFile('local.json', system.DocumentsDirectory), 'r')

if file then
    data = JSON.decode(file:read('*a')) io.close(file)
    if data.autoplace == nil then data.autoplace = true end
    if data.keystore == nil then data.keystore = {'testkey'} end data.back = 'System'
    WRITE_FILE(system.pathForFile('local.json', system.DocumentsDirectory), JSON.encode(data))
else
    data, custom = {
        lang = system.getPreference('locale', 'language'),
        last = '',
        last_link = '',
        orientation = 'portrait',
        back = 'System',
        keystore = {'testkey'},
        autoplace = true,
        show_ads = true,
        pos_top_ads = true,
        confirm = true,
        first = true,
        ui = true,
        apps = {},
        repository = {},
        name_tester = ''
    }, {len = 0}

    SET_GAME_CUSTOM(custom)
    WRITE_FILE(system.pathForFile('local.json', system.DocumentsDirectory), JSON.encode(data))
end

return data
