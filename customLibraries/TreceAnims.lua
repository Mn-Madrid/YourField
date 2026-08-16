local class_Animator = 
{
  image = love.graphics.newImage("content/characters/player.png"),
  -- Object relative
  X =     10,   Y =      20,
  oX =     8,   oY =     16,
  -- Quad relative
  xSize = 16,   ySize =  16,
  rows =   4,   columns = 2,
  -- Animation relative
  spd =    4,   clock =   0,
  cFrame = 1,   cAnim =   1,
  -- Frame storage
  grid = {},
  -- Method relative
  isPlaying = true;
}

-- Methods
function class_Animator:is_Playing(bool)
  self.isPlaying = bool
end

function class_Animator:goToFrame(frame)
  self.cFrame = frame
  self.clock = 0
end

function class_Animator:setAnimation(number)
  self.cAnim = number
  self.cFrame = 1
end

-- Inner functions
function class_Animator:createObject()
  -- Creates a subtable per number of rows 
  for i = 1, self.rows do
    self.grid[i] = {}
  end
  -- Adds a quad in each position
  for i = 1, self.columns do
    for j = 1, self.rows do
        self.grid[j][i] = love.graphics.newQuad(((i - 1) * self.xSize), ((j - 1) * self.ySize), 
        self.xSize, self.ySize, self.image:getWidth(), self.image:getHeight())
    end
  end
end

-- General functions
function class_Animator:update(dt)
  --[[ Debug movement
  if love.keyboard.isDown("down") then
    self.Y = self.Y + 40 * dt
  end
  if love.keyboard.isDown("up") then
    self.Y = self.Y - 40 * dt
  end
  if love.keyboard.isDown("left") then
    self.X = self.X - 40 * dt
  end
  if love.keyboard.isDown("right") then
    self.X = self.X + 40 * dt
  end
  ]]

  if self.isPlaying == true then
    self.clock =  self.clock + (self.spd * dt)
  end
  if self.clock > 1 then
      self.cFrame = self.cFrame + 1
      self.clock = 0
    end

  if self.cFrame > self.columns then
    self.cFrame = 1
  end

end

function class_Animator:draw()
  love.graphics.draw(self.image, self.grid[self.cAnim][self.cFrame], 
  math.floor(self.X), math.floor(self.Y), 0, 1, 1, math.floor(self.oX), math.floor(self.oY))
end

-- Instance creator
local metaClass = {}
metaClass.__index = class_Animator

function class_Animator.new(imagePath, rows, columns, speed, X, Y, oX, oY, qW, qH)
  local instance = setmetatable({}, metaClass)

  instance.image = love.graphics.newImage(imagePath)
  instance.rows = rows
  instance.columns = columns
  instance.speed = speed
  instance.X = X
  instance.Y = Y
  instance.oX = oX
  instance.oY = oY
  instance.xSize = qW
  instance.ySize = qH
  instance.grid = {}
  instance.isPlaying = true
  instance:createObject()

  return instance
  
end

return class_Animator