Boss = Entity:extend()

Crab = love.graphics.newImage("assets/images/character/crab.png")
shockwave = love.graphics.newImage("assets/images/props/shockwave.png")

stompfx = love.audio.newSource("assets/audio/stomp.wav", "static")

local size = 1

function Boss:new(x, y)
    Boss.super.new(self, x, y, "assets/images/character/blob.png")
    self.action = "false"
    self.holding = "false"
    self.state = "idle"  -- "idle", "jumping", "landing", "shockwave"
    self.walk = "false"
    self.direction1 = "right"
    self.direction2 = "down"
    self.width = size
    self.height = size
    self.speed = 750
    self.cooldown = 0
    self.centerX = self.x + Crab:getWidth()/2
    self.centerY = self.y + Crab:getHeight()/2
    
    -- Jump animation properties
    self.jumpHeight = 0
    self.maxJumpHeight = 100
    self.jumpSpeed = 400
    self.isJumping = false
    self.jumpDirection = 1  -- 1 for up, -1 for down
    
    -- Shockwave properties
    self.shockwaveActive = false
    self.shockwaveRadius = 0
    self.maxShockwaveRadius = 250
    self.shockwaveGrowthSpeed = 400
    self.shockwaveDuration = 1.0
    self.shockwaveTimer = 0
    self.shockwaveX = 0
    self.shockwaveY = 0
    
    -- Target position for jump
    self.targetX = self.x
    self.targetY = self.y
end

function Boss:calculateJumpTarget(target)
    self.targetX = target.x
    self.targetY = target.y
end

function Boss:startJump()
    if self.state == "idle" then
        self.state = "jumping"
        self.isJumping = true
        self.jumpDirection = 1
        self.jumpHeight = 0
        self:calculateJumpTarget(player)
    end
end

function Boss:updateJump(dt)
    if self.isJumping then
        if self.jumpDirection == 1 then
            -- Rising phase
            self.jumpHeight = self.jumpHeight + self.jumpSpeed * dt
            if self.jumpHeight >= self.maxJumpHeight then
                self.jumpHeight = self.maxJumpHeight
                self.jumpDirection = -1
            end
        else
            -- Falling phase
            self.jumpHeight = self.jumpHeight - self.jumpSpeed * dt
            if self.jumpHeight <= 0 then
                self.jumpHeight = 0
                self.isJumping = false
                self:land()
            end
        end
        
        -- Move towards target during jump
        local moveSpeed = self.speed * dt
        local dx = self.targetX - self.centerX
        local dy = self.targetY - self.centerY
        local distance = math.sqrt(dx*dx + dy*dy)
        
        if distance > 5 then
            self.x = self.x + (dx / distance) * moveSpeed
            self.y = self.y + (dy / distance) * moveSpeed
            self.centerX = self.x + Crab:getWidth()/2
            self.centerY = self.y + Crab:getHeight()/2
        end
    end
end

function Boss:land()
    self.state = "landing"
    self:createShockwave()
    -- Play stomp sound
    love.audio.play(stompfx)
end

function Boss:createShockwave()
    self.shockwaveActive = true
    self.shockwaveRadius = 120
    self.shockwaveTimer = 0
    self.shockwaveX = self.centerX
    self.shockwaveY = self.centerY + 100  -- Ground level
    self.state = "shockwave"
end

function Boss:updateShockwave(dt)
    if self.shockwaveActive then
        self.shockwaveTimer = self.shockwaveTimer + dt
        self.shockwaveRadius = self.shockwaveRadius + self.shockwaveGrowthSpeed * dt
        
        -- Check collision with player
        if self:checkShockwaveCollision(player) then
            if player.block == false then
            location = "gameover"
            end
            -- Example: player.health = player.health - 10
        end
        
        -- Check collision with items (assuming you have an items table)
            for i, item in ipairs(trees) do
                if self:checkShockwaveCollision(item) then
                   item.destroy = true
                    -- Handle item hit (you can customize this)
                    -- Example: item:destroy() or table.remove(items, i)
                end
            end
        
        -- End shockwave
        if self.shockwaveTimer >= self.shockwaveDuration or self.shockwaveRadius >= self.maxShockwaveRadius then
            self.shockwaveActive = false
            self.state = "idle"
            self.cooldown = 0  -- Reset cooldown for next attack
        end
    end
end

function Boss:checkShockwaveCollision(target)
    if not target then return false end
    
    local dx = (target.x + (target.width or 32)/2) - self.shockwaveX
    local dy = (target.y + (target.height or 32)/2) - self.shockwaveY
    local distance = math.sqrt(dx*dx + dy*dy)
    
    -- Check if target is within shockwave radius (with some tolerance for ring thickness)
    local ringThickness = 5
    return distance <= self.shockwaveRadius and distance >= (self.shockwaveRadius - ringThickness)
end

function Boss:update(dt)
    Boss.super.update(self, dt)

    if self.cooldown then
        self.cooldown = self.cooldown - dt
        if self.cooldown <= 0 then
            self.cooldown = nil
        end
    end

    -- State machine
    if self.state == "idle" and not self.cooldown then
        self:startJump()
    elseif self.state == "jumping" then
        self:updateJump(dt)
    elseif self.state == "shockwave" then
        self:updateShockwave(dt)
    end
end

function Boss:draw()
    -- Draw shadow/ground indicator
    love.graphics.setColor(0.2, 0.2, 0.2, 0.5)
    love.graphics.circle("fill", self.centerX, self.centerY + 100, 50)
    
    -- Draw shockwave if active
    if self.shockwaveActive then
        love.graphics.setColor(1, 1, 1, 0.7 - (self.shockwaveTimer / self.shockwaveDuration) * 0.7)
        
        -- Option 1: Draw using the shockwave image (scaled)
        local scale = self.shockwaveRadius / (shockwave:getWidth() / 2)
        love.graphics.draw(shockwave, self.shockwaveX, self.shockwaveY, 0, scale, scale, 
                          shockwave:getWidth()/2, shockwave:getHeight()/2)
        
        -- Option 2: Draw as circle ring (comment out the above and uncomment below if preferred)
        -- love.graphics.setLineWidth(10)
        -- love.graphics.circle("line", self.shockwaveX, self.shockwaveY, self.shockwaveRadius)
    end
    
    -- Draw boss (elevated during jump)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(Crab, self.x, self.y - self.jumpHeight, 0, self.width, self.height)
    
    -- Debug visualization
    -- love.graphics.setColor(0.329, 0.847, 1, 1) 
    -- love.graphics.rectangle("fill", self.centerX, self.centerY - self.jumpHeight, 10, 10)
    
    -- Reset color
    love.graphics.setColor(1, 1, 1, 1)
end