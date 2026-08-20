local FieldTest ={}

local debugTB = GLT.textbox.new({"ALOYSSE", "ÑINGALING"}, 1, 35)

function FieldTest:load()
end

function FieldTest:update(dt)
  debugTB:update(dt)
end

function FieldTest.keypressed(key)
  debugTB:keypressed(key)
  if key == "a" then
    debugTB:setIn({"AWAWA", "LOREM IPÑUM"})
  end
end

function FieldTest:draw()
  debugTB:draw()
end

return FieldTest