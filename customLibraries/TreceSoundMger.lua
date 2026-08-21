local sound = 
{
  UI = 
  {
    love.audio.newSource("audio/sdo_menu_arriba.ogg", "static"),
    love.audio.newSource("audio/sdo_menu_abajo.ogg", "static"),
    love.audio.newSource("audio/sdo_menu_selecc.ogg", "static"),
    love.audio.newSource("audio/sdo_menu_pregunta.ogg", "static"),
    love.audio.newSource("audio/sdo_habla_saltarLin.ogg", "static"),
  },
  voice = 
  {
    love.audio.newSource("audio/sdo_habla_estandar.ogg", "static"),
    love.audio.newSource("audio/sdo_habla_Aloysse.ogg", "static"),
  }
}


return sound