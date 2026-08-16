local Player = 
{
  X = 0,
  Y = 0,
  anim = GLT.Animation.new("content/characters/player.png", 
  4, 2, 2, 0, 0, 0, 8, 16, 16)
}

function Player:update(dt)
  self.anim:update(dt)
end

function Player:draw()
  self.anim:draw()
end

return Player