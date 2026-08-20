local FieldTest ={}

local debugTB = GLT.textbox

function FieldTest:load()
end

function FieldTest:update(dt)
  debugTB:update(dt)
end

function FieldTest.keypressed(key)
  debugTB:keypressed(key)
end

function FieldTest:draw()
  debugTB:draw()
end

return FieldTest