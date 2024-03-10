Game = {}
Game.__index = Game

math.randomseed(os.time())

function Game:doMove(isMix)
    self.obj[self.focus].strokeWidth = 0
    self.obj[self.focus].focus = nil
    self.isMove = true

    local fromX = self.obj[self.focus].x
    local fromY = self.obj[self.focus].y

    transition.to(self.obj[self.focus], {x = self.obj[self.name].x, y = self.obj[self.name].y, time = 400 / self.speed})
    transition.to(self.obj[self.name], {x = fromX, y = fromY, time = 400 / self.speed, onComplete = function()
        if not isMix then
            if self:hasMatches() then
                self:removeMatches()
            else
                self:cancelMove()
            end
        end
    end})

    self:move(self.obj[self.focus].i, self.obj[self.focus].j, self.obj[self.name].i, self.obj[self.name].j)
end

function Game:checkMove(name)
    local fromI = self.obj[name].i
    local fromJ = self.obj[name].j
    local i = self.obj[self.focus].i
    local j = self.obj[self.focus].j
    return (fromI - 1 == i and fromJ == j) or (fromI + 1 == i and fromJ == j)
        or (fromI == i and fromJ - 1 == j) or (fromI == i and fromJ + 1 == j)
end

function Game:cancelMove(hasMatches)
    self.isMove = nil

    if self.isBackMove then
        self.isBackMove = nil
        self.focus = nil
    elseif hasMatches then
        self.focus = nil
    else
        self.isBackMove = true
        self:doMove()
    end
end

function Game:newObject(i, j)
    local name = i .. '|' .. j
    local x = self.positionsX[j]
    local y = self.positionsY[i]

    self.obj[name] = display.newRoundedRect(self.group, x, y, self.width, self.height, self.width / 5)
    self.obj[name].i, self.obj[name].j, self.obj[name].name = i, j, name

    self.obj[name].fill = {
        type = 'image', filename = other.getImage(tostring(self.field[i][j])),
        baseDir = system.DocumentsDirectory
    }

    self.obj[name]:addEventListener('touch', function(e)
        if e.phase == 'began' then
            if not self.isMove then
                if self.focus and self.focus ~= e.target.name and self:checkMove(e.target.name) then
                    self.name = e.target.name
                    self:doMove()
                    return true
                end

                if e.target.focus then
                    e.target.focus = nil
                    self.focus = nil
                    e.target.strokeWidth = 0
                elseif not self.focus then
                    e.target.focus = true
                    self.focus = e.target.name
                    e.target.strokeWidth = 4
                end
            end
        end

        return true
    end)
end

function Game:listeners(e)
    if e.phase == 'began' then
        if e.target.speed then
            self.ui['speed' .. self.speed .. 'x']:setFillColor(1)
            self.ui['speed' .. e.target.speed .. 'x']:setFillColor(0, 1, 0)
            self.speed = e.target.speed
        else
            self:mix()
        end
    end
end

function Game:ui(speed)
    self.speed = speed or 1
    self.ui = {}

    self.ui.speed1x = display.newText(self.group, '1x', self.obj['1|2'].x, self.obj['1|1'].y - 120, 'ubuntu', 50)
    self.ui.speed2x = display.newText(self.group, '2x', (self.obj['1|5'].x + self.obj['1|6'].x) / 2, self.obj['1|1'].y - 120, 'ubuntu', 50)
    self.ui.speed4x = display.newText(self.group, '4x', self.obj['1|9'].x, self.obj['1|1'].y - 120, 'ubuntu', 50)

    self.ui.mix = display.newText(self.group, 'mix', self.ui.speed2x.x, self.ui.speed2x.y - 120, 'ubuntu', 50)
    self.ui['speed' .. self.speed .. 'x']:setFillColor(0, 1, 0)

    self.ui.speed1x.speed = 1
    self.ui.speed2x.speed = 2
    self.ui.speed4x.speed = 4

    self.ui.mix:addEventListener('touch', function(e) self:listeners(e) return true end)
    self.ui.speed1x:addEventListener('touch', function(e) self:listeners(e) return true end)
    self.ui.speed2x:addEventListener('touch', function(e) self:listeners(e) return true end)
    self.ui.speed4x:addEventListener('touch', function(e) self:listeners(e) return true end)
end

function Game:create()
    self.width = (DISPLAY_WIDTH - 60 - 6 * self.size) / self.size
    self.height = self.width

    local y = CENTER_Y - self.height * (self.size / 2) - self.height - 6

    for i = 1, self.size do
        local x = ZERO_X + self.width / 2 + 33
        y = y + self.height + 6

        table.insert(self.positionsY, y)

        for j = 1, self.size do
            if #self.positionsX < self.size then
                table.insert(self.positionsX, x)
            end

            self:newObject(i, j)
            x = x + self.width + 6
        end
    end
end

function Game:new()
    local game = {}
    setmetatable(game, Game)

    game.isSim = system.getInfo 'environment' == 'simulator'
    game.group = display.newGroup()
    game.field, game.obj = {}, {}
    game.positionsX, game.positionsY = {}, {}, {}
    game.size, game.colors = 10, {
        {255, 0, 0}, {0, 255, 0}, {0, 0, 255},
        {255, 255, 0}, {0, 255, 255}, {255, 0, 255}
    }

    for i = 1, game.size do
        game.field[i] = {}
        for j = 1, game.size do
            local crystal = math.random(1, 6)

            while (i >= 3 and game.field[i-1][j] == crystal and game.field[i-2][j] == crystal) or
                  (j >= 3 and game.field[i][j-1] == crystal and game.field[i][j-2] == crystal) do
                crystal = math.random(1, 6)
            end

            game.field[i][j] = crystal
        end
    end

    return game
end

function Game:hasMatches()
    for i = 1, self.size do
        for j = 1, self.size - 2 do
            local crystal = self.field[i][j]
            if self.field[i][j + 1] == crystal and self.field[i][j + 2] == crystal then
                return true
            end
        end
    end

    for j = 1, self.size do
        for i = 1, self.size - 2 do
            local crystal = self.field[i][j]
            if self.field[i + 1][j] == crystal and self.field[i + 2][j] == crystal then
                return true
            end
        end
    end

    return false
end

