local class_Textbox = 
{
  MODE = 1,

  -- Graphic related
  image_frame = love.graphics.newImage("content/System/common/TextBox.png"),
  image_indicator = love.graphics.newImage("content/System/common/TextBox_indicator.png"),

  -- Line related
  line_table = 
  {
    "PRIMER TEXTO", 
    "SEGUNDO TEXTO", 
    "TERCER TEXTO"
  },
  line_idx = 1,
  line_shown = "",

  -- Option related
  OP_OPTION1 = "YES",
  OP_OPTION2 = "NO",
  OP_Variable = 0,
  OP_Ptr = love.graphics.newImage("content/System/common/Pointy.png"),
  OP_OPTION = 0,

  -- Display
  Display_isDisplaying = false,
  Display_Position = 0,
  Display_Speed = 30,
  
  -- Internal
  INTERNAL_letterIdx = 0,
  INTERNAL_voiceCtrl = 0,
  INTERNAL_Clock_IdxCtrl = 0,
  INTERNAL_Clock_IndAnim = 0,
  INTERNAL_utf8 = require("utf8"),
  INTERNAL_byteoffset = nil
}

function class_Textbox:setIn(tabla, modo, pos)
  self.MODE = modo
  self.Display_Position = pos
  if tabla ~= nil then
    self.line_table = tabla
  end

  self.line_idx = 1
  self.INTERNAL_letterIdx = 0
  self.INTERNAL_byteoffset = nil
  self.Display_isDisplaying = true
end

function class_Textbox:setOut()
  self.line_shown = ""
  self.Display_isDisplaying = false
end

function class_Textbox:OPTIOND(option)
  self.OPTION = option or self.OPTION
  return self.OPTION
end

function class_Textbox:update(dt)
  if self.Display_isDisplaying then
    if self.MODE == 0 then
      -- Advance clock
      if self.line_shown ~= self.line_table[self.line_idx] then
        self.INTERNAL_Clock_IdxCtrl = self.INTERNAL_Clock_IdxCtrl + (self.Display_Speed * dt )
        self.INTERNAL_Clock_IndAnim = 0
      else
        -- Control the animation of the indicator
        self.INTERNAL_Clock_IndAnim = self.INTERNAL_Clock_IndAnim + (2 * dt )
        if self.INTERNAL_Clock_IndAnim > 2 then
          self.INTERNAL_Clock_IndAnim = 0
        end
      end
      -- Adjust letter index
      self.INTERNAL_letterIdx = math.floor(self.INTERNAL_Clock_IdxCtrl)

      -- Play voice sample
      if self.INTERNAL_voiceCtrl ~= self.INTERNAL_letterIdx and self.INTERNAL_letterIdx % 2 == 0 then
        GLT.sound.voice[2]:clone():play()
        self.INTERNAL_voiceCtrl = self.INTERNAL_letterIdx
      end
      
      -- Make the shown text be shown as index advances
      self.INTERNAL_byteoffset = self.INTERNAL_utf8.offset(self.line_table[self.line_idx], self.INTERNAL_letterIdx)
      if  self.INTERNAL_byteoffset and self.line_shown ~= self.line_table[self.line_idx] then
        self.line_shown = string.sub(self.line_table[self.line_idx], 1, self.INTERNAL_byteoffset - 1)  
      end

    elseif self.MODE == 1 then
      self.line_shown = ("\n    " .. self.OP_OPTION1 .. "\n    " .. self.OP_OPTION2)
    end

  end
end

function class_Textbox:keypressed(key)

  if self.Display_isDisplaying then
    if self.MODE == 0 then

      -- Advancing text
      if (self.Display_isDisplaying) and 
      (self.line_shown == self.line_table[self.line_idx]) and 
      (key == "z" or key == "return" ) then
        -- Reseting the most advanced letter index to 0
        self.INTERNAL_letterIdx = 0
        self.INTERNAL_Clock_IdxCtrl = 0

        -- Checking whether if close the textbox or advance to the next line
        if self.line_table[self.line_idx + 1] ~= nil then
          self.line_idx = self.line_idx + 1
        else 
          self:setOut()
        end
      end

      -- Skipping scrolling text
      if (self.Display_isDisplaying) and 
      (self.line_shown ~= self.line_table[self.line_idx]) and 
      (key == "x" or key == "rshift" or key == "lshift" ) then
        -- Equalizing the lines content
        self.line_shown = self.line_table[self.line_idx] 
        GLT.sound.voice[1]:play()
      end

    elseif self.MODE == 1 then
      if key == "down" and self.OP_Variable == 0 then
        self.OP_Variable = 1
        GLT.sound.UI[2]:play()
      elseif key == "up" and self.OP_Variable == 1 then
        self.OP_Variable = 0
        GLT.sound.UI[1]:play()
      end
      if (key == "return" or key == "z") and self.OP_Variable == 0 then
        GLT.sound.UI[3]:play()
        self:OPTIOND(1)
      elseif (key == "return" or key == "z") and self.OP_Variable == 1 then
        GLT.sound.UI[3]:play()
        self:OPTIOND(2)
      end
    end
  end

end

function class_Textbox:draw()
  --Checking which position textbox is in
  if self.Display_isDisplaying then
    
    if self.Display_Position == 0 then
      -- Drawing the frame
      love.graphics.draw(self.image_frame, 16, 176)
      -- Drawing text
      love.graphics.printf(self.line_shown, 22, 180, 210, "left")

      if self.MODE == 0 then

        -- Checking for drawing the indicator
        if self.line_shown == self.line_table[self.line_idx] then
          love.graphics.draw(self.image_indicator, 125, 214 + math.floor(self.INTERNAL_Clock_IndAnim))
        end

      elseif self.MODE == 1 then

        -- Drawing pointer
        if self.OP_Variable == 0 then
          love.graphics.draw(self.OP_Ptr, 40, 190, 0, -1, 1)
        elseif self.OP_Variable == 1 then
          love.graphics.draw(self.OP_Ptr, 40, 200, 0, -1, 1)
        end
        
      end
      

    elseif self.Display_Position == 1 then
      -- Drawing the frame
      love.graphics.draw(self.image_frame, 16, 0)

      if self.MODE == 0 then
        -- Drawing text
        love.graphics.printf(self.line_shown, 22, 4, 210, "left")
        -- Checking for drawing the indicator
        if self.line_shown == self.line_table[self.line_idx] then
          love.graphics.draw(self.image_indicator, 125, 38 + math.floor(self.INTERNAL_Clock_IndAnim))
        end

      elseif self.MODE == 1 then

        -- Drawing text
        love.graphics.printf(self.line_shown, 22, 4, 210, "left")
        -- Drawing pointer
        if self.OP_Variable == 0 then
          love.graphics.draw(self.OP_Ptr, 40, 14, 0, -1, 1)
        elseif self.OP_Variable == 1 then
          love.graphics.draw(self.OP_Ptr, 40, 23, 0, -1, 1)
        end

      end

    end

  end

end

local metaClass = {}
metaClass.__index = class_Textbox

function class_Textbox.new(lines, position, mode, speed)
  local instance = setmetatable({}, metaClass)

  instance.Display_Position = position
  instance.line_table = lines
  instance.MODE = mode
  instance.Display_Speed = speed

  return instance
end

return class_Textbox