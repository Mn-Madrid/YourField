local MainMenu = {}

local cluster
local pointer
local fade

function MainMenu:load()
  pointer = GLT.Pointer.new(152, 149, -1)
  fade = GLT.Fade.new("sceneIn", 0, 0, 0, 4)

  cluster =
  {
    logo = love.graphics.newImage("content/System/menu_main/logo.png"),
    tb = love.graphics.newImage("content/System/menu_main/miniTB.png"),
    back = love.graphics.newImage("content/System/menu_main/MMback.png")
  }

end

function MainMenu:update(dt)
  fade:update(dt)
  pointer:update(dt)

  if pointer:getValue() == 0 then
    pointer:setPos(98, 149)

  elseif pointer:getValue()  == 1 then
    pointer:setPos(98, 156)

  elseif pointer:getValue()  == 2 then
    pointer:setPos(98, 163)

  end

end

function MainMenu.keypressed(key)
  --Hovering
  if key == "up" and pointer:getValue() > 0 then
    pointer:setValue(math.max(0, pointer:getValue() - 1))
  elseif key == "down" and pointer:getValue() < 2 then
    pointer:setValue(math.min(2, pointer:getValue() + 1))
  end

  -- Selecting
  if (key == "z") or (key == "return") then

    if pointer:getValue() == 0 then
      switchScene(sceneTree.TField)
    elseif pointer:getValue() == 1 then
      switchScene(sceneTree.SMenu)
    elseif pointer:getValue() == 2 then
      love.event.quit()
    end

  end

end

function MainMenu:draw()
  love.graphics.draw(cluster.back)
  love.graphics.draw(cluster.logo, 48, 32)
  love.graphics.draw(cluster.tb, 96, 144)
  love.graphics.print(GLT.localizator.menuMain[1], 102, 147)
  love.graphics.print(GLT.localizator.menuMain[2], 102, 154)
  love.graphics.print(GLT.localizator.menuMain[3], 102, 161)
  pointer:draw()
  fade:draw()

end

return MainMenu