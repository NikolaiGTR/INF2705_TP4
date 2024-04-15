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
    vec2 coins[4] = { vec2(-attribIn[0].size.x / 2, -attribIn[0].size.y / 2),
                      vec2(attribIn[0].size.x / 2, -attribIn[0].size.y / 2),
                      vec2(-attribIn[0].size.x / 2, attribIn[0].size.y / 2),
                      vec2(attribIn[0].size.x / 2, attribIn[0].size.y / 2) };
     
    for (int i = 0; i < 4; ++i) {
        vec4 pos = vec4(gl_in[0].gl_Position.xy + (coins[i]), gl_in[0].gl_Position.zw);
        gl_Position = projection * pos;
        attribOut.texCoords = coins[i] + 0.5;
        attribOut.color = attribIn[0].color;
        EmitVertex();
    }
    EndPrimitive();
} 