function Game:removeMatches()
    local matches = {}

    for i = 1, self.size do
        local count = 1
        for j = 2, self.size do
            if self.field[i][j] == self.field[i][j - 1] and self.field[i][j] ~= 0 then
                count = count + 1
            else
                if count >= 3 then
                    for k = j - count, j - 1 do
                        matches[#matches + 1] = {i, k}
                    end
                end
                count = 1
            end
        end
        if count >= 3 then
            for k = self.size + 1 - count, self.size do
                matches[#matches + 1] = {i, k}
            end
        end
    end

    for j = 1, self.size do
        local count = 1
        for i = 2, self.size do
            if self.field[i][j] == self.field[i - 1][j] and self.field[i][j] ~= 0 then
                count = count + 1
            else
                if count >= 3 then
                    for k = i - count, i - 1 do
                        matches[#matches + 1] = {k, j}
                    end
                end
                count = 1
            end
        end
        if count >= 3 then
            for k = self.size + 1 - count, self.size do
                matches[#matches + 1] = {k, j}
            end
        end
    end

    if #matches > 0 then
        for _, match in ipairs(matches) do
            local x, y = match[1], match[2]

            if self.field[x][y] ~= 0 and self.obj[x .. '|' .. y] then
                self.field[x][y] = 0

                transition.to(self.obj[x .. '|' .. y], {time = 600 / self.speed, transition = easing.outInBack, width = 0, height = 0,
                    onComplete = function()
                        if self.obj[x .. '|' .. y] then
                            self.obj[x .. '|' .. y]:removeSelf()
                            self.obj[x .. '|' .. y] = nil
                        end
                    end
                })
            end
        end
    end

    timer.new(600 / self.speed + 60, 1, function()
        self:shiftDown()
    end)
end

function Game:shiftDown()
    for j = 1, self.size do
        for i = 2, self.size do
            if self.field[i][j] == 0 then
                for k = i, 2, -1 do
                    self.field[k][j] = self.field[k-1][j]

                    if self.field[k-1][j] > 0 then
                        self.obj[k .. '|' .. j] = self.obj[(k - 1) .. '|' .. j]
                        self.obj[k .. '|' .. j].name = k .. '|' .. j
                        self.obj[k .. '|' .. j].i = k
                        self.obj[k .. '|' .. j].j = j

                        transition.to(self.obj[k .. '|' .. j], {
                            time = 600 / self.speed, y = self.positionsY[k]
                        })
                    end
                end
                self.field[1][j] = 0
            end
        end
    end

    timer.new(600 / self.speed + 60, 1, function()
        self:fillEmptyCells()
    end)
end

function Game:fillEmptyCells()
    for j = 1, self.size do
        for i = 1, self.size do
            if self.field[i][j] == 0 then
                self.field[i][j] = math.random(1, 6)
                self:newObject(i, j)

                self.obj[i .. '|' .. j].width = 0
                self.obj[i .. '|' .. j].height = 0

                transition.to(self.obj[i .. '|' .. j], {
                    time = 600 / self.speed, transition = easing.outInBack,
                    width = self.width, height = self.height
                })
            end
        end
    end

    timer.new(600 / self.speed + 60, 1, function()
        if self:hasMatches() then
            self:removeMatches()
        else
            self:cancelMove(true)
            if not self:canMove() then self:mix() end
        end
    end)
end

function Game:move(fromX, fromY, toX, toY)
    self.field[fromX][fromY], self.field[toX][toY] = self.field[toX][toY], self.field[fromX][fromY]
    self.obj[self.focus].i, self.obj[self.name].i = toX, fromX
    self.obj[self.focus].j, self.obj[self.name].j = toY, fromY
    self.obj[self.focus], self.obj[self.name] = self.obj[self.name], self.obj[self.focus]
    self.obj[self.focus].name, self.obj[self.name].name = self.obj[self.name].name, self.obj[self.focus].name
end

function Game:mix()
    local speed, game = self.speed

    repeat
        for i = 1, self.size do
            for j = 1, self.size do
                local x = math.random(1, self.size)
                local y = math.random(1, self.size)
                self.field[i][j], self.field[x][y] = self.field[x][y], self.field[i][j]
            end
        end
    until not self:hasMatches()

    transition.cancelAll() timer.cancelAll()
    transition.to(self.group, {time = 600, transition = easing.outInBack, alpha = 0, onComplete = function()
        self.group:removeSelf() game = Game:new() game:create() game:ui(speed)
        if not self:canMove() then self:mix() end
    end})
end

function Game:canMove()
    for x = 2, self.size do
        for y = 2, self.size do
            if y > 2 then
                self.field[x][y], self.field[x][y-1] = self.field[x][y-1], self.field[x][y]
                if self:hasMatches(self.field) then
                    self.field[x][y], self.field[x][y-1] = self.field[x][y-1], self.field[x][y]
                    return true
                end
                self.field[x][y], self.field[x][y-1] = self.field[x][y-1], self.field[x][y]
            end

            if y < self.size then
                self.field[x][y], self.field[x][y+1] = self.field[x][y+1], self.field[x][y]
                if self:hasMatches(self.field) then
                    self.field[x][y], self.field[x][y+1] = self.field[x][y+1], self.field[x][y]
                    return true
                end
                self.field[x][y], self.field[x][y+1] = self.field[x][y+1], self.field[x][y]
            end

            if x > 2 then
                self.field[x][y], self.field[x-1][y] = self.field[x-1][y], self.field[x][y]
                if self:hasMatches(self.field) then
                    self.field[x][y], self.field[x-1][y] = self.field[x-1][y], self.field[x][y]
                    return true
                end
                self.field[x][y], self.field[x-1][y] = self.field[x-1][y], self.field[x][y]
            end

            if x < self.size then
                self.field[x][y], self.field[x+1][y] = self.field[x+1][y], self.field[x][y]
                if self:hasMatches(self.field) then
                    self.field[x][y], self.field[x+1][y] = self.field[x+1][y], self.field[x][y]
                    return true
                end
                self.field[x][y], self.field[x+1][y] = self.field[x+1][y], self.field[x][y]
            end
        end
    end

    return false
end

local game = Game:new()

game:create()
game:ui()

if not game:canMove() then
    game:mix()
end
