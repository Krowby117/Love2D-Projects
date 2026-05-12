function love.load()
	love.window.setMode( 500, 510 )
	-- initialize sand array
	sand = {
		{1,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{1,0,0,0,0,0,0,0,0,0}
	}
	
	temp = {
		{1,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{1,0,0,0,0,0,0,0,0,0}
	}
	
end

function love.update()
	love.timer.sleep(1)
	updateTemp()
	updateSand()
end

function updateTemp()
	for i=1, #sand do
		for j=1, #sand[i] do
			val = sand[i][j]
			
			if val == 1 and (i+1) <= #sand and sand[i+1][j] == 0 then
				temp[i][j] = 0
				temp[i+1][j] = 1
			elseif val == 1 and (i+1) <= #sand and (j+1) <= #sand[j] and sand[i+1][j+1] == 0 then
				temp[i][j] = 0
				temp[i+1][j+1] = 1
			end
		end
	end
end

function updateSand()
	for i=1, #sand do
		for j=1, #sand[i] do
			sand[i][j] = temp[i][j]
		end
	end
end

function love.draw()
	for i=1, #temp do
		for j=1, #temp[i] do
			val = temp[i][j]
			
			if val == 1 then
				love.graphics.rectangle('fill', (j-1) * 50, (i-1) * 50, 50, 50)
			end
		end
	end
end