-- Class definition

local class_Timer =
{
  currentValue = 0;
  endsIn = 10;
  loops = true;
}

-- General functions

function class_Timer:update(dt)
  if self.endsIn > self.currentValue then
    self.currentValue = self.currentValue + (dt)
  else

    if self.loops then
      self.currentValue = 0
    end

  end
end

-- Constructor function

local metaClass = {}
metaClass.__index = class_Timer

function class_Timer.new(endsAt, loops)
  local newInstance = setmetatable({}, metaClass)

  newInstance.endsIn = endsAt
  newInstance.loops = loops

  return newInstance
end

return class_Timer