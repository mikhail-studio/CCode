display.setStatusBar(display.HiddenStatusBar)
display.setStatusBar(display.TranslucentStatusBar)
display.setStatusBar(display.HiddenStatusBar)

READ_FILE = function(path, bin)
    local file, data = io.open(path or '', bin and 'rb' or 'r'), nil

    if file then
        data = file:read('*a')
        io.close(file)
    end

    return data
end

data_require = {}
_require, require = require, function(package)
    local link = package:gsub('%.', '/') .. '.nse'
    local data if package:find('%.') or package == 'starter' then data = READ_FILE(system.pathForFile(link)) end

    if data_require[package] then
        return data_require[package]
    elseif data then
        data_require[package] = loadstring(data)()
        return data_require[package]
    else
        return _require(package)
    end
end

timer.performWithDelay(system.getInfo 'environment' == 'simulator' and 0 or 100, function()
    display.setStatusBar(display.HiddenStatusBar)
    display.setStatusBar(display.TranslucentStatusBar)
    display.setStatusBar(display.HiddenStatusBar)

    GLOBAL = require 'Data.global'
    MENU = require 'Interfaces.menu'
    ROBODOG = require 'Interfaces.robodog'

    LFS.mkdir(RES_PATH .. '/Core/Editor')
    LFS.mkdir(RES_PATH .. '/Core/Functions')
    LFS.mkdir(RES_PATH .. '/Core/Interfaces')
    LFS.mkdir(RES_PATH .. '/Core/Modules')
    LFS.mkdir(RES_PATH .. '/Core/Share')
    LFS.mkdir(RES_PATH .. '/Core/Simulation')

    if not LIVE and (system.getInfo('deviceID') == 'ad086e7885c038ac78cc320bee71fdab' or not IS_SIM) then
        require 'starter'
    else
        MENU.create()
        MENU.group.isVisible = true
    end
end)
