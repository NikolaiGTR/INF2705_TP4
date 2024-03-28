#version 400 core

layout(vertices = 4) out;

uniform mat4 modelView;


const float MIN_TESS = 4;
const float MAX_TESS = 64;

const float MIN_DIST = 30.0f;
const float MAX_DIST = 100.0f;

void main()
{
	// TODO

    gl_in[0].gl_Position; // (0,0)
    gl_in[1].gl_Position; // (1,0)
    gl_in[2].gl_Position; // (1,1)
    gl_in[3].gl_Position; // (0,1)

	if (gl_InvocationID == 0) {
		gl_TessLevelInner[0] = tessLevelInner;
		gl_TessLevelInner[1] = tessLevelInner;
		gl_TessLevelOuter[0] = tessLevelOuter;
		gl_TessLevelOuter[1] = tessLevelOuter;
		gl_TessLevelOuter[2] = tessLevelOuter;
		gl_TessLevelOuter[3] = tessLevelOuter;
	}
}
