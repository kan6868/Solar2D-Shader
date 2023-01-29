--[[
  *
        require "crt"
        object.fill.effect = "filter.custom.crt"
]]

local kernel = {}

kernel.language = "glsl"
kernel.category = "filter"

kernel.name = "crt"

kernel.isTimeDependent = true

kernel.fragment = [[
     P_DEFAULT float scanlines_opacity = 0.25;
     P_DEFAULT float scanlines_width = 0.1;
     P_DEFAULT float grille_opacity = 0.3;
     
     P_DEFAULT vec2 resolution = vec2(300.0, 256.0); // Set the number of rows and columns the texture will be divided in. Scanlines and grille will make a square based on these values

     P_DEFAULT float roll_speed = 4.0; // Positive values are down, negative are up
     P_DEFAULT float roll_size = 15.0;
     P_DEFAULT float roll_variation= 1.8; // This valie is not an exact science. You have to play around with the value to find a look you like. How this works is explained in the code below.
     P_DEFAULT float distort_intensity = 0.05; // The distortion created by the rolling effect.

     P_DEFAULT float noise_opacity = 0.6;
     P_DEFAULT float noise_speed = 5.0; // There is a movement in the noise pattern that can be hard to see first. This sets the speed of that movement.

     P_DEFAULT float static_noise_intensity = 0.18;

     P_DEFAULT float aberration = 0.03; // Chromatic aberration, a distortion on each color channel.
     P_DEFAULT float brightness = 1.4; // When adding scanline gaps and grille the image can get very dark. Brightness tries to compensate for that.
     P_DEFAULT float discolor = 1.0; //1.0 = true, 0.0 = false // Add a discolor effect simulating a VHS

     P_DEFAULT float warp_amount = 3.0; // Warp the texture edges simulating the curved glass of a CRT monitor or old TV.
     P_DEFAULT float clip_warp = 1.0; //1.0 = true, 0.0 = false

     P_DEFAULT float vignette_intensity = 0.4; // Size of the vignette, how far towards the middle it should go.
     P_DEFAULT float vignette_opacity = 0.5;
    
    P_DEFAULT vec2 random(P_DEFAULT vec2 uv){
        uv = vec2( dot(uv, vec2(127.1,311.7) ),
                   dot(uv, vec2(269.5,183.3) ) );
        return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
    }
    
    P_DEFAULT float noise(P_DEFAULT vec2 uv) {
      P_DEFAULT vec2 uv_index = floor(uv);
      P_DEFAULT vec2 uv_fract = fract(uv);
    
      P_DEFAULT vec2 blur = smoothstep(0.0, 1.0, uv_fract);
    
        return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                         dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                    mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                         dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) * 0.5 + 0.5;
    }
    
    P_DEFAULT vec2 warp(P_DEFAULT vec2 uv){
      P_DEFAULT vec2 delta = uv - 0.5;
      P_DEFAULT float delta2 = dot(delta.xy, delta.xy);
      P_DEFAULT float delta4 = delta2 * delta2;
      P_DEFAULT float delta_offset = delta4 * warp_amount;
      
      return uv + delta * delta_offset;
    }
    
    P_DEFAULT float border (P_DEFAULT vec2 uv){
      P_DEFAULT float radius = min(warp_amount, 0.08);
      radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5);
      P_DEFAULT vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius;
      P_DEFAULT float dist = length(max(vec2(0.0), abs_uv)) / radius;
      P_DEFAULT float square = smoothstep(0.96, 1.0, dist);
      return clamp(1.0 - square, 0.0, 1.0);
    }
    
    P_DEFAULT float vignette(P_DEFAULT vec2 uv){
      uv *= 1.0 - uv.xy;
      P_DEFAULT float vignette = uv.x * uv.y * 15.0;
      return pow(vignette, vignette_intensity * vignette_opacity);
    }

    P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
    {
        P_COLOR vec4 color = texture2D( CoronaSampler0, texCoord);

        P_UV vec2 uv = warp(texCoord);

        P_UV vec2 text_uv = uv;
	      P_UV vec2 roll_uv = vec2(0.0);

        P_DEFAULT float time = CoronaTotalTime;

        //pixelate
        text_uv = ceil(uv * resolution) / resolution;

        P_DEFAULT float roll_line = 0.0;
        P_COLOR vec4 texture;
        
        if (noise_opacity > 0.0)
        {
          roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (time * roll_speed) ) );
          roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * roll_variation - (time * roll_speed * roll_variation) ) );
          roll_uv = vec2(( roll_line * distort_intensity * (1.-texCoord.x)), 0.0);

          texture.r = texture2D(CoronaSampler0, text_uv + roll_uv * 0.8 + vec2(aberration, 0.0) * 0.1).r;
          texture.g = texture2D(CoronaSampler0, text_uv + roll_uv * 1.2 - vec2(aberration, 0.0) * 0.1 ).g;
          texture.b = texture2D(CoronaSampler0, text_uv + roll_uv).b;
          texture.a = 1.0;
        }
        
        P_DEFAULT float r = texture.r;
        P_DEFAULT float g = texture.g;
        P_DEFAULT float b = texture.b;

        uv = warp(texCoord);
	
        if (grille_opacity > 0.0){
          
          P_DEFAULT float g_r = smoothstep(0.85, 0.95, abs(sin(uv.x * (resolution.x * 3.14159265))));
          r = mix(r, r * g_r, grille_opacity);
          
          P_DEFAULT float g_g = smoothstep(0.85, 0.95, abs(sin(1.05 + uv.x * (resolution.x * 3.14159265))));
          g = mix(g, g * g_g, grille_opacity);
          
          P_DEFAULT float b_b = smoothstep(0.85, 0.95, abs(sin(2.1 + uv.x * (resolution.x * 3.14159265))));
          b = mix(b, b * b_b, grille_opacity);
          
        }
        
        texture.r = clamp(r * brightness, 0.0, 1.0);
        texture.g = clamp(g * brightness, 0.0, 1.0);
        texture.b = clamp(b * brightness, 0.0, 1.0);

        P_DEFAULT float scanlines = 0.5;
        if (scanlines_opacity > 0.0)
        {
          scanlines = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265))));
          texture.rgb = mix(texture.rgb, texture.rgb * vec3(scanlines), scanlines_opacity);
        }
        
        if (noise_opacity > 0.0)
        {
          P_DEFAULT float noise = smoothstep(0.4, 0.5, noise(uv * vec2(2.0, 200.0) + vec2(10.0, (CoronaTotalTime * (noise_speed))) ) );
          
          roll_line *= noise * scanlines * clamp(random((ceil(uv * resolution) / resolution) + vec2(CoronaTotalTime * 0.8, 0.0)).x + 0.8, 0.0, 1.0);
          texture.rgb = clamp(mix(texture.rgb, texture.rgb + roll_line, noise_opacity), vec3(0.0), vec3(1.0));
        }
        
        if (static_noise_intensity > 0.0)
        {
          texture.rgb += clamp(random((ceil(uv * resolution) / resolution) + fract(CoronaTotalTime)).x, 0.0, 1.0) * static_noise_intensity;
        }
        
        
        texture.rgb *= border(uv);
        texture.rgb *= vignette(uv);

        if (clip_warp == 1.0)
        {
          texture.a = border(uv);
        }
        
        P_DEFAULT float saturation = 0.5;
        P_DEFAULT float contrast = 1.2;

        if (discolor == 1.0)
        {
          // Saturation
          P_COLOR vec3 greyscale = vec3(texture.r + texture.g + texture.b) / 3.0;
          texture.rgb = mix(texture.rgb, greyscale, saturation);
          
          // Contrast
          P_DEFAULT float midpoint = pow(0.5, 2.2);
          texture.rgb = (texture.rgb - vec3(midpoint)) * contrast + midpoint;
        }

        return CoronaColorScale(texture);
      }
]]

graphics.defineEffect(kernel)