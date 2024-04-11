#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 velocity;
layout (location = 2) in vec4 color;
layout (location = 3) in vec2 size;
layout (location = 4) in float timeToLive;

out vec3 positionMod;
out vec3 velocityMod;
out vec4 colorMod;
out vec2 sizeMod;
out float timeToLiveMod;

uniform float time;
uniform float dt;

uint seed = uint(time * 1000.0) + uint(gl_VertexID);
uint randhash( ) // entre  0 et UINT_MAX
{
    uint i=((seed++)^12345391u)*2654435769u;
    i ^= (i<<6u)^(i>>26u); i *= 2654435769u; i += (i<<5u)^(i>>12u);
    return i;
}
float random() // entre  0 et 1
{
    const float UINT_MAX = 4294967295.0;
    return float(randhash()) / UINT_MAX;
}

const float PI = 3.14159265359f;
vec3 randomInCircle(in float radius, in float height)
{
    float r = radius * sqrt(random());
    float theta = random() * 2 * PI;
    return vec3(r * cos(theta), height, r * sin(theta));
}


const float MAX_TIME_TO_LIVE = 2.0f;
const float INITIAL_RADIUS = 0.2f;
const float INITIAL_HEIGHT = 0.0f;
const float FINAL_RADIUS = 0.5f;
const float FINAL_HEIGHT = 5.0f;

const float INITIAL_SPEED_MIN = 0.5f;
const float INITIAL_SPEED_MAX = 0.6f;

const float INITIAL_TIME_TO_LIVE_RATIO = 0.85f;

const float INITIAL_ALPHA = 0.0f;
const float ALPHA = 0.1f;
const vec3 YELLOW_COLOR = vec3(1.0f, 0.9f, 0.0f);
const vec3 ORANGE_COLOR = vec3(1.0f, 0.4f, 0.2f);
const vec3 DARK_RED_COLOR = vec3(0.1, 0.0, 0.0);

const vec3 ACCELERATION = vec3(0.0f, 0.1f, 0.0f);

void main()
{
    // TODO

    // Position initiale
    vec3 pos = randomInCircle(INITIAL_RADIUS, INITIAL_HEIGHT);

    // Direction de Vélocité initiale
    vec3 velDir = randomInCircle(FINAL_RADIUS, FINAL_HEIGHT);

    // Module de Vélocité initial
    float velModule = mix(INITIAL_SPEED_MIN, INITIAL_SPEED_MAX, random());

    // Temps de vie maximal initial
    float tempsVie = mix(INITIAL_TIME_TO_LIVE_RATIO * MAX_TIME_TO_LIVE, MAX_TIME_TO_LIVE, random());

    // Couleur initiale
    vec4 color = vec4(YELLOW_COLOR, INITIAL_ALPHA);

    // Taille Initiale
    vec2 sizeInit = vec2(size.x / 2, size.y);


    // Sorties
    positionMod = pos + (velDir * velModule) * dt;
    velocityMod = velocity + ACCELERATION * dt;
    if (time < 0.25)
        colorMod = vec4(YELLOW_COLOR, 0.1f);
    else if (time < 0.3)
        colorMod = vec4(mix(YELLOW_COLOR, ORANGE_COLOR, time), 0.1f);
    else if (time < 0.5)
        colorMod = vec4(ORANGE_COLOR, 0.1f);
    else
        colorMod = vec4(mix(YELLOW_COLOR, DARK_RED_COLOR, time), 0.1f);
    colorMod = color;
    // NO MACROS FOR VARIABLE FACTOR FROM 1 TO 1.5?
    sizeMod = size * mix(1, 1.5f, time);
    timeToLiveMod -= dt;

}
