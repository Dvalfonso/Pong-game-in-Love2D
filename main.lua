function love.load()
    math.randomseed(os.time())  -- Inicializa números aleatorios


    paddle = love.graphics.newImage("assets/paddle.png")
    ball = love.graphics.newImage("assets/ball.png")

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

    love.graphics.draw(ball, b.x, b.y, 0, 0.25, 0.25)
end

function collition(dt)
    if b.x <= p1.x + 34 and b.y + 24 >= p1.y and b.y <= p1.y + 64 then
        b.dir = b.dir * -1
    end

    if b.x >= p2.x + 16 and b.y + 24 >= p2.y and b.y <= p2.y + 64 then
        b.dir = b.dir * -1
    end
end

function moveBall(dt)
    b.x = b.x + 80 * dt * b.dir
end

function resetBall()
    b.x = winHeight / 2
    b.dir = (math.random(2) == 1 and 1 or -1)
    b.y = love.math.random(132, 264)

    b.vel = 0
end