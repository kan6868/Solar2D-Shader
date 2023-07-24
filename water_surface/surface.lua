local kernel = {}

kernel.language = "glsl"
kernel.category = "filter"

kernel.name = "surface"

kernel.isTimeDependent = true

kernel.vertexData =
{
    {
        name = "speed",
        default = 0.0, 
        min = 0.0,
        max = 1.0,
        index = 0,  -- This corresponds to "CoronaVertexUserData.x"
    },
    {
        name = "scale",
        default = 0.0,
        min = 0.0,
        max = 1.0,
        index = 1 -- This corresponds to "CoronaVertexUserData.y"
    },
    {
        name = "opacity",
        default = 0.0,
        min = 0.0,
        max = 1.0,
        index = 2 -- This corresponds to "CoronaVertexUserData.z"
    },
    {
        name = "intensity",
        default = 0.0,
        min = 0.0,
        max = 1.0,
        index = 3 -- This corresponds to "CoronaVertexUserData.w"
    }
}

kernel.fragment = [[

    P_RANDOM float avg(P_COLOR vec4 color) {
        return (color.r + color.g + color.b) / 3.0;
    }

    P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
    {
        P_COLOR float speed = CoronaVertexUserData.x;
        P_COLOR float scale = CoronaVertexUserData.y;
        P_COLOR float opacity = CoronaVertexUserData.z;
        P_COLOR float intensity = CoronaVertexUserData.w;

        P_COLOR vec4 noise1 = texture2D(CoronaSampler1, sin(mod( texCoord * scale + CoronaTotalTime * speed, 1.0)) );

        P_COLOR vec4 tex = texture2D(CoronaSampler0, vec2(texCoord) + avg(noise1) * intensity);

        noise1.rgb = vec3(avg(noise1));

        //fog in water
		P_COLOR float alpha = opacity;

        if (tex.a == 0.0)
        {
            alpha = 0.0;
        }
        //

        return CoronaColorScale((noise1) * alpha + tex);
    }
]]

return kernel