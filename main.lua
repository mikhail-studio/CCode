ARGS = ...
DOC_DIR = system.pathForFile('', system.DocumentsDirectory)

display.setStatusBar(display.HiddenStatusBar)
display.setStatusBar(display.TranslucentStatusBar)
display.setStatusBar(display.HiddenStatusBar)

table.insert(package.loaders, 2, function(modulename)
    local path = (DOC_DIR .. '/Live/' .. modulename):gsub('%.', '/') .. '.lua'
    local file = io.open(path, 'r')

    if file then
        local data = tostring(file:read('*a'))
        io.close(file) return assert(loadstring(data, modulename))
    end
end)

original_require = require
require = function(module, isSingle)
    if isSingle then package.loaded[module] = nil end
    return original_require(module)
end

timer.performWithDelay(system.getInfo 'environment' == 'simulator' and 0 or 100, function()
    display.setStatusBar(display.HiddenStatusBar)
    display.setStatusBar(display.TranslucentStatusBar)
    display.setStatusBar(display.HiddenStatusBar)

    GLOBAL = require 'Data.global'
    MENU = require 'Interfaces.menu'
    ROBODOG = require 'Interfaces.robodog'

    if (not LIVE) and (system.getInfo('deviceID') == 'ad086e7885c038ac78cc320bee71fdab' or not IS_SIM) then
        require 'starter'
    else
        MENU.create()
        MENU.group.isVisible = true
    end
end)
