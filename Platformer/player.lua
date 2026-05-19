Player = {}

function Player:load()
	self.x = 320
	self.y = 0
	self.width = 20
	self.height = 60
	self.xVel = 0
	self.yVel = 100
	self.maxSpeed = 200
	self.acceleration = 4000
	self.friction = 1250
	self.gravity = 1500
	self.jumpForce = -500
	
	self.grounded = false
	self.canDoubleJump = false
	
	self.physics = {}
	self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
	self.physics.body:setFixedRotation(true)
	self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
	self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function Player:update(dt)
	self:syncPhysics()
	self:move(dt)
	self:applyGravity(dt)
	self:applyFriction(dt)
end

function Player:applyGravity(dt)
	if not self.grounded then	
		self.yVel = self.yVel + self.gravity * dt
	end
end

function Player:handleKey(key)
	-- reset player position
	if (key == "r") then
		self.physics.body:setX(320)
		self.physics.body:setY(0)
	end
	
	-- jump
	if (key == "space" or key == "up") and (self.grounded or self.canDoubleJump) then		
		self.yVel = self.jumpForce
		
		if not self.grounded then self.canDoubleJump = false end
		
		self.grounded = false
	end
end

function Player:move(dt)
	if love.keyboard.isDown("d", "right") then
		if self.xVel < self.maxSpeed then
			self.xVel = math.min(self.xVel + self.acceleration * dt, self.maxSpeed)
		end
	elseif love.keyboard.isDown("a", "left") then
		if self.xVel > -self.maxSpeed then
			self.xVel = math.max(self.xVel - self.acceleration * dt, -self.maxSpeed)
		end
	end
end

function Player:applyFriction(dt)
	local friction = self.friction
	
	if not self.grounded then friction = friction * 0.9 end
	
	if self.xVel > 0 then
		if self.xVel - friction * dt > 0 then
			self.xVel = self.xVel - friction * dt
		else
			self.xVel = 0
		end
	elseif self.xVel < 0 then
		if self.xVel + friction * dt < 0 then
			self.xVel = self.xVel + friction * dt
		else
			self.xVel = 0
		end
	end
end

function Player:syncPhysics()
	self.x, self.y = self.physics.body:getPosition()
	self.physics.body:setLinearVelocity(self.xVel, self.yVel)
end

function Player:beginContact(a, b, collision)
	if self.grounded then
		return
	end

	local nx, ny = collision:getNormal()
	if a == self.physics.fixture then
		if ny > 0 then
			self:land(collision)
		end
	elseif b == self.physics.fixture then
		if ny < 0 then
			self:land(collision)
		end
	end
end

function Player:land(collision)
	self.currentGround = collision
	self.yVel = 0
	self.grounded = true
end

function Player:endContact(a, b, collision)
	if a == self.physics.fixture or b == self.physics.fixture then
		if self.currentGround == collision then
			self.grounded = false
			self.canDoubleJump = true
		end
	end
end

function Player:draw()
	love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end