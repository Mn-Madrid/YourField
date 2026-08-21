local FieldTest ={}

local debugTB = GLT.textbox.new({"ALOYSSE", "ÑINGALING"}, "B", 1, 35, "JOHAN")

function FieldTest:load()
end

function FieldTest:update(dt)
  debugTB:update(dt)
  if debugTB:OPTIOND() == 1 then
    debugTB.OPTION = 0
    debugTB:setOut()
    debugTB:setIn({"WHATS UP BRO", "HOW IS IT HANGIN"}, "A", 0, "")
  elseif debugTB:OPTIOND() == 2 then
    debugTB.OPTION = 0
    debugTB:setOut()
  end
end

function FieldTest.keypressed(key)
  debugTB:keypressed(key)
  if key == "a" then
    debugTB:setIn({"AWAWA", "LOREM IPÑUM"}, "B", 0)
  end
end

function FieldTest:draw()
  debugTB:draw()
end

return FieldTest