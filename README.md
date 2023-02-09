# Shader Effect Of Solar2D
### The repository that synthesizes [Solar2D](https://solar2d.com) shaders made or collected by Kan.
***Note:***
Because I don't use Ios, macOS, Linux and Nintendo switch devices, I can't test shaders on these platforms. If you use my shader on these platforms and it works fine then please let me know. <br>
Thanks you very much!

<br>

**- Symbol summary:**
<br>
| Symbol    | Describe     |
|-----------|--------------|
|&#x2611;   | Supported    |
|&#x2610;   | Not test yet |
|&#x2612;   | Unsupported  |

**- List of shaders:**
<br>
- [Sway](#sway-shader)
- [Burn](#burn-shader)
- [CRT](#crt-shader)
<br>

## Sway Shader

![Sway](https://i.imgur.com/b8xv2Ps.gif)
<br>
*- Lua code:*
```Lua
   require "sway"
   object.fill.effect = "filter.custom.sway"
   object.fill.effect.offset = 0.0 -- make different
   object.fill.effect.heightOffset = 0.6 -- The height where the wind begins to move
   object.fill.effect.distortion = 0.5 -- The strength of geometry distortion.
```
*- Support platforms:*

| OS/Platform     |Supported|
| -------------   | ------ |
| Android         |&#x2611;|
| Ios             |&#x2611;|
| Window          |&#x2611;|
| Mac             |&#x2611;|
| Linux           |&#x2610;|
| HTML5           |&#x2611;|
| Nintendo Switch |&#x2611;|


## Burn Shader

![Burn](https://i.imgur.com/Z0NW4tN.gif)
<br>

- For mobile devices need to add 1 texture noise.

*- Lua code:*
```Lua
   --Mobile version
   object.fill = {
      type = "composite",
      paint1 = { type = "image", filename = "image.png" },
      paint2 = { type = "image", filename = "noise.jpg" }
   }

   require "burn_mobile"

   object.fill.effect = "filter.custom.burn"
   object.fill.effect.startTime = system.getTimer() / 1000
   object.fill.effect.duration = 2.0
```

<br>

```Lua
   --Other version (not need noise texture)
   require "burn"
   object.fill.effect = "filter.custom.burn"
   object.fill.effect.startTime = system.getTimer()/1000
   object.fill.effect.duration = 2.0
```
*- Support platforms:*

| OS/Platform     |Supported|
| -------------   | ------ |
| Android         |&#x2611;|
| Ios             |&#x2611;|
| Window          |&#x2611;|
| Mac             |&#x2611;|
| Linux           |&#x2610;|
| HTML5           |&#x2612;|
| Nintendo Switch |&#x2611;|

## CRT Shader

![CRT](https://user-images.githubusercontent.com/70838508/215328995-63515cca-4582-4ebf-8b31-c1d14330e63b.gif)

<br>

```Lua
        require "crt"
        object.fill.effect = "filter.custom.crt"
```
*- Support platforms:*

| OS/Platform     |Supported|
| -------------   | ------ |
| Android         |&#x2611;|
| Ios             |&#x2611;|
| Window          |&#x2611;|
| Mac             |&#x2611;|
| Linux           |&#x2610;|
| HTML5           |&#x2612;|
| Nintendo Switch |&#x2611;|

Ref: https://godotshaders.com/shader/vhs-and-crt-monitor-effect/;

## Sponsor this project
- Support me via [Patreon](https://www.patreon.com/kandev).
- Gift me a coffee cup: Ko-fi.com/kandev

