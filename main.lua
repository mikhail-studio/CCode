GLOBAL = require 'Data.global'
MENU = require 'Interfaces.menu'

if system.getInfo('deviceID') == 'ad086e7885c038ac78cc320bee71fdab' or not IS_SIM then
    require 'starter'
else
    MENU.create()
    MENU.group.isVisible = true
end
