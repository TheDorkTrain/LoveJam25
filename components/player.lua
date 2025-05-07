Player = Entity:extend()
-- local angle = 0

shield = love.graphics.newImage("assets/images/character/shield.png")

stepsfx = love.audio.newSource("assets/audio/footstep.wav", "static")
shieldsfx = love.audio.newSource("assets/audio/shield.wav", "static")
idlesong = love.audio.newSource("assets/audio/idlesong.wav", "static")
idlesong:setVolume(2)
stepsfx:setVolume(0.05)

wrongfx = love.audio.newSource("assets/audio/wrong.wav", "static")
rightfx = love.audio.newSource("assets/audio/right.wav", "static")

function Player:new(x, y)
    Player.super.new(self, x, y, "assets/images/character/hero.png")
    self.action = "false"
    self.holding = "false"
    self.state = "idle"
    self.walk = "false"
    self.direction1 = "right"
    self.direction2 = "down"
    self.width = 1
    self.height = 1
    self.speed = 0
end

function pickupDistance(a, b)
    local padding = 40  
    local a_left = a.x - padding + 25
    local a_right = a.x + a.width + padding
    local a_top = a.y - padding + 40
    local a_bottom = a.y + a.height + padding

    local b_left = b.x - padding
    local b_right = b.x + b.width + padding
    local b_top = b.y  - padding
    local b_bottom = b.y + b.height + padding

    local isColliding = a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
    
    return isColliding
