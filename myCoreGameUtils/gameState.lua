local gameState = {}

-- Dependent variables
gameState.currentScene = sceneTree.TField

-- General functions
function gameState:load()
  gameState.currentScene:load()
end

function gameState:update(dt)
  gameState.currentScene:update(dt)
end

function gameState.keypressed(key)
  gameState.currentScene.keypressed(key)
end


function gameState:draw()
  gameState.currentScene:draw()
end

-- Global switch scene function
function _G.switchScene(newScene)
  gameState.currentScene = newScene
  gameState:load()
end

return gameState