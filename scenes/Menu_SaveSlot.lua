local menu = {}

local content = 
{
  background = love.graphics.newImage("content/System/menu_slots/Mountain.png"),
}

local slotTable = {}

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

function menu:load()
  
end

function menu:update(dt)
  
end

function menu.keypressed(key)

end

function menu:draw()
  
  love.graphics.draw(content.background)
  for i = 1, 3 do
    love.graphics.draw(slotTable[i].image, slotTable[i].X, slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 10)), 
    0, 1, 1, slotTable[i].oX, slotTable[i].oY)

    love.graphics.print((GLT.localizator.slotMenu[1].. i), 
    (slotTable[i].X - 89), 
    (slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 10))) - 11)

    love.graphics.printf((GLT.localizator.slotMenu[2]), 
    (slotTable[i].X - 10), 
    (slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 10))) - 11,
    100,
    "right")
    love.graphics.printf((GLT.localizator.slotMenu[3]), 
    (slotTable[i].X - 10), 
    (slotTable[i].Y + (i * (slotTable[i].image:getHeight() + 10))),
    100,
    "right")
  end
end

return menu