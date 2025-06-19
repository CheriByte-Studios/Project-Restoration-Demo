#pragma header

#define DEG2RAD (3.1415 / 180)

uniform float zoom;
uniform vec2 transform;
uniform bool invertX;
uniform bool invertY;
uniform float rotation;

vec2 rotate(vec2 coord, vec2 center, float rotation)
{
    float sv = sin(rotation);
    float cv = cos(rotation);
    return vec2(
        center.x + (coord.x - center.x) * cv - (coord.y - center.y) * sv,
        (coord.x - center.x) * sv + center.y + (coord.y - center.y) * cv
    );
}

vec2 modge(vec2 a, vec2 b)
{
    if (invertX && mod(a.x, 2.) > 1)
    {
        a.x = 1. - a.x;
    }
    if (invertY && mod(a.y, 2.) > 1)
    {
        a.y = 1. - a.y;
    }
    return mod(a, b);
}

void main()
{
    //float zoom = 1. + sin(iTime * 0.4 * 3.1415);
    vec2 fragCoord = openfl_TextureCoordv.xy * openfl_TextureSize.xy;

    fragCoord = rotate(fragCoord, openfl_TextureSize.xy * .5, rotation * DEG2RAD);

    vec2 uv = fragCoord / openfl_TextureSize.xy;

    uv -= transform;
    //uv += vec2(sin(iTime * 0.2 * 3.1415), cos(iTime * 0.2 * 3.1415));
    uv = modge(mix(uv, vec2(.5, .5), -zoom), vec2(1., 1.)); // mix(vec2(1., 1.), vec2(.5, .5), -.50));

    // Time varying pixel color
    vec4 col = flixel_texture2D(bitmap, uv);

    // Output to screen
    gl_FragColor = col;
}