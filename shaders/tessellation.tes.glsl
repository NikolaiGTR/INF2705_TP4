#version 400 core

layout(quads) in;



out ATTRIB_TES_OUT
{
    float height;
    vec2 texCoords;
    vec4 patchDistance;
} attribOut;

uniform mat4 mvp;

uniform sampler2D heighmapSampler;

vec4 interpole( vec4 v0, vec4 v1, vec4 v2, vec4 v3 )
{
    vec4 v01 = mix(v0, v1, gl_TessCoord.x);
    vec4 v23 = mix(v3, v2, gl_TessCoord.x);
    return mix(v01, v23, gl_TessCoord.y);
}


const float PLANE_SIZE = 256.0f;

void main()
{

    vec4 positionInterpolee = interpole(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_in[2].gl_Position, gl_in[3].gl_Position);

    vec2 tex = ( positionInterpolee.xz / PLANE_SIZE + 0.5f) /4;
    float height= texture(heighmapSampler, tex).x;
    attribOut.height = height;
    attribOut.texCoords = gl_TessCoord.xy * 2;
    gl_Position = mvp * (positionInterpolee+vec4(0.0f,height * 64.0f - 32.0f,0.0f,0.0f));
}
