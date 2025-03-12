# Pong Game in LÖVE2D

A simple Pong game made with LÖVE2D. This project demonstrates basic physics, collision detection, and movement logic in Lua.

## 🎮 Features
- Player controls with `W/S` (Player 1) and `Up/Down` (Player 2)
- Ball movement with dynamic bouncing angles
- Collision detection with paddles and walls
- FPS display

## 🛠 Installation
1. Download and install [LÖVE](https://love2d.org/).
2. Clone this repository:
   ```sh
   git clone https://github.com/Dvalfonso/Pong-game-in-Love2D.git
   cd pong-love2d
   ```
3. Run the game:
   ```sh
   love .
   ```

## 🎮 Controls
- `W` / `S` - Move Player 1 paddle up/down
- `Up` / `Down` - Move Player 2 paddle up/down

## 📜 How It Works
- The ball moves in a straight line and bounces off the walls.
- When hitting a paddle, the bounce angle depends on the impact position.
- The game logic is handled in `love.update(dt)` and `love.draw()` functions.

## 🚀 Future Improvements
- Add scoring system
- Implement AI for single-player mode
- Improve physics for more realistic bounces
- Add sound effects

## 📜 License
This project is licensed under the MIT License.