end
function Player:update(dt)
    Player.super.update(self, dt)
    
    -- Update cooldown timer if it exists
    if self.actionCooldown then
        self.actionCooldown = self.actionCooldown - dt
        if self.actionCooldown <= 0 then
            self.actionCooldown = nil
        end
    end
    
    if location == "game" then
        -- angle = angle + .5*math.pi * dt
        
        if not love.keyboard.isDown("space") then
            if love.keyboard.isDown("right") then
                self.walk = "true"
                self.x = self.x + 300 * dt + self.speed
                stepsfx:play()
                self.direction1 = "right"
            elseif love.keyboard.isDown("left") then
                self.walk = "true"
                self.x = self.x - 300 * dt - self.speed
                stepsfx:play()
                self.direction1 = "left"
            end
            
            if love.keyboard.isDown("up") then
                self.walk = "true"
                self.y = self.y - 300 * dt - self.speed
                stepsfx:play()
                self.direction2 = "up"
            elseif love.keyboard.isDown("down") then
                self.walk = "true"
                self.y = self.y + 300 * dt + self.speed
                stepsfx:play()
                self.direction2 = "down"
            end
        end
        if love.keyboard.isDown("space") and not self.actionCooldown then
            if player.holding == "true" then
                -- Find the item the player is currently holding
                local heldItem = nil
                for i, item in ipairs(pearlItems) do
                    if item.carried then
                        heldItem = item
                        break
                    end
                end
                
                -- If we found the held item, attempt to drop it
                if heldItem then
                    -- Find the closest point that meets requirements
                    local closestPoint = nil
                    local minDistance = math.huge
                    
                    for j, point in ipairs(gatherPoints) do
                        if point.hold == "empty" and pickupDistance(self, point) and heldItem.name == point.cost then
                            -- Calculate distance between player and this point
                            local dx = self.x - point.x
                            local dy = self.y - point.y
                            local distance = math.sqrt(dx * dx + dy * dy)
                            
                            -- If this point is closer than the current closest
                            if distance < minDistance then
                                minDistance = distance
                                closestPoint = point
                            end
                        end
                    end
                    
                    -- If we found a valid point, use it
                    if closestPoint then
                        heldItem.x = closestPoint.x + 40
                        heldItem.y = closestPoint.y
                        heldItem.pickup = false
                        heldItem.carried = false
                        if closestPoint.name == "stand" then
                            changeShine(heldItem.type)
                        end
                        self.action = "throw"
                        self.holding = "false"
                        -- Add cooldown after putting down an item
                        self.actionCooldown = 0.5 -- Adjust timing as needed (0.5 seconds)
                        closestPoint.hold = "full"
                        closestPoint.goal = heldItem.type
                        if closestPoint.answer then
                            if closestPoint.answer == closestPoint.goal then
                                rightfx:play()
                            else
                                wrongfx:play()
                            end
                        end

                    else
                        -- If no valid points found, just drop the item near the player
                        heldItem.x = self.x + 20  -- Adjust offset as needed
                        heldItem.y = self.y + 20  -- Adjust offset as needed
                        heldItem.pickup = false
                        heldItem.carried = false
                        self.action = "throw"
                        self.holding = "false"
                        -- Add cooldown after putting down an item
                        self.actionCooldown = 0.5 -- Adjust timing as needed
                    end
                end
            elseif player.holding == "false" then
                -- First, try to pick up items from gather points
                local closestPoint = nil
                local minDistance = math.huge
                local itemAtPoint = nil
                
                -- Find the closest gather point with an item
                for i, point in ipairs(gatherPoints) do
                    if pickupDistance(self, point) and point.hold == "full" then
                        -- Calculate distance between player and this point
                        local dx = self.x - point.x
                        local dy = self.y - point.y
                        local distance = math.sqrt(dx * dx + dy * dy)
                        
                        if distance < minDistance then
                            minDistance = distance
                            closestPoint = point
                            
                            -- Find the item at this gather point
                            for j, item in ipairs(pearlItems) do
                                -- Check if item is near this point (not carried and within reasonable distance)
                                local itemDx = item.x - (point.x + 40) -- Accounting for the +40 offset when placing
                                local itemDy = item.y - point.y
                                local itemDistance = math.sqrt(itemDx * itemDx + itemDy * itemDy)
                                
                                if not item.carried and itemDistance < 50 then -- Adjust threshold as needed
                                    itemAtPoint = item
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- If we found a gather point with an item, pick it up
                if closestPoint and itemAtPoint then
                    itemAtPoint.pickup = true
                    itemAtPoint.carried = true
                    self.holding = "true"
                    self.actionCooldown = 0.5 -- Add cooldown
                    
                    if closestPoint.name == "stand" then
                        changeShine("none")
                    end
                    closestPoint.hold = "empty"
                    closestPoint.goal = "empty"
                else
                    -- Fallback to the regular pickup logic for loose items
                    local closestItem = nil
                    local closestDistance = math.huge
                    
                    for i, item in ipairs(pearlItems) do
                        if pickupDistance(self, item) and not item.carried then
                            -- Calculate the actual distance between player and item centers
                            local playerCenterX = self.x + (self.width / 2)
                            local playerCenterY = self.y + (self.height / 2)
                            local itemCenterX = item.x + (item.width / 2)
                            local itemCenterY = item.y + (item.height / 2)
                            
                            local dx = playerCenterX - itemCenterX
                            local dy = playerCenterY - itemCenterY
                            local distance = math.sqrt(dx * dx + dy * dy)
                            
                            if distance < closestDistance then
                                closestDistance = distance
                                closestItem = item
                            end
                        end
                    end
                    
                    -- If we found a loose item in range, pick it up
                    if closestItem then
                        closestItem.pickup = true
                        closestItem.carried = true
                        self.holding = "true"
                        self.actionCooldown = 0.5
                    else
                        self.action = "action"
                    end
                end
            end
        end

end
end
-- Helper function to calculate distance between two objects
function getDistance(obj1, obj2)
    local x1 = obj1.x + (obj1.width / 2)
    local y1 = obj1.y + (obj1.height / 2)
    local x2 = obj2.x + (obj2.width / 2)
    local y2 = obj2.y + (obj2.height / 2)
    
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt(dx * dx + dy * dy)
end

function Player:keyreleased(key)
    if not love.keyboard.isDown("space") then
        if key == "right" or key == "up" or key == "down" then
            self.walk = "false"
        end
        if key == "left" then
            self.walk = "false"
        end
    end
    if key == "space" then
          self.action = "false"
          self.walk = "false"
          idlesong:stop()
    end
    end
        

