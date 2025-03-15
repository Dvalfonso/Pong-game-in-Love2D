--[[
    The ball sprite is 16x16 px but is drawn in 0.5
    The paddle sprite is 64x64 and its width inside is 16
]]


function love.load()
    math.randomseed(os.time())  -- Inicializa números aleatorios

    scoreP1 = 0
    scoreP2 = 0

    maxScore = 6

    gameOver = false

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

    if not gameOver then
        moveBall(dt)
        collition(dt)
    end
end

function love.draw()
    if gameOver then
        love.graphics.printf(winner .. " wins!", 0, winHeight / 2, winWidth, "wins")
    end

    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)

    love.graphics.draw(paddle, p1.x, p1.y)
    love.graphics.draw(paddle, p2.x, p2.y)

    love.graphics.draw(ball, b.x, b.y, 0, 0.5, 0.5)

    drawScoreBars()
end

function collition(dt)
    if b.x <= p1.x + 32 and b.y + 8 >= p1.y and b.y + 8 <= p1.y + 64 then
        
        local paddleCenter = p1.y + 64 / 2 --paddle height / 2
        local ballCenter = b.y + 8 / 2 --ball height / 2
        local impact = (ballCenter - paddleCenter) / (64 / 2)

        b.dirY = impact
        b.dirX = b.dirX * -1

    end

    if b.x + 8 >= p2.x + 32 and b.y + 8 >= p2.y and b.y + 8 <= p2.y + 64 then

        local paddleCenter = p2.y + 64 / 2 --paddle height / 2
        local ballCenter = b.y + 8 / 2 --ball height / 2
        local impact = (ballCenter - paddleCenter) / (64 / 2)

        b.dirY = impact

        b.dirX = b.dirX * -1
    end
end

function moveBall(dt)
    b.x = b.x + 200 * dt * b.dirX
    b.y = b.y + 200 * b.dirY * dt

    if b.y - 8 <= 0 then
        b.dirY = b.dirY  * -1
    elseif b.y + 24 >= winHeight then
        b.dirY = b.dirY * -1
    end

    if b.x <= 0 then
        scoreP2 = scoreP2 + 1
        resetBall()
    end

    if b.x >= winWidth then
        scoreP1 = scoreP1 + 1
        resetBall()
    end
end

function resetBall()
    checkGameOver()

    b.x = winHeight / 2
    b.dirX = (math.random(2) == 1 and 1 or -1)
    b.y = love.math.random(132, 264)
    b.dirY = 1
end

function drawScoreBars()
    local barHeight = 5
    local barWidth = winWidth / 12

    for i = 1, scoreP1 do
        love.graphics.setColor(0,1,0)
        love.graphics.rectangle("fill", winWidth / 2 - i* barWidth, 10, barWidth, barHeight)
        love.graphics.setColor(1,1,1)
    end

    for i = 1, scoreP2 do
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", winWidth / 2 + (i-1) * barWidth, 10, barWidth, barHeight)
        love.graphics.setColor(1,1,1)
    end
end

function checkGameOver()
    if scoreP1 >= maxScore then
        gameOver = true
        winner = "Player 1"
    elseif scoreP2 >= maxScore then
        gameOver = true
        winner = "Player 2"
    end
end
