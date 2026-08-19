local menu = {}

local background
local frameContainer = {}
local pointer = GLT.Pointer.new(10, 10, 1)
local LUT_Pointer
local LUT_Slots
local location = 0
local fade = GLT.Fade.new("sceneIn", 0, 0, 0, 2)
local deletionProtection

function menu:load()
  background = love.graphics.newImage("content/System/menu_slots/Mountain.png")

  -- Adding the slot frames
  for i = 1, 3 do
    frameContainer[i] =
    {
      image = love.graphics.newImage("content/System/menu_slots/Slot.png"),
      X = 127,
      Y = 20,
      oX = love.graphics.newImage("content/System/menu_slots/Slot.png"):getWidth() / 2,
      oY = love.graphics.newImage("content/System/menu_slots/Slot.png"):getHeight() / 2,
    }
  end

  -- Lookup tables
  LUT_Pointer = 
  {
    {X = 14 * 16, Y = 8 * 8 - 8},
    {X = 14 * 16, Y = 13 * 8 - 8},
    {X = 14 * 16, Y = 18 * 8 - 8},
    {X = 14 * 16 -4, Y = 8 * 8 - 12},
    {X = 14 * 16 -4, Y = 8 * 8 - 2},
    {X = 14 * 16 -4, Y = 13 * 8 - 12},
    {X = 14 * 16 -4, Y = 13 * 8 - 2},
    {X = 14 * 16 -4, Y = 18 * 8 - 12},
    {X = 14 * 16 -4, Y = 18 * 8 - 2},
  }

  LUT_Slots = 
  {
    {X = 8 * 16, Y = 8 * 8 - 8},
    {X = 8 * 16, Y = 13 * 8 - 8},
    {X = 8 * 16, Y = 18 * 8 - 8},
  }

  deletionProtection = 
  {
    {val = 0},
    {val = 0},
    {val = 0},
  }
end

function menu:update(dt)
  for i = 1, #LUT_Pointer do
    if pointer:getValue() == i - 1 then
      pointer:setPos(LUT_Pointer[i].X, LUT_Pointer[i].Y - 4 )
    end
  end
  pointer:update(dt)
  fade:update(dt)
end

function menu.keypressed(key)

  -- Move between options
  if location == 0 then
    if key == "up" and pointer:getValue() > 0 then
      pointer:setValue(math.max(0, pointer:getValue() - 1))
      GLT.sound.UI[1]:clone():play()
    end
    if (key == "down" and pointer:getValue() < 2) then
      pointer:setValue(math.min(2, pointer:getValue() + 1))
      GLT.sound.UI[2]:clone():play()
    end
  elseif location == 1 then

    if key == "up" and pointer:getValue() > 3 then
      pointer:setValue(math.max(2, pointer:getValue() - 1))
      GLT.sound.UI[1]:clone():play()
    end
    if (key == "down" and pointer:getValue() < 4) then
      pointer:setValue(math.min(4, pointer:getValue() + 1))
      GLT.sound.UI[2]:clone():play()
    end

    if (key == "x"  or key == "rshift" or key == "lshift")
    then
      pointer:setValue(0)
      location = 0
      GLT.sound.UI[1]:clone():play()
      return
    end

  elseif location == 2 then

    if key == "up" and pointer:getValue() > 5 then
      pointer:setValue(math.max(5, pointer:getValue() - 1))
      GLT.sound.UI[1]:clone():play()
    end
    if (key == "down" and pointer:getValue() < 6) then
      pointer:setValue(math.min(6, pointer:getValue() + 1))
      GLT.sound.UI[2]:clone():play()
    end

    if (key == "x"  or key == "rshift" or key == "lshift")
    then
      pointer:setValue(1)
      location = 0
      GLT.sound.UI[1]:clone():play()
      return
    end

  elseif location == 3 then

    if key == "up" and pointer:getValue() > 7 then
      pointer:setValue(math.max(7, pointer:getValue() - 1))
      GLT.sound.UI[1]:clone():play()
    end
    if (key == "down" and pointer:getValue() < 8) then
      pointer:setValue(math.min(8, pointer:getValue() + 1))
      GLT.sound.UI[2]:clone():play()
    end

    if (key == "x"  or key == "rshift" or key == "lshift")
    then
      pointer:setValue(2)
      location = 0
      GLT.sound.UI[1]:clone():play()
      return
    end
    
  end

  -- Select
  if (key == "return" or key == "z") then
    if pointer:getValue() == 0 then
      pointer:setValue(3)
      location = 1
      GLT.sound.UI[3]:clone():play()
    elseif pointer:getValue() == 1 then
      pointer:setValue(5)
      location = 2
      GLT.sound.UI[3]:clone():play()
    elseif pointer:getValue() == 2 then
      pointer:setValue(7)
      location = 3
      GLT.sound.UI[3]:clone():play()
    elseif pointer:getValue() == 4 then
      deletionProtection[1].val = deletionProtection [1].val + 1
      if deletionProtection[1].val > 1 then
        deletionProtection[1].val = 0
        GLT.sound.UI[3]:clone():play()
      else
        GLT.sound.UI[4]:play()
      end
    elseif pointer:getValue() == 6 then
      deletionProtection[2].val = deletionProtection [2].val + 1
      if deletionProtection[2].val > 1 then
        deletionProtection[2].val = 0
        GLT.sound.UI[3]:clone():play()
      else
        GLT.sound.UI[4]:play()
      end
    elseif pointer:getValue() == 8 then
      deletionProtection[3].val = deletionProtection [3].val + 1
      if deletionProtection[3].val > 1 then
        deletionProtection[3].val = 0
        GLT.sound.UI[3]:clone():play()
      else
        GLT.sound.UI[4]:play()
      end
    end
  end

  -- Return to main menu
  if 
  (key == "x" 
  or key == "rshift" 
  or key == "lshift") and
  location == 0
  then
    switchScene(sceneTree.MMenu)
    GLT.sound.UI[3]:clone():play()
  end
end

function menu:draw()
  
  love.graphics.draw(background)
  -- love.graphics.draw(love.graphics.newImage("content/System/common/sheet.png"))

  for i = 1, 3 do
    -- Frame
    love.graphics.draw(frameContainer[i].image, LUT_Slots[i].X, LUT_Slots[i].Y, 
    0, 1, 1, frameContainer[i].oX, frameContainer[i].oY)

    -- File indicator
    love.graphics.print((GLT.localizator.slotMenu[1].. i), 
    LUT_Slots[i].X - 90,
    LUT_Slots[i].Y - 12
    )
     -- Buttons
    if deletionProtection[i].val == 0 then
      love.graphics.printf(
      GLT.localizator.slotMenu[3], 
      LUT_Slots[i].X - 10,
      LUT_Slots[i].Y,
      100,
      "right"
      )
    elseif deletionProtection[i].val == 1 then
      love.graphics.setColor(1, 0, 0)
      love.graphics.printf(
      GLT.localizator.slotMenu[5], 
      LUT_Slots[i].X - 90,
      LUT_Slots[i].Y,
      180,
      "right"
      )
      love.graphics.setColor(1, 1, 1)
    end
    
    love.graphics.printf(
    GLT.localizator.slotMenu[2], 
    LUT_Slots[i].X - 10,
    LUT_Slots[i].Y - 10,
    100,
    "right"
    )
  end
  love.graphics.print(GLT.localizator.slotMenu[4], 4 * 8 , 20 * 8)
  pointer:draw()
  fade:draw()
end

return menu