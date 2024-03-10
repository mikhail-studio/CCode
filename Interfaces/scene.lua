local M = {}

function M:show()
    if self.group then
        self.group.isVisible = true

        if type(self.showOverride) == 'function' then
            self:showOverride()
        end
    else
        self:create()
    end
end

function M:hide()
    if self.group then
        self.group.isVisible = false

        if type(self.hideOverride) == 'function' then
            self:hideOverride()
        end
    end
end

function M:destroy()
    if self.group then
        self.group:removeSelf()
        self.group = nil

        if type(self.destroyOverride) == 'function' then
            self:destroyOverride()
        end
    end
end

return M
