local Splash = {}

local timer = GLT.Timer.new(5, false)
local fade = GLT.Fade.new("sceneIn", 0, 0, 0, 2)

function Splash:load()
  Splash.image = love.graphics.newImage("content/System/Splash.png")
end

function Splash:update(dt)
  timer:update(dt)
  fade:update(dt)

  if (timer.currentValue > 3) and (timer.currentValue < 3.1) then
    fade:setStatus("sceneOut")
  end

  if timer.currentValue >= 5 then
    switchScene(sceneTree.MMenu)
  end

end

function Splash.keypressed(key)
  
end

function Splash:draw()
  love.graphics.draw(Splash.image)
  fade:draw()
end

return Splash