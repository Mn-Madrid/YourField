local class_Textbox = 
{
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

  -- Display
  Display_isDisplaying = false,
  Display_Position = 1,
  Display_Speed = 30,
  
  -- Internal
  INTERNAL_letterIdx = 0,
  INTERNAL_voiceCtrl = 0,
  INTERNAL_Clock_IdxCtrl = 0,
  INTERNAL_Clock_IndAnim = 0,
  INTERNAL_utf8 = require("utf8"),
  INTERNAL_byteoffset = nil
}

function class_Textbox:setIn(tabla)
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

function class_Textbox:update(dt)
  if self.Display_isDisplaying then

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

  end
end

function class_Textbox:keypressed(key)

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

  if (self.Display_isDisplaying) and 
  (self.line_shown ~= self.line_table[self.line_idx]) and 
  (key == "x" or key == "rshift" or key == "lshift" ) then
    -- Equalizing the lines content
    self.line_shown = self.line_table[self.line_idx] 
    GLT.sound.voice[1]:play()
  end

end

function class_Textbox:draw()
  if self.Display_isDisplaying then
    --Checking which position textbox is in
    if self.Display_Position == 1 then

      -- Drawing the frame and text
      love.graphics.draw(self.image_frame, 16, 176)
      love.graphics.printf(self.line_shown, 22, 180, 210, "left")

      -- Checking for drawing the indicator
      if self.line_shown == self.line_table[self.line_idx] then
        love.graphics.draw(self.image_indicator, 125, 214 + math.floor(self.INTERNAL_Clock_IndAnim))
      end

    elseif self.Display_Position == 2 then

      -- Drawing the frame and text
      love.graphics.draw(self.image_frame, 16, 0)
      love.graphics.printf(self.line_shown, 22, 4, 210, "left")

      -- Checking for drawing the indicator
      if self.line_shown == self.line_table[self.line_idx] then
        love.graphics.draw(self.image_indicator, 125, 38 + math.floor(self.INTERNAL_Clock_IndAnim))
      end

    end
  end

end

local metaClass = {}
metaClass.__index = class_Textbox

function class_Textbox.new(lines, position, speed)
  local instance = setmetatable({}, metaClass)

  instance.line_table = lines
  instance.Display_Position = position
  instance.Display_Speed = speed

  return instance
end

return class_Textbox