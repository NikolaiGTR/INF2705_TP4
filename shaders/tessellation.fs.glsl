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
    float smoothedHeight = attribIn.height;
    vec4 wireFrame=vec4(vec3(edgeFactor(attribIn.barycentricCoords,WIREFRAME_WIDTH)*WIREFRAME_COLOR+WIREFRAME_COLOR),1.0f);
    vec4 color;
    if(smoothedHeight<0.3f){
        if(viewWireframe){
        color=texture(sandSampler,attribIn.texCoords)*wireFrame;
        }else{
        color=texture(sandSampler,attribIn.texCoords);}
    }
    else if(smoothedHeight<0.35f){
        if(viewWireframe){}
        else{}
    }
    else if(smoothedHeight<0.6f){
        if(viewWireframe){color=texture(groundSampler,attribIn.texCoords)*wireFrame;}
        else{color=texture(groundSampler,attribIn.texCoords);}
    }
    else if(smoothedHeight<0.65){
        if(viewWireframe){}
        else{
        }
    }
    else{
        if(viewWireframe){color=texture(snowSampler,attribIn.texCoords)*wireFrame;}
        else{color=texture(snowSampler,attribIn.texCoords);}
    }
    //FragColor=vec4(1.0f,0.5f,0.5f,1.0f);
    //FragColor = vec4(vec3(edgeFactor(attribIn.barycentricCoords,WIREFRAME_WIDTH)),1.0f);
    FragColor=color;
    
}
