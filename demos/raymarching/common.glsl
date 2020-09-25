precision mediump float;
// COMMON
mat4 rot(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

vec3 linear_transform(vec3 p, mat4 m) {
    return (m*vec4(p,0)).xyz;
}
vec3 affine_transform(vec3 p, mat4 m) {
    return (m*vec4(p,1)).xyz;
}

float sdSphere( vec3 p, float s )
{
  return length(p)-s;
}

vec3 smooth_fract( vec3 p, float k) {
    vec3 x = fract(p);
    vec3 t = step(vec3(k,k,k),x);
    return t * x + (1.-t) * k * smoothstep(1.,0.7,x);
    
}