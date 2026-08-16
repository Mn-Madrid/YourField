local Player = 
{
  X = (16*4),
  Y = (16*7),
  anim = GLT.Animation.new("content/characters/player.png", 
  4, 2, 2, 0, 0, 0, 8, 16, 16),
  targetX = (16*4),
  targetY = (16*7),
  oldX = (16*4),
  oldY = (16*7),
  map = GLT.Tiles.new("content/tileSets/zebra-set-test.png", 10, 4, 
  {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
    {0, 0, 0, 0, 0, 0, 0, 0, 21, 22, 22, 22, 22, 22, 22, 23,},
    {0, 0, 0, 0, 0, 0, 0, 0, 29, 30, 30, 30, 30, 30, 30, 31,},
    {0, 21, 22, 22, 22, 22, 23, 0, 2, 3, 4, 3, 4, 2, 3, 4,},
    {0, 25, 26, 26, 26, 26, 27, 0, 26, 26, 26, 26, 26, 26, 26, 26,},
    {0, 29, 30, 30, 30, 30, 31, 0, 2, 3, 4, 3, 4, 2, 3, 4,},
    {0, 9, 11, 3, 2, 4, 2, 0, 26, 26, 26, 26, 26, 26, 26, 26,},
    {0, 26, 26, 26, 26, 26, 26, 0, 2, 3, 4, 3, 4, 2, 3, 4,},
    {0, 9, 11, 2, 4, 3, 2, 0, 26, 26, 26, 26, 26, 26, 26, 26,},
    {0, 26, 26, 26, 26, 26, 26, 0, 2, 3, 4, 3, 4, 2, 3, 4},
    {0, 9, 11, 4, 3, 2, 4, 0, 26, 26, 26, 26, 26, 26, 26, 26}
  }),
  walkableTiles = {16, 24, 30, 32}
}

function Player:move(direction)
  if     direction == 1 then
    self.targetX = self.targetX + 16

  elseif direction == 2 then
    self.targetX = self.targetX - 16

  elseif direction == 3 then
    self.targetY = self.targetY + 16

  elseif direction == 4 then
    self.targetY = self.targetY - 16
    
  end  
end

function Player:getTgX()
  return self.targetX
end
function Player:getTgY()
  return self.targetY
end

function Player:update(dt)
  -- Collision handling
  for i = 1, #self.walkableTiles do
    local mike = self.walkableTiles[i]

    if self.map.map[self.targetX / 16][self.targetY / 16] == mike then
      self.targetX, self.targetY = self.oldX, self.oldY
    end

  end
  -- Movement (Input)
  if
  (love.keyboard.isDown("right")) and 
  (self.X == self.targetX) and
  (self.Y == self.targetY)
  then
    self:move(1)
  end
  if 
  (love.keyboard.isDown("left")) and 
  (self.X == self.targetX) and
  (self.Y == self.targetY)
  then
    self:move(2)
  end
  if 
  (love.keyboard.isDown("up")) and 
  (self.Y == self.targetY) and
  (self.X == self.targetX)
  then
    self:move(4)
  end
  if 
  (love.keyboard.isDown("down")) and 
  (self.Y == self.targetY) and
  (self.X == self.targetX)
  then
    self:move(3)
  end

  -- Movement (Animation)
    -- Horz
  if self.targetX > self.X then
    self.X = math.min(self.targetX,self.X + (32 * dt))
    self.anim:setAnimation(3)
    self.anim:is_Playing(true)
  elseif self.targetX < self.X then
    self.X = math.max(self.targetX, self.X - (32 * dt))
    self.anim:setAnimation(4)
    self.anim:is_Playing(true)
  end
    -- Vert
  if self.targetY > self.Y then
    self.Y = math.min(self.targetY,self.Y + (32 * dt))
    self.anim:setAnimation(1)
    self.anim:is_Playing(true)
  elseif self.targetY < self.Y then
    self.Y = math.max(self.targetY, self.Y - (32 * dt))
    self.anim:setAnimation(2)
    self.anim:is_Playing(true)
  end
    -- Animation check
  if 
  (self.X == self.targetX) and 
  (self.Y == self.targetY) 
  then
    self.anim:is_Playing(false)
    self.anim:goToFrame(1)
    self.oldX, self.oldY = self.X, self.Y
  end

  -- General check
  self.anim.X = self.X
  self.anim.Y = self.Y
  self.anim:update(dt)

end

function Player:keypressed(key)
end

function Player:draw()
  self.anim:draw()
end

return Player