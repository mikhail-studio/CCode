local listeners = {}

listeners.but_play = function(target)
    if system.getInfo 'environment' ~= 'simulator' then ADMOB.hide() end
    GAME_GROUP_OPEN = PROGRAM
    PROGRAM.group.isVisible = false
    GAME = require 'Core.Simulation.start'
    GAME.new()
end

return function(e)
    if PROGRAM.group.isVisible and ALERT then
        if e.phase == 'began' then
            display.getCurrentStage():setFocus(e.target)
            e.target.click = true
            if e.target.button == 'but_list'
            then e.target.width, e.target.height = 52, 52
            else e.target.alpha = 0.6 end
        elseif e.phase == 'moved' and (math.abs(e.x - e.xStart) > 30 or math.abs(e.y - e.yStart) > 30) then
            e.target.click = false
            if e.target.button == 'but_list'
            then e.target.width, e.target.height = 60, 60
            else e.target.alpha = 0.9 end
        elseif e.phase == 'ended' or e.phase == 'cancelled' then
            display.getCurrentStage():setFocus(nil)
            if e.target.click then
                e.target.click = false
                if e.target.button == 'but_list'
                then e.target.width, e.target.height = 60, 60
                else e.target.alpha = 0.9 end
                listeners[e.target.button](e.target)
            end
        end
        return true
    end
end
