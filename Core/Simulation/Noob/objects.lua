local EVENTS = require 'Core.Simulation.events'
local CALC = require 'Core.Simulation.calc'
local M = {}

M['newObjectNoob'] = EVENTS.BLOCKS['newObject']
M['setPosNoob'] = EVENTS.BLOCKS['setPos']
M['setPosXNoob'] = EVENTS.BLOCKS['setPosX']
M['setPosYNoob'] = EVENTS.BLOCKS['setPosY']
M['setWidthNoob'] = EVENTS.BLOCKS['setWidth']
M['setHeightNoob'] = EVENTS.BLOCKS['setHeight']
M['setSizeNoob'] = EVENTS.BLOCKS['setSize']
M['setRotationNoob'] = EVENTS.BLOCKS['setRotation']
M['setRotationToNoob'] = EVENTS.BLOCKS['setRotationTo']
M['setAlphaNoob'] = EVENTS.BLOCKS['setAlpha']
M['updPosXNoob'] = EVENTS.BLOCKS['updPosX']
M['updPosYNoob'] = EVENTS.BLOCKS['updPosY']
M['updSizeNoob'] = EVENTS.BLOCKS['updSize']
M['updRotationNoob'] = EVENTS.BLOCKS['updRotation']
M['updAlphaNoob'] = EVENTS.BLOCKS['updAlpha']
M['updWidthNoob'] = EVENTS.BLOCKS['updWidth']
M['updHeightNoob'] = EVENTS.BLOCKS['updHeight']

return M
