require "sway"

display.setDefault("magTextureFilter", "nearest")
display.setDefault("minTextureFilter", "nearest")

local tree = display.newImageRect("tree.png", 37*3, 49*3)
tree.x, tree.y = display.contentCenterX, display.contentCenterY


local tree2 = display.newImageRect("tree.png", 37*3, 49*3)
tree2.x, tree2.y = display.contentCenterX + 50, display.contentCenterY + 30

local tree3 = display.newImageRect("tree.png", 37*3, 49*3)
tree3.x, tree3.y = display.contentCenterX - 70, display.contentCenterY + 30


tree.fill.effect = "filter.custom.sway"
tree2.fill.effect = "filter.custom.sway"
tree2.fill.effect.offset = 3.0

tree3.fill.effect = "filter.custom.sway"
tree3.fill.effect.offset = 2.0