function Player:draw()
    
    love.graphics.setColor(shine)

    if self.action == "action" then
         if self.direction1 == "right" then
            idlesong:play()
         love.graphics.draw(playerSheet, waveFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
    end

    if self.direction1 == "left" then
        idlesong:play()
        love.graphics.draw(playerSheet, waveFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
    end

    end

    if self.action == "throw" then
        if self.direction1 == "right" then
        love.graphics.draw(playerSheet, throwFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
   end
   if self.direction1 == "left" then
    love.graphics.draw(playerSheet, throwFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
end
end

    --Holding Animations

if self.action == "false" then
    if self.holding == "true" then 
        if self.walk =="false" then
            if self.direction1 == "right" and self.direction2 == "down" then
                love.graphics.draw(playerSheet, carryIdleFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                end
                if self.direction1 == "left" and self.direction2 == "down"  then
                    love.graphics.draw(playerSheet, carryIdleFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                end
                if self.direction1 == "right" and self.direction2 == "up" then
                    love.graphics.draw(playerSheet, upCarryIdleFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                    end
                    if self.direction1 == "left" and self.direction2 == "up"  then
                        love.graphics.draw(playerSheet, upCarryIdleFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                    end
        end
        if self.walk == "true" then
            if self.direction1 == "right" and self.direction2 == "down" then
                love.graphics.draw(playerSheet, carryWalkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                end
                if self.direction1 == "left" and self.direction2 == "down"  then
                    love.graphics.draw(playerSheet, carryWalkFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                end
                if self.direction1 == "right" and self.direction2 == "up" then
                    love.graphics.draw(playerSheet, upCarryWalkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                    end
                    if self.direction1 == "left" and self.direction2 == "up"  then
                        love.graphics.draw(playerSheet, upCarryWalkFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                    end
        end
    end

    -- Non Holding Animations

    if self.holding == "false" then
    if self.walk =="false" then
        if self.direction1 == "right" and self.direction2 == "down" then
            love.graphics.draw(playerSheet, idleFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
            end
            if self.direction1 == "left" and self.direction2 == "down"  then
                love.graphics.draw(playerSheet, idleFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
            end
            if self.direction1 == "right" and self.direction2 == "up" then
                love.graphics.draw(playerSheet, upIdleFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                end
                if self.direction1 == "left" and self.direction2 == "up"  then
                    love.graphics.draw(playerSheet, upIdleFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                end
    end
    if self.walk == "true" then
        if self.direction1 == "right" and self.direction2 == "down" then
            love.graphics.draw(playerSheet, walkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
            end
            if self.direction1 == "left" and self.direction2 == "down"  then
                love.graphics.draw(playerSheet, walkFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
            end
            if self.direction1 == "right" and self.direction2 == "up" then
                love.graphics.draw(playerSheet, upWalkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
                end
                if self.direction1 == "left" and self.direction2 == "up"  then
                    love.graphics.draw(playerSheet, upWalkFrames[math.floor(currentFrame)], (self.x+55), self.y, self.scale, (self.width*-1), self.height)
                end
    end
end
end


--  local padding = 30  -- Use the same value as in pickupDistance
--     love.graphics.setColor(1, 0, 0, 0.3)  -- Semi-transparent red
--     love.graphics.rectangle("fill", 
--         self.x - padding + 25, 
--         self.y - padding + 40, 
--         self.width + (padding * 2), 
--         self.height + (padding * 2))
--     love.graphics.setColor(1, 1, 1, 1)  




    -- if self.direction == "right" then
    --     love.graphics.draw(playerSheet, walkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
    -- end
    -- if self.direction == "left" then
    --     love.graphics.draw(playerSheet, walkFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
    -- end
    -- if self.direction == "idleleft" then
    --     love.graphics.draw(playerSheet, idleFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
    -- end
    -- if self.direction == "action" then
    --     love.graphics.draw(playerSheet, waveFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
    -- end
    
end