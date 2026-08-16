-- Class definition
local class_Fade =
{
  r = 1,
  g = 1,
  b = 1,
  a = 0,
  spd = 1,
  mode = "sceneOut"
}

-- Exclusive functions
function class_Fade:setColor(r, g, b)
  self.r = r
  self.g = g
  self.b = b
end

function class_Fade:setStatus(string)

  if (string ~= "sceneOut") and (string ~= "sceneIn") then
    return
  else

    if (string == "sceneIn") then
      self.a = 1
    elseif (string == "sceneOut") then
      self.a = 0
    end

    self.mode = string
  end

end

-- General functions
function class_Fade:update(dt)

  -- Get the timer working
  if self.mode == "sceneOut" then

    if self.a < 1 then
      self.a = self.a + (self.spd * dt)
    end

  elseif self.mode == "sceneIn" then

    if self.a > 0 then
      self.a = self.a - (self.spd * dt)
    end

  end

end

function class_Fade:draw()
  love.graphics.setColor(self.r, self.g, self.b, self.a)
  love.graphics.rectangle("fill", 0, 0, 256, 224)
  love.graphics.setColor(1, 1, 1, 1)
end

-- Constructor function

local metaClass = {}
metaClass.__index = class_Fade

function class_Fade.new(mode, r, g, b, speed)
  local instance = setmetatable({}, metaClass)

  if (mode ~= "sceneOut") and (mode ~= "sceneIn") then
    instance.a = 0
    instance.mode = "sceneOut"
  elseif (mode == "sceneIn") then
    instance.a = 1
    instance.mode = "sceneIn"
  elseif (mode == "sceneOut") then
    instance.a = 0
    instance.mode = "sceneOut"
  end

  instance.r = r
  instance.g = g
  instance.b = b
  instance.spd = speed

  return instance
end

return class_Fade