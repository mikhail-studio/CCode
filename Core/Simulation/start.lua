local WINDOW = require 'Core.Modules.interface-window'
local EVENTS = require 'Core.Simulation.events'
local M = {}

local function getStartLua(linkBuild)
    local funs1 = ' local fun, device = require \'Core.Functions.fun\', require \'Core.Functions.device\''
    local funs2 = ' local other, select = require \'Core.Functions.other\', require \'Core.Functions.select\''
    local funs3 = ' local math, prop = require \'Core.Functions.math\', require \'Core.Functions.prop\''
    local code1 = ' GAME.orientation = CURRENT_ORIENTATION display.setDefault(\'background\', 0)'
    local code2 = ' GAME.group = display.newGroup() GAME.group.texts = {} GAME.group.objects = {} GAME.group.webviews = {}'
    local code3 = ' GAME.group.groups = {} GAME.group.masks = {} GAME.group.bitmaps = {}'
    local code4 = ' GAME.group.sliders = {} GAME.group.animations = {} GAME.group.fields = {}'
    local code5 = ' GAME.group.const = {touch = false, touch_x = 360, touch_y = 640} device.start()'
    local code6 = ' GAME.group.const.touch_fun = function(e) GAME.group.const.touch = e.phase ~= \'ended\' and e.phase ~= \'cancelled\''
    local code7 = ' GAME.group.const.touch_x, GAME.group.const.touch_y = e.x, e.y return true end'
    local code8 = ' Runtime:addEventListener(\'touch\', GAME.group.const.touch_fun) PHYSICS.start()'

    if linkBuild then
        return 'pcall(function() local varsP, tablesP, funsP = {}, {}, {}'
            .. require 'Data.build' .. code1 .. code2 .. code3 .. code4 .. code5 .. code6 .. code7 .. code8
    else
        return 'pcall(function() local varsP, tablesP, funsP = {}, {}, {}'
            .. funs1 .. funs2 .. funs3 .. code1 .. code2 .. code3 .. code4 .. code5 .. code6 .. code7 .. code8
    end
end

M.remove = function()
    display.setDefault('background', 0.15, 0.15, 0.17) timer.cancelAll()
    pcall(function() Runtime:removeEventListener('touch', M.group.const.touch_fun) end)
    pcall(function() MAIN:removeSelf() MAIN = display.newGroup() end)
    pcall(function() PHYSICS.start() PHYSICS.setDrawMode('normal') PHYSICS.setGravity(0, 9.8) PHYSICS.stop() end)
    pcall(function() for _,v in pairs(M.group.bitmaps) do v:releaseSelf() end end)
    pcall(function() M.group:removeSelf() M.group = nil end) RESOURCES = nil math.randomseed(os.time())
    if CURRENT_ORIENTATION ~= M.orientation then setOrientationApp({type = M.orientation, sim = true}) end
end

M.new = function(linkBuild)
    M.lua = getStartLua(linkBuild)
    M.group = display.newGroup()
    M.orientation = CURRENT_ORIENTATION
    M.data = GET_FULL_DATA(GET_GAME_CODE(linkBuild or CURRENT_LINK))
    M.lua = M.lua .. ' GAME.RESOURCES = JSON.decode(\'' .. UTF8.gsub(JSON.encode(M.data.resources), '\n', '') .. '\')'

    if M.data.settings.orientation == 'portrait' and CURRENT_ORIENTATION ~= 'portrait' then
        M.lua = M.lua .. ' setOrientationApp({type = \'portrait\', sim = true})'
    elseif M.data.settings.orientation == 'landscape' and (linkBuild or CURRENT_ORIENTATION ~= 'landscape') then
        M.lua = M.lua .. ' setOrientationApp({type = \'landscape\', sim = true})'
    end

    local onStartCount = 0
    local nestedIndex = 0
    local nestedEvent = {}
    local nestedScript = {}
    local dataEvent = {}
    local eventComment = false

    for i = 1, #M.data.scripts do
        for j = 1, #M.data.scripts[i].params do
            if M.data.scripts[i].params[j].event then
                eventComment = M.data.scripts[i].params[j].comment
                if not eventComment then
                    nestedIndex = nestedIndex + 1
                    nestedEvent[nestedIndex] = {}
                    dataEvent[nestedIndex] = {
                        script = i,
                        name = M.data.scripts[i].params[j].name,
                        params = M.data.scripts[i].params[j].params,
                        comment = M.data.scripts[i].params[j].comment
                    }
                end
            elseif not M.data.scripts[i].params[j].comment and not eventComment then
                table.insert(nestedEvent[nestedIndex], M.data.scripts[i].params[j])
            end
        end
    end

    for i = 1, #nestedEvent do
        if not nestedScript[dataEvent[i].script] then
            if #nestedScript > 0 then M.lua = M.lua .. ' end end script()' end
            M.lua = M.lua .. ' local function script() local varsS, tablesS, funsS = {}, {}, {}'
            nestedScript[dataEvent[i].script] = true

            for j = i, #nestedEvent do
                local isFunBlock = dataEvent[j].name == 'onFun' or dataEvent[j].name == 'onFunParams'
                or dataEvent[j].name == 'onTouchBegan' or dataEvent[j].name == 'onTouchEnded' or dataEvent[j].name == 'onTouchMoved'
                local isFunProject = dataEvent[j].params[1][1] and dataEvent[j].params[1][1][2] == 'fP'
                local isFunScript = dataEvent[j].params[1][1] and dataEvent[j].params[1][1][2] == 'fS'

                if nestedScript[dataEvent[j].script] and not dataEvent[j].comment and isFunBlock and (isFunScript or isFunProject) then
                    pcall(function() EVENTS[dataEvent[j].name](nestedEvent[j], dataEvent[j].params) end)
                end
            end

            onStartCount = onStartCount + 1
            M.lua = M.lua .. ' function onStart' .. onStartCount .. '()'
        end

        if not dataEvent[i].comment and dataEvent[i].name ~= 'onFun' and dataEvent[i].name ~= 'onFunParams'
        and dataEvent[i].name ~= 'onTouchBegan' and dataEvent[i].name ~= 'onTouchEnded' and dataEvent[i].name ~= 'onTouchMoved' then
            pcall(function() EVENTS[dataEvent[i].name](nestedEvent[i], dataEvent[i].params) end)
        end
    end M.lua = M.lua .. ' end end script()'

    for i = 1, onStartCount do
        M.lua = M.lua .. ' onStart' .. i .. '()'
    end M.lua = M.lua .. ' end) GAME.isStarted = true'

    if linkBuild then
        M.remove()
        return M.lua
    else
        pcall(function()
            print(M.lua)
            loadstring(M.lua)()
        end)
    end
end

return M
