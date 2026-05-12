--! file: player.lua

Player = Object:extend()

function Player:new()
	self.xPos = 100
	self.yPos = 100
	self.rotation = 0
	
    self.moveSpeed = 200
    self.rotateSpeed = 0.015
    
    self.sprite = love.graphics.newImage("sprites/ship.png")
end

function Player:update(dt)
	velocity = self.moveSpeed * dt
	dy = 0
	
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then 
        self.rotation = self.rotation + self.rotateSpeed end
        
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.rotation = self.rotation - self.rotateSpeed end
        
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        dy = -1 end
        
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        dy = 1 end
        
    cos = math.cos(self.rotation + 1.5708)
    sin = math.sin(self.rotation + 1.5708)

    -- move the player towards the mouse
    self.xPos = self.xPos + self.moveSpeed * dy * cos * dt
    self.yPos = self.yPos + self.moveSpeed * dy * sin * dt
end

function Player:draw()
    cX = self.sprite:getWidth() / 2
    cY = self.sprite:getHeight() / 2
    love.graphics.draw(self.sprite, self.xPos, self.yPos, self.rotation, 2, 2, cX, cY)
end