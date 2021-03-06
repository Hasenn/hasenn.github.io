precision mediump float;
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

#define MAX_STEPS 1000
#define MAX_DIST 1000.
#define SURF_DIST .01

const vec3 sc = vec3(0,1,0);

float smin( float a, float b, float k )
{
    float res = exp2( -k*a ) + exp2( -k*b );
    return -log2( res )/k;
}
float smin( float a, float b)
{
    return smin(a,b,25.);
}

struct RM{
    float d;
    int steps;
};

float GetDist(in vec3 p){
    float d = MAX_DIST;
    
    d = min(
        d,
        sdSphere( p - sc, 0.5 )
    );
	d = d - 0.3*length(smooth_fract(p + time, 0.5));
    return d;
}

vec3 GetNormal(vec3 p){
    float d = GetDist(p);
    vec2 e = vec2(0.1,0);
    vec3 n = d - vec3(
    	GetDist(p-e.xyy),
        GetDist(p-e.yxy),
        GetDist(p-e.yyx));
    return normalize(n);
}

RM RayMarch(vec3 ro, vec3 rd){
    float d0 = 0.;
    int steps = 0;
    for(int i=0;i<MAX_STEPS;i++){
        steps = i;
        vec3 p = ro + rd*d0;
        float dS = GetDist(p);
        d0 += dS;
        if (d0>MAX_DIST || dS < SURF_DIST) break;
    }

    return RM(d0,steps);
}

void main()
{
    vec2 uv = (gl_FragCoord.xy-0.5*resolution.xy)/resolution.yy;
   	vec2 muv = (mouse.xy-0.5*resolution.xy)/resolution.yy;;
    //rotate around 010
    float an = 0.5*time;
	vec3 ro = vec3( 2.5*cos(an), 5.0, 2.5*sin(an) );
    vec3 ta = vec3( 0.0, 1.0, 0.0 );
    vec3 ww = normalize( ta - ro );
    vec3 uu = normalize( cross(ww,vec3(0.0,1.0,0.0) ) );
    vec3 vv = normalize( cross(uu,ww));
	vec3 rd = normalize( uv.x*uu + uv.y*vv + 1.5*ww );
    // Raymarch
    RM rm = RayMarch(ro,rd);
    float d = rm.d;

    vec3 col = vec3(0);

    col += 0.1*d;
    //normals
    col += 0.5 + 0.5*GetNormal(ro+rd*d);
    // Fake AO
    col -= 0.05*float(rm.steps);
    // Background color
    if (d > MAX_DIST) discard;
    // Output to screen
    gl_FragColor = vec4(col,1.0);
}