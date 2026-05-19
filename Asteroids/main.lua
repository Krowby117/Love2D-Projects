function love.load()
    -- initialize some basic variables needed
    winWidth, winHeight = love.graphics.getDimensions()  
    score = 0
    
    -- initialize the player
    player = {}
    player.health = 5
    player.sprite = love.graphics.newImage("sprites/ship.png")
    player.xPos = 100
	player.yPos = 100
	
	player.angle = 0
	player.antiAngle = 0
	
	player.turnSpeed = 5
    player.accel = 45
    player.xSpeed = 0
    player.ySpeed = 0
    player.maxSpeed = 100

end

function love.update(dt)  
    -- player movement
    if love.keyboard.isDown('right') then
	    player.angle = player.angle + player.turnSpeed * dt end
	if love.keyboard.isDown('left') then
	    player.angle = player.angle - player.turnSpeed * dt end
	    
	player.angle = player.angle % (2 * math.pi) -- keepts the angle in the range: 0 <= angle <= 2pi
	
	if love.keyboard.isDown('up') then
	    player.xSpeed = math.min(player.xSpeed + math.cos(player.angle) * player.accel * dt, player.maxSpeed)
	    player.ySpeed = math.min(player.ySpeed + math.sin(player.angle) * player.accel * dt, player.maxSpeed)
	    player.antiAngle = player.angle
	else
		if player.xSpeed > 0 then
			player.xSpeed = math.max(player.xSpeed - math.cos(player.antiAngle) * 20 * dt, 0) else
			player.xSpeed = math.min(player.xSpeed + math.cos(player.antiAngle) * 20 * dt, 0) end
	    if player.ySpeed > 0 then
	    	player.ySpeed = math.max(player.ySpeed - math.sin(player.antiAngle) * 20 * dt, 0) else
	    	player.ySpeed = math.min(player.ySpeed + math.sin(player.antiAngle) * 20 * dt, 0) end
	end
	
	player.xPos = player.xPos + player.xSpeed * dt
	player.yPos = player.yPos + player.ySpeed * dt
	
	if player.xPos > winWidth then 
		player.xPos = winWidth 
		player.xSpeed = 0
		end
	if player.xPos < 0 then 
		player.xPos = 0 
		player.xSpeed = 0
		end
	if player.yPos > winHeight then 
		player.yPos = winHeight 
		player.ySpeed = 0
		end
	if player.yPos < 0 then 
		player.yPos = 0
		player.ySpeed = 0
		end
		
	-- bullet movement
	
	-- asteroid movement
	
	-- collision detection
end

function love.draw()
	-- draw the player
    cX = player.sprite:getWidth() / 2
    cY = player.sprite:getHeight() / 2
    love.graphics.draw(player.sprite, player.xPos, player.yPos, player.angle + 1.5708, 1.5, 1.5, cX, cY)
    
    -- draw the bullets
    
    -- draw the asteroids
end

function love.keypressed(key)
    if key == "escape" then
      love.event.quit() end
end

