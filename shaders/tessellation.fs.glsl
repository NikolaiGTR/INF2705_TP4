#version 330 core

in ATTRIB_GS_OUT
{
    float height;
    vec2 texCoords;
    vec4 patchDistance;
    vec3 barycentricCoords;
} attribIn;

uniform sampler2D groundSampler;
uniform sampler2D sandSampler;
uniform sampler2D snowSampler;
uniform bool viewWireframe;

out vec4 FragColor;

float edgeFactor(vec3 barycentricCoords, float width)
{
    vec3 d = fwidth(barycentricCoords);
    vec3 f = step(d * width, barycentricCoords);
    return min(min(f.x, f.y), f.z);
}

float edgeFactor(vec4 barycentricCoords, float width)
{
    vec4 d = fwidth(barycentricCoords);
    vec4 f = step(d * width, barycentricCoords);
    return min(min(min(f.x, f.y), f.z), f.w);
}

const vec3 WIREFRAME_COLOR = vec3(0.5f);
const vec3 PATCH_EDGE_COLOR = vec3(1.0f, 0.0f, 0.0f);

const float WIREFRAME_WIDTH = 0.5f;
const float PATCH_EDGE_WIDTH = 0.5f;

void main()
{
	// TODO
    float smoothedHeight = smoothstep(-32.0f,32.0f,attribIn.height);
    if(smoothedHeight<0.3f){
        if(viewWireframe){}
    }
    else if(smoothedHeight<0.35f){
        if(viewWireframe){}
    }
    else if(smoothedHeight<0.6f){
        if(viewWireframe){}
    }
    else if(smoothedHeight<0.65){
        if(viewWireframe){}
    }
    else{
        if(viewWireframe){}
    }
    // FragColor=vec4(1.0f,0.5f,0.5f,1.0f);
    
}
