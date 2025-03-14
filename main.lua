--[[
    The ball sprite is 16x16 px but is drawn in 0.5
    The paddle sprite is 64x64 and its width inside is 16
]]


function love.load()
    math.randomseed(os.time())  -- Inicializa números aleatorios


    paddle = love.graphics.newImage("assets/paddle64x64.png")
    ball = love.graphics.newImage("assets/ball16x16.png")

    winHeight = love.graphics.getHeight()
    winWidth = love.graphics.getWidth()
    
    p1 = {}

    p1.x = 15

    p1.y = winHeight / 2 - 64/2
    
    p2 = {}
    
    p2.x = love.graphics.getWidth() - 64 - 15
    p2.y = love.graphics.getHeight() / 2 - 64/2

    b = {}

    resetBall()

end

function love.update(dt)
    if love.keyboard.isDown('s') then
        p1.y = p1.y + 200 * dt
    end

    if love.keyboard.isDown('w') then
        p1.y = p1.y - 200 * dt
    end

    if love.keyboard.isDown('down') then
        p2.y = p2.y + 200 * dt
    end

    if love.keyboard.isDown('up') then
        p2.y = p2.y - 200 * dt
    end

    moveBall(dt)
    collition(dt)
end

function love.draw()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)

    love.graphics.draw(paddle, p1.x, p1.y)
    love.graphics.draw(paddle, p2.x, p2.y)

    love.graphics.draw(ball, b.x, b.y, 0, 0.5, 0.5)
end

function collition(dt)
    if b.x <= p1.x + 32 and b.y + 8 >= p1.y and b.y + 8 <= p1.y + 64 then
        local dist = ((b.y + 8) - (p1.y + 32)) / 32
        b.dirY = dist
    end

    if b.x + 8 >= p2.x + 32 and b.y + 8 >= p2.y and b.y + 8 <= p2.y + 64 then

    end
end

function moveBall(dt)
    b.x = b.x + 80 * dt * b.dirX
    b.y = b.y + 80 * b.dirY * dt

    if b.y - 8 <= 0 then
        b.dirY = b.dirY  * -1
    elseif b.y + 24 >= winHeight then
        b.dirY = b.dirY * -1
    end

    if b.x <= 0 or b.x >= winWidth then
        resetBall()
    end
end

function resetBall()
    b.x = winHeight / 2
    b.dirX = (math.random(2) == 1 and 1 or -1)
    b.y = love.math.random(132, 264)
    b.dirY = 1
end