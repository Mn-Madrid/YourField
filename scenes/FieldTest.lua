local FieldTest ={}

local Player = GOT.player

function FieldTest:load()

end

function FieldTest:update(dt)
  Player:update(dt)
end

function FieldTest.keypressed(key)
  Player:keypressed(key)
end

function FieldTest:draw()
  Player:draw()
end

return FieldTest