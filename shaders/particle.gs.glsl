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

    // coins[0] = position + vec2(-x/2, -y/2)
    // coins[1] = position + vec2(x/2, -y/2)
    // coins[2] = position + vec2(x/2, y/2)
    // coins[3] = position + vec2(-x/2, y/2)
    // position + vec2(-attribIn[1].size.x / 2, -attribIn[1].size.y / 2)

    vec2 coins[4] = { vec2(-attribIn[0].size.x / 2, -attribIn[0].size.y / 2),
                      vec2(attribIn[1].size.x / 2, -attribIn[1].size.y / 2),
                      vec2(attribIn[2].size.x / 2, attribIn[2].size.y / 2),
                      vec2(-attribIn[3].size.x / 2, -attribIn[3].size.y / 2) };
     
    for (int i = 0; i < 4; ++i) {
        //vec2 dpixels = gl_in[0].gl_PointSize + coins[i];
        vec4 pos = vec4(gl_in[0].gl_Position.xy + coins[i], gl_in[0].gl_Position.zw);
        gl_Position = projection * pos;

        // pour texCoords il faut appliquer la même logique qu'avec les coordonnées de tessellation (les mettres entre 0 et 1)
        attribOut.texCoords += coins[i];
        EmitVertex();
    }
} 
