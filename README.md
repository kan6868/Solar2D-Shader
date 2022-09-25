# Shader Effect Of Solar2D
### The repository that synthesizes [Solar2D](https://solar2d.com) shaders made or collected by Kan.
***Note***
*Because I don't use ios, macOS, and Nintendo switch devices, I can't test shaders on these platforms. If you use them on these platforms and they work well then please let me know.
Thanks you very much!*

<br>
* &#x2611; : Supported
* &#x2610; : Not test yet 
* &#x2612; : Unsupported

## Sway Shader
![Sway](https://i.imgur.com/b8xv2Ps.gif)


```Lua
   require "sway"
   object.fill.effect = "filter.custom.sway"
   object.fill.effect.offset = 0.0 -- make different
   object.fill.effect.heightOffset = 0.6 -- The height where the wind begins to move
   object.fill.effect.distortion = 0.5 -- The strength of geometry distortion.
```
*Support platforms*

| OS              | Support       |
| -------------   | --------------|
| Android         |&check;|
| ios             |Not tested yet|
| Window          |&check;|
| Mac             |Not tested yet|
| HTML5           |&check;|

