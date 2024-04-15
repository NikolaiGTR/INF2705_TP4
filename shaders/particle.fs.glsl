#version 330 core

out vec4 FragColor;


uniform sampler2D textureSampler;

in ATTRIB_GS_OUT
{
    vec4 color;
    vec2 texCoords;
} attribIn;

void main()
{
    // TODO
    vec4 tex = texture(textureSampler, attribIn.texCoords);
    vec4 colorBlend = tex * attribIn.color;
    if (colorBlend.a < 0.05) discard;
    FragColor = colorBlend;
    
}
