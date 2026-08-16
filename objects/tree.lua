local class_Tree =
{
  image = love.graphics.newImage("content/tests/tree.png"),
  X = 0,
  Y = 0,
  oX = 31,
  oY = 60
}

function class_Tree:update(dt)
end

function class_Tree:draw()
  love.graphics.draw(self.image, self.X, self.Y, 0, 1, 1, self.oX, self.oY)
end

local metaTree = {}
metaTree.__index = class_Tree

function class_Tree.new(X, Y)
  local instance = setmetatable({}, metaTree)

  instance.X = X
  instance.Y = Y

  return instance
end

return class_Tree