local FieldTest ={}

local debugTB = GLT.textbox.new({"ALOYSSE", "ÑINGALING"}, 1, 1, 35)

function FieldTest:load()
end

function FieldTest:update(dt)
  debugTB:update(dt)
  if debugTB:OPTIOND() == 1 then
    print("UP")
    debugTB.OPTION = 0
    debugTB:setOut()
    debugTB:setIn({"WHATS UP BRO", "HOW IS IT HANGIN"}, 0, 0)
  elseif debugTB:OPTIOND() == 2 then
    print("DOWN")
    debugTB.OPTION = 0
    debugTB:setOut()
  end
end

function FieldTest.keypressed(key)
  debugTB:keypressed(key)
  if key == "a" then
    debugTB:setIn({"AWAWA", "LOREM IPÑUM"}, 1, 1)
  end
end

function FieldTest:draw()
  debugTB:draw()
end

return FieldTest