local mainUtils = 
{
  push = require("externLibraries.push"),
  globalLibs = require("myCoreGameUtils.globalLibraries"),
  globalObjs = require("myCoreGameUtils.globalObjects"),
  sceneTree = require("myCoreGameUtils.sceneTree"),
  gameState = require("myCoreGameUtils.gameState"),
}

-- General functions
function love.load()
  require("utf8")
  local font = love.graphics.newImageFont("content/Fonts/FontMain.png", " AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTÚUVWXYZ.,!¡?¿()\"+-1234567890", 1)
  love.graphics.setFont(font)
  love.graphics.setDefaultFilter("nearest", "nearest")
  mainUtils.push:setupScreen(256, 224, (256 * 2), (224 * 2), {fullscreen = false})
  mainUtils.gameState:load()
end

function love.update(dt)
  mainUtils.gameState:update(dt)
end

function love.keypressed(key)
  mainUtils.gameState.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  mainUtils.push:start()
  mainUtils.gameState:draw()
  mainUtils.push:finish()
end