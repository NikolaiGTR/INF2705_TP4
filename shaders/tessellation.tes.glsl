#version 400 core

layout(quads) in;

/*
in Attribs {
    vec4 couleur;
} AttribsIn[];*/


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
    // mix( x, y, f ) = x * (1-f) + y * f.
    vec4 v01 = mix(v0, v1, gl_TessCoord.x);
    vec4 v23 = mix(v3, v2, gl_TessCoord.x);
    return mix(v01, v23, gl_TessCoord.y);
}


const float PLANE_SIZE = 256.0f;

void main()
{
	// TODO
    vec4 positionInterpolee = interpole(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_in[2].gl_Position, gl_in[3].gl_Position);
    gl_Position = mvp * positionInterpolee;

    vec2 tex = ( positionInterpolee.xy / PLANE_SIZE + 0.5f) / 4;

    attribOut.height = texture(heighmapSampler, tex).y * 64.0 - 32;
    attribOut.patchDistance = vec4(gl_TessCoord, 1 - gl_TessCoord);
    attribOut.texCoords = gl_TessCoord.xy * 2;
    //AttribsOut.couleur = interpole(AttribsIn[0].couleur, AttribsIn[1].couleur, AttribsIn[2].couleur, AttribsIn[3].couleur);
}
