Gatherpoint = Object:extend()

function Gatherpoint:new( name, x, y, width, height, cost)
    local padding = 120

    if z ==nil then
        z = 0
    end
    if width ==nil then
        width = 0
    end
    if height ==nil then
        height = 0
    end

    zy = z * 2
    self.x = x - 40
    self.y = y - 40
    self.width =  width + padding
    self.height = height + padding
    self.hold = "empty"
    self.cost = cost
    self.name = name

end

function Item:update(dt)
    if self.carried then
        if player.direction2 == "up" then
        self.x = player.x
        self.y = player.y + 5
        end
        if player.direction2 == "down" then
            self.x = player.x +5
        self.y = player.y + 5
        end
    end
end


function Gatherpoint:draw()
    -- if not pickupDistance(player, self) then
    -- love.graphics.setColor(1, 0.639, 0.329, 1) 
    -- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(shine)  
    -- end
    -- if pickupDistance(player, self) then
    --     love.graphics.setColor(1, 0.639, 0.329, 1) 
    --     love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    --     love.graphics.setColor(shine) 
    -- end
end