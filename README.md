# Shader Effect Of Solar2D
### The repository that synthesizes [Solar2D](https://solar2d.com) shaders made or collected by Kan.
***Note:***
Because I don't use ios, macOS, and Nintendo switch devices, I can't test shaders on these platforms. If you use my shader on these platforms and it works fine then please let me know. <br>
Thanks you very much!

<br>
*- Symbol summary:*
&#x2611; : Supported <br>
&#x2610; : Not test yet <br>
&#x2612; : Unsupported<br>

## Sway Shader

![Sway](https://i.imgur.com/b8xv2Ps.gif)
*- Code:*
```Lua
   require "sway"
   object.fill.effect = "filter.custom.sway"
   object.fill.effect.offset = 0.0 -- make different
   object.fill.effect.heightOffset = 0.6 -- The height where the wind begins to move
   object.fill.effect.distortion = 0.5 -- The strength of geometry distortion.
```
*- Support platforms:*

| OS              |Supported|
| -------------   | ------|
| Android         |&#x2611;|
| ios             |&#x2610;|
| Window          |&#x2611;|
| Mac             |&#x2610;|
| HTML5           |&#x2611;|
| Nintendo Switch |&#x2610;|

