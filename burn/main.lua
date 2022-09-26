local bg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
local pirate = display.newImageRect("pirate.png", 200, 200)

pirate.x, pirate.y = display.contentCenterX, display.contentCenterY


local platform = system.getInfo("platform")
local env = system.getInfo("environment")

if (platform == "android" or platform == "ios") and env == "device" then
    require "burn_mobile"

    timer.performWithDelay(2500, function()

        pirate.fill = {
            type = "composite",
            paint1 = { type = "image", filename = "pirate.png" },
            paint2 = { type = "image", filename = "noise.jpg" }
        }

        pirate.fill.effect = "filter.custom.burn"
        pirate.fill.effect.startTime = system.getTimer() / 1000
        pirate.fill.effect.duration = 2.0
        graphics.undefineEffect("filter.custom.burn")
    end, -1)
else
    require "burn"

    timer.performWithDelay(2500, function()

        pirate.fill.effect = "filter.custom.burn"
        pirate.fill.effect.startTime = system.getTimer() / 1000
        pirate.fill.effect.duration = 2.0
        graphics.undefineEffect("filter.custom.burn")
    end, -1)
end
