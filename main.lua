GLOBAL = require 'Data.global'
MENU = require 'Interfaces.menu'

MENU.create() 
MENU.group.isVisible = true

if system.getInfo('deviceID') == 'ad086e7885c038ac78cc320bee71fdab' then require 'starter' end
