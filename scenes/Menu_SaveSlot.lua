local menu = {}

local cluster
local pointer = GLT.Pointer.new(217, 45)
local fade

function menu:load()
  fade = GLT.Fade.new("sceneIn", 0, 0, 0, 4)
  cluster = 
  {
    back = love.graphics.newImage("content/System/menu_slots/Mountain.png"),
    sys = love.graphics.newImage("content/System/menu_slots/Slot_System.png"),
  }
end

function menu:update(dt)
  fade:update(dt)
  pointer:update(dt)

  -- Pointer logic
  if pointer:getValue() == 0 then
    pointer:setPos(217, 45)
  elseif  pointer:getValue() == 1 then
    pointer:setPos(217, 52)
  elseif  pointer:getValue() == 2 then
    pointer:setPos(217, 93)
  elseif  pointer:getValue() == 3 then
    pointer:setPos(217, 100)
  elseif  pointer:getValue() == 4 then
    pointer:setPos(217, 141)
  elseif  pointer:getValue() == 5 then
    pointer:setPos(217, 147)
  end
  
end

function menu.keypressed(key)
  -- Positions of the pointer
  if key == "up" and pointer:getValue() > 0 then
    pointer:setValue(math.max(0, pointer:getValue() - 1))
  elseif key == "down" and pointer:getValue() < 5 then
    pointer:setValue(math.min(5, pointer:getValue() + 1))
  end

  -- Returning
  if (key == "x") or (key == "lshift") or (key == "rshift") then
    switchScene(sceneTree.MMenu)
  end
end

function menu:draw()
  love.graphics.draw(cluster.back)
  love.graphics.draw(cluster.sys)
  pointer:draw()
  fade:draw()
end


return menu