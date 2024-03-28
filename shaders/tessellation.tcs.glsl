#version 400 core

layout(vertices = 4) out;

uniform mat4 modelView;


const float MIN_TESS = 4;
const float MAX_TESS = 64;

const float MIN_DIST = 30.0f;
const float MAX_DIST = 100.0f;

float calcTess(vec4 centerPoint) {
	return mix(MAX_TESS, MIN_TESS, (clamp(length(centerPoint.xyz), MIN_DIST, MAX_DIST) - MIN_DIST) / (MAX_DIST - MIN_DIST));
}

// mix(MAX_TESS, MIN_TESS, (clamp(length(centerOL0.xyz), MIN_DIST, MAX_DIST) - MIN_DIST)/(MAX_DIST - MIN_DIST)

void main()
{
	// TODO

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position; // (0,0)
	//gl_out[gl_InvocationID].gl_Position = gl_in[1].gl_Position; // (1,0)
	//gl_out[gl_InvocationID].gl_Position = gl_in[2].gl_Position; // (1,1)
	//gl_out[gl_InvocationID].gl_Position = gl_in[3].gl_Position; // (0,1)

	// Centres des arrêtes
	vec4 centerOL0 = modelView * (gl_in[3].gl_Position + gl_in[0].gl_Position) / 2;
	vec4 centerOL1 = modelView * (gl_in[1].gl_Position + gl_in[0].gl_Position) / 2;
	vec4 centerOL2 = modelView * (gl_in[2].gl_Position + gl_in[1].gl_Position) / 2;
	vec4 centerOL3 = modelView * (gl_in[2].gl_Position + gl_in[3].gl_Position) / 2;

	// Niveau de tesselation externe par rapport aux centres
	float tessOL0, tessOL1, tessOL2, tessOL3;
	tessOL0 = calcTess(centerOL0);
	tessOL1 = calcTess(centerOL1);
	tessOL2 = calcTess(centerOL2);
	tessOL3 = calcTess(centerOL3);

	// Niveau de tesselation interne
	float tessIL0 = max(tessOL1, tessOL3);
	float tessIL1 = max(tessOL0, tessOL2);
	

	if (gl_InvocationID == 0) {
		gl_TessLevelInner[0] = tessIL0;
		gl_TessLevelInner[1] = tessIL1;
		gl_TessLevelOuter[0] = tessOL0;
		gl_TessLevelOuter[1] = tessOL1;
		gl_TessLevelOuter[2] = tessOL2;
		gl_TessLevelOuter[3] = tessOL3;
	}
	
}
