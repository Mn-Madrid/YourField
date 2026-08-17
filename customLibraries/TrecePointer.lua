local class_Pointer = 
{
  image = love.graphics.newImage("content/System/common/Pointy.png"),
  X = 0,
  Y = 0,
  offset = 0,
  newX = 0,
  value = 0,
  clock = 0,
  size = 1
}

-- General functions
function class_Pointer:update(dt)

  self.newX = self.X - self.offset

  self.clock = self.clock + (2 * dt)
  if self.clock > 2 then
    self.clock = 0
  end

  if self.size == 1 then
    if self.clock < 1 then
      self.offset = 1
    else
      self.offset = 0
    end
  elseif self.size == -1 then
    if self.clock < 1 then
      self.offset = -1
    else
      self.offset = 0
    end
  end

end

function class_Pointer:draw()
  love.graphics.draw(self.image, self.newX, self.Y, 0, self.size, 1)
end

-- Getters and setters
function class_Pointer:getValue()
  return self.value
end

function class_Pointer:setValue(value)
  self.value = value
  self.offset = 0
  self.clock = 1
end

function class_Pointer:getPos()
  return self.X, self.Y
end

function class_Pointer:setPos(X, Y)
  self.X, self.Y = X, Y
end

function class_Pointer:getClock()
  return self.clock
end

function class_Pointer:setClock(value)
  self.clock = value
end

-- OOP
local metaClass = {}
metaClass.__index = class_Pointer

function class_Pointer.new(X, Y, size)
  local instance = setmetatable({}, metaClass)

  instance.X = X
  instance.Y = Y
  instance.size = size

  return instance
end

return class_Pointer