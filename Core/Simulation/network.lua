local CALC = require 'Core.Simulation.calc'
local M = {}

M['createServer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.stops, SERVER.createServer('
    GAME.lua = GAME.lua .. CALC(params[1], '22222') .. ', ' .. CALC(params[2], 'a', true) .. ')) end)'
end

M['connectToServer'] = function(params)
    GAME.lua = GAME.lua .. ' pcall(function() table.insert(GAME.group.stops, CLIENT.createClientLoop('
    GAME.lua = GAME.lua .. CALC(params[1], 'nil') .. ', ' .. CALC(params[2], '22222') .. ', ' .. CALC(params[3], 'a', true) .. ')) end)'
end

M['requestNetwork'] = function(params, method)
    local link, body, timeout = CALC(params[1]), CALC(params[2], '\'{}\''), CALC(params[7], '30')
    local headers, listener = CALC(params[3], '{}'), CALC(params[4], 'a', true)
    local progress = UTF8.match(CALC(params[5]), '%(select%[\'(.+)\'%]') or 'nil'
    local progress = progress == 'progressDownload' and 'download' or progress == 'progressUpload' and 'upload' or 'nil'
    local redirect = UTF8.match(CALC(params[6]), '%(select%[\'(.+)\'%]') or 'nil'
    local redirect = redirect == 'redirectsFalse' and 'false' or 'true'

    GAME.lua = GAME.lua .. ' pcall(function() network.request(' .. link .. ', \'' .. method .. '\', ' .. listener .. ', {body'
    GAME.lua = GAME.lua .. ' = ' .. body .. ', headers = ' .. headers .. ', progress = ' .. progress .. ','
    GAME.lua = GAME.lua .. ' handleRedirects = ' .. redirect .. ', timeout = ' .. timeout .. '}) end)'
end

M['requestGET'] = function(params) M['requestNetwork'](params, 'GET') end
M['requestPOST'] = function(params) M['requestNetwork'](params, 'POST') end
M['requestPUT'] = function(params) M['requestNetwork'](params, 'PUT') end
M['requestPATCH'] = function(params) M['requestNetwork'](params, 'PATCH') end
M['requestHEAD'] = function(params) M['requestNetwork'](params, 'HEAD') end
M['requestDELETE'] = function(params) M['requestNetwork'](params, 'DELETE') end

M['openURL'] = function(params, method)
    GAME.lua = GAME.lua .. ' pcall(function() system.openURL(' .. CALC(params[1]) .. ')  end)'
end

return M
