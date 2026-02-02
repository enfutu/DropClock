Shader "enfutu/pa_positions"
{
    Properties
    {
        _LifeTime ("LifeTime", int) = 5
        _EmitterPos ("EmitterPosition", Vector) = (0,0,0,0)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 color : COLOR;
                float4 uv : TEXCOORD0;  //xy:uv, z:ParticleIndex, w:AgeParcent
                float3 center : TEXCOORD1;
                float size : TEXCOORD2;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 center : TEXCOORD1;
                float size : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST, _EmitterPos;
            int _LifeTime;

            v2f vert (appdata v)
            {
                v2f o;

                if(UNITY_MATRIX_P[3][3] == 1)
                {
                    float index = v.uv.z;
                    float size = .1;

                    float lifeTime = _LifeTime * 1.;
                    float age = floor(v.uv.w * 128); 
                
                    float3 lv = (v.vertex.xyz - v.center) * size * 10;

                    float _x = size * age;
                    float _y = index * size;
                    float _z = 0;

                    _x -= 128 * size * .5;
                    _y -= 128 * size * .5;

                    _x += size * .5;
                    _y += size * .5;

                    v.vertex.xyz = float3(_x, _y, _z) + lv;
                }

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv.xy, _MainTex);
                o.center = v.center;
                o.size = v.size;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

                col.rg = i.center.xy - _EmitterPos.xy;   //ÉçÅ[ÉJÉãÇ…
                col.b = i.size;
                return col;
            }
            ENDCG
        }
    }
}
