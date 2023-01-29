display.setDefault( 'isShaderCompilerVerbose', true ) -- Important

display.setStatusBar( display.HiddenStatusBar )

local maskCamView = graphics.newMask("mask_television.jpeg")

local camView = display.newImage("map.png", 160, 108)
camView:setMask(maskCamView)
camView.x, camView.y = display.contentCenterX, display.contentCenterY


require "crt"

camView.fill.effect = "filter.custom.crt"

local television = display.newImage("television.png", 160, 108)

television.x, television.y = display.contentCenterX, display.contentCenterY