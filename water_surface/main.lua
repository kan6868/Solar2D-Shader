--[[
  *
        require "surface"
        object.fill.effect = "filter.custom.surface"
]]
display.setDefault( 'isShaderCompilerVerbose', true )
local shader_surface = require("surface")
graphics.defineEffect( shader_surface )

local object = display.newImageRect("imag1.png", 300, 300)
object.x = display.contentCenterX
object.y = display.contentCenterY

object.fill = {
  type = "composite",
  paint1 = { type="image", filename="imag1.png" },
  paint2 = { type="image", filename="noise.png" }
}

object.fill.effect = "filter.custom.surface"
object.fill.effect.speed = 0.025
object.fill.effect.scale = 0.25
object.fill.effect.intensity = 0.035
object.fill.effect.opacity = 0.12
