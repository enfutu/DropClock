Shader "enfutu/plate"
{
    Properties
    {      
        _BaseColor ("BaseColor", Color) = (0,0,0,0)
        _WaterColor ("WaterColor", Color) = (0,0,0,0)
        _HighlightColor ("HighlightColor", Color) = (0,0,0,0)
        _HandsColor ("HandsColor", Color) = (0,0,0,0)
        _WaterEmissionPow ("WaterEmission", range(0, 5)) = 0
        _HandEmissionPow ("HandEmission", range(0, 5)) = 0
        _HandScale ("HandScale", range(0, .2)) = .15

        _LightShiftX ("(Light)Shift_X", range(-1,1)) = 0
        _LightShiftY ("(Light)Shift_Y", range(-1,1)) = 0

        _RT ("RT", 2D) = "white" {}

        [Toggle]_UseDirectionalLight("(Light)UseDirectionalLight", int) = 1        
        [HideInInspector]_MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent+1" "RenderType"="Transparent" }
        LOD 100
        //Blend One OneMinusSrcAlpha
        
        
        /*
        Stencil
        {
            Ref 0
            Comp Less
            Pass replace
        }*/
        

        GrabPass { "_enWatchGrabTex" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;

                // single pass instanced rendering
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 grabPos : TEXCOORD2;
                float3 localLightDir : TEXCOORD3;
                float lightDot : TEXCOORD4;
                float3 viewDir : TEXCOORD5;

                // single pass instanced rendering
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex, _RT, _enWatchGrabTex;
            float4 _MainTex_ST, _WaterColor, _HighlightColor, _BaseColor, _HandsColor;
            float _HandScale, _WaterEmissionPow, _HandEmissionPow, _LightShiftX, _LightShiftY;
            float4 _UdonSelectValue;
            int _UseDirectionalLight;

            float4 _HandRot;

            v2f vert (appdata v)
            {
                v2f o;

                // single pass instanced rendering
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.grabPos = ComputeGrabScreenPos(o.vertex);

                float3 lightDir0 = mul(unity_WorldToObject, _WorldSpaceLightPos0);
                float3 lightDir1 = float3(_LightShiftX, _LightShiftY, v.normal.z);
                o.localLightDir = lerp(lightDir1, lightDir0, _UseDirectionalLight);
                o.lightDot = dot(o.localLightDir, v.normal);
                o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float2 rotate2D(float2 p, float a)
            {
                float s = sin(a), c = cos(a);
                return float2(c*p.x - s*p.y, s*p.x + c*p.y);
            }

            float2 random2(float2 st)
            {
                st = float2(dot(st, float2(127.1, 311.7)), dot(st, float2(269.5, 183.3)));
                return -1.0 + 2.0 * frac(sin(st) * 43758.5453123);
            }

            float sdUnevenCapsule(float2 p, float r1, float r2, float h )
            {
                p.x = abs(p.x);
                float b = (r1-r2)/h;
                float a = sqrt(1.0-b*b);
                float k = dot(p,float2(-b,a));
                if( k < 0.0 ) return length(p) - r1;
                if( k > a*h ) return length(p-float2(0.0,h)) - r2;
                return dot(p, float2(a,b) ) - r1;
            }

            float smin(float a, float b, float k)
            {
                 float h = max(k - abs(a - b), 0.0);
                 return min(a, b) - h*h / (4.0*k);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // single pass instanced rendering
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                clip(_HandRot.w - .5);

                float2 st = i.uv;

                float3 lightDir = i.localLightDir;


                // sample the texture
                fixed4 col = 0; //tex2D(_MainTex, i.uv);
                

                //clock hands------------------
                float2 hst = st;
                hst = ((hst - .5) * 2. * 5) + .5;
                hst -= .5;

                float2 st_second = rotate2D(hst, _HandRot.x);
                float second = sdUnevenCapsule(st_second, .1, .1, 4.5);

                float2 st_minute = rotate2D(hst, _HandRot.y);
                float minute = sdUnevenCapsule(st_minute, .2, .1, 4.5);

                float2 st_hour = rotate2D(hst, _HandRot.z);
                float hour = sdUnevenCapsule(st_hour, .25, .1, 3);

                float hands = smin(second, minute, .03);
                hands = smin(hands, hour, .03);
                hands = saturate(hands + _HandScale);   //スケールは加算で変更

                //Nameplate------------------               
                float rt = tex2D(_RT, st).r;
                float shape = rt;
               
                //合算
                shape = smin(shape, hands, .2); 
                shape *= step(.001, hands);
                //hands = step(hands, .1);

                //法線を作る
                float field = shape;
                float px = 1. / 256.; //明示的にfloatに
                float blur = 5;
                px *= blur;
                
                float dR = tex2D(_RT, st + float2(px, 0)).r;
                float dL = tex2D(_RT, st - float2(px, 0)).r;
                float dU = tex2D(_RT, st + float2(0, px)).r;
                float dD = tex2D(_RT, st - float2(0, px)).r;

                float2 grad = float2(dR - dL, dU - dD);
                float2 ng = normalize(grad + 1e-8);
                ng = lerp(0, ng, shape);

                //大きさの調整
                shape = saturate(.1 - shape) * 10;

                //clip
                float c = step(.3, shape);


                float2 grabSt = i.grabPos.xy / i.grabPos.w;
                float4 grab = tex2D(_enWatchGrabTex, grabSt + ng * c);

                col = grab;
                
                
                //++++Lighting++++
                
                //shiftMap
                float shiftMap_shadow = tex2D(_RT, st + lightDir.xy * .005).r;
                float shiftMap_highlight = tex2D(_RT, st - lightDir.xy * .01).r; 
                float shiftMap_droplight = tex2D(_RT, st + lightDir.xy * .02).r; 
                
                //fakeShadow
                float shadow = shiftMap_shadow;
                //光が正面から当たるほど小さく
                float shadowScale = (1 - saturate(dot(lightDir, float3(0,0,-1)))) * .1;
                shadowScale = min(.08, shadowScale + .08);
                shadow = 1 - saturate(shadowScale - shadow) * 1 / shadowScale;
                //形の調整
                shadow = pow(shadow, 10);    //絞る
                shadow = max(.1, shadow);   //凸部が目立つのでフラットに
                shadow = lerp(shadow, saturate(1.5 - shadow), c);   //水滴外のshadowと水滴内部のshadow(grad)

                //fakeLight
                float selectPower = saturate(_UdonSelectValue.x);
                float hilight_offset = max(.01, .08 - selectPower);
                float highlight = shiftMap_highlight;
                highlight = saturate(hilight_offset - highlight) * 1 / hilight_offset;
                highlight *= 1.2;
                highlight = saturate(pow(highlight, 15));
                highlight *= saturate(i.lightDot);
                highlight = saturate(highlight);

                float droplight = shiftMap_droplight;
                droplight = saturate(.2 - droplight) * 5;
                droplight *= 1.3;
                droplight = pow(droplight, 5);
                droplight = saturate(droplight);
                
                col.rgb *= lerp(_BaseColor, 1, c);

                _WaterColor += _WaterColor * _WaterEmissionPow;
                _HandsColor += _HandsColor * _HandEmissionPow;

                col.rgb *= shadow + droplight * _WaterColor;
                col.rgb += highlight * _HighlightColor * c;

                //+++++++++++

                _HandsColor *= saturate(i.lightDot);
                _WaterColor *= saturate(i.lightDot);

                float3 col_water = lerp(_HandsColor, _WaterColor, saturate(hands + .6));    //色を軽く混ぜたい

                col.rgb += lerp(0, col_water, shape * c - saturate(.075 - hands) * 13.333);
                col.rgb += lerp(0, _HandsColor, saturate(.075 - hands) * 13.333);

                col = saturate(col);

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
