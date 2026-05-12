function love.load()
    -- initialize some basic variables needed
    winWidth, winHeight = love.graphics.getDimensions()  
    score = 0
    
    -- initialize the player
    player = {}
    player.xPos = 100
	player.yPos = 100
	player.angle = 0
	player.turnSpeed = 5
    player.moveSpeed = 100
    player.xSpeed = 0
    player.ySpeed = 0
    player.sprite = love.graphics.newImage("sprites/ship.png")

end

function love.update(dt)  
    -- player movement
    if love.keyboard.isDown('right') then
	    player.angle = player.angle + player.turnSpeed * dt end
	if love.keyboard.isDown('left') then
	    player.angle = player.angle - player.turnSpeed * dt end
    -- keepts the angle in the range: 0 <= angle <= 2pi
	player.angle = player.angle % (2 * math.pi)
	
	if love.keyboard.isDown('up') then
	    player.xSpeed = player.xSpeed + math.cos(player.angle) * player.moveSpeed * dt
	    player.ySpeed = player.ySpeed + math.sin(player.angle) * player.moveSpeed * dt
	end
	
	player.xPos = (player.xPos + player.xSpeed * dt) % winWidth
	player.yPos = (player.yPos + player.ySpeed * dt) % winHeight
end

function love.draw()
	-- draw the player sprite
    cX = player.sprite:getWidth() / 2
    cY = player.sprite:getHeight() / 2
    love.graphics.draw(player.sprite, player.xPos, player.yPos, player.angle + 1.5708, 1.5, 1.5, cX, cY)
end

function love.keypressed(key)
    if key == "escape" then
      love.event.quit() end
end

