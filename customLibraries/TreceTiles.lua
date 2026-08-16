local class_Tilemaker =
{
  image = love.graphics.newImage("content/tileSets/zebra-set-test.png"),
  rows = 9,
  columns = 4,
  set = {},
  map = 
  {
    {20, 20, 20},
    {20, 24, 20},
    {20, 20, 20},
  }
}

function class_Tilemaker:make()

for i = 1, self.rows do
  for j = 1, self.columns do
    table.insert(self.set, love.graphics.newQuad(
    ((j - 1) * 16), ((i - 1) * 16), 16, 16, self.image:getWidth(), 
    self.image:getHeight()))
  end
end

end

function class_Tilemaker:draw()
  for i = 1, #self.map do
    for j = 1, #self.map[i] do
      love.graphics.draw(self.image, self.set[self.map[i][j]], ((j - 1) * 16), ((i - 1) * 16) )
    end
  end
end

local metaClass = {}
metaClass.__index = class_Tilemaker

function class_Tilemaker.new(imagePath, rows, columns, map)
  local instance = setmetatable({}, metaClass)

  instance.image = love.graphics.newImage(imagePath)
  instance.rows = rows
  instance.columns = columns
  instance.map = map
  instance.set = {}

  instance:make()

  return instance
end

return class_Tilemaker