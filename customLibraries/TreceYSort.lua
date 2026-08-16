local class_YSort = 
{
  contentTable = {}
}

function class_YSort:draw()
  table.sort(self.contentTable, function (a, b)
    return a.Y < b.Y
  end)
  
  for i = 1, #self.contentTable do
    self.contentTable[i]:draw()
  end

end

function class_YSort:keypressed(key)
  for i = 1, #self.contentTable do
    self.contentTable[i]:keypressed(key)
  end
end

function class_YSort:update(dt)
  for i = 1, #self.contentTable do
    self.contentTable[i]:update(dt)
  end
end


local metaClass = {}
metaClass.__index = class_YSort

function class_YSort.new(contentTable)
  local instance = setmetatable({}, metaClass)
  
  instance.contentTable = contentTable
  
  return instance
end

return class_YSort