#version 330 core

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;


in ATTRIB_VS_OUT
{
    vec4 color;
    vec2 size;
} attribIn[];

out ATTRIB_GS_OUT
{
    vec4 color;
    vec2 texCoords;
} attribOut;

uniform mat4 projection;

void main()
{
    // TODO
    //float min = 0 - attribIn[0].size / 2;
    //float max = 0 + attribIn[0].size / 2;

    vec2 coins[4] = { attribIn[0].size, attribIn[0].size, attribIn[0].size, attribIn[0].size };
    for (int i = 0; i < 4; ++i) {
        vec2 dpixels = gl_in[0].gl_PointSize * coins[i];
        vec4 pos = vec4(gl_in[0].gl_Position.xy + dpixels, gl_in[0].gl_Position.xy);
        gl_Position = projection * pos;
        attribOut.texCoords += projection * pos;
        EmitVertex();
    }
} 
