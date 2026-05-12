function love.load()
    Object = require "classic"
    require "player"
    
    --love.graphics.setBackgroundColor(0.4, 0.6, 0.9)
    
    player = Player()

end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end

function love.keypressed(key)
    if key == "escape" then
      love.event.quit() end
end

