local menu = {}

local background
local slotTable = {}
local pointer = GLT.Pointer.new(10, 10, 1)
local PointPositions
local TablePositions

function menu:load()
  background = love.graphics.newImage("content/System/menu_slots/Mountain.png")

  -- Adding the slot frames
  for i = 1, 3 do
    slotTable[i] =
    {
      image = love.graphics.newImage("content/System/menu_slots/Slot.png"),
      X = 127,
      Y = 20,
      oX = love.graphics.newImage("content/System/menu_slots/Slot.png"):getWidth() / 2,
      oY = love.graphics.newImage("content/System/menu_slots/Slot.png"):getHeight() / 2,
    }
  end

  -- Lookup tables
  PointPositions = 
  {
    {X = 14 * 16, Y = 8 * 8 - 8},
    {X = 14 * 16, Y = 13 * 8 - 8},
    {X = 14 * 16, Y = 18 * 8 - 8},
  }

  SlotPositions = 
  {
    {X = 8 * 16, Y = 8 * 8 - 8},
    {X = 8 * 16, Y = 13 * 8 - 8},
    {X = 8 * 16, Y = 18 * 8 - 8},
  }
end

function menu:update(dt)
  if pointer:getValue() == 0 then
    pointer:setPos(PointPositions[2].X, PointPositions[3].Y)
  end
  pointer:update(dt)
end

function menu.keypressed(key)
  if key == "up" and pointer:getValue() > 0 then
  end
  if key == "down" and pointer:getValue() < 2 then
  end

  if 
  key == "x" 
  or key == "rshift" 
  or key == "lshift"
  then
    switchScene(sceneTree.MMenu)
  end
end

function menu:draw()
  
  love.graphics.draw(background)
  love.graphics.draw(love.graphics.newImage("content/System/common/sheet.png"))

  for i = 1, 3 do
    -- Frame
    love.graphics.draw(slotTable[i].image, SlotPositions[i].X, SlotPositions[i].Y, 
    0, 1, 1, slotTable[i].oX, slotTable[i].oY)

    -- File indicator
    love.graphics.print((GLT.localizator.slotMenu[1].. i), 
    slotTable[i].X - 85,
    slotTable[i].Y
    )
    -- Buttons
    love.graphics.printf((GLT.localizator.slotMenu[2]), 
    (slotTable[i].X - 10), 
    (slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 7))) - 11,
    100,
    "right")
    love.graphics.printf((GLT.localizator.slotMenu[3]), 
    (slotTable[i].X - 10), 
    (slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 7))),
    100,
    "right")
  end

  pointer:draw()
end

return menu