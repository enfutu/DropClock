Shader "enfutu/Blit"
{
    Properties
    {
        _Src("Src", 2D) = "white" {}
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
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex, _Src;
            float4 _MainTex_ST;
            float4 _UdonSelectValue;
            float4 _UdonPlateValue[100];

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }

            float smin(float a, float b, float k)
            {
                 float h = max(k - abs(a - b), 0.0);
                 return min(a, b) - h*h / (4.0*k);
            }


            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                float2 st = i.uv;

                float shape = 1;
                float shape_select = 0;
                float selectPower = _UdonSelectValue.x;
                float selectNum = _UdonSelectValue.y;
                float nowDurationTime = _UdonSelectValue.z;         //今この瞬間の経過時間
                float2 selectPos = _UdonPlateValue[selectNum].xy;

                [unroll]
                for(int i = 0; i < 100; i++)
                {
                    float isActive = step(_UdonPlateValue[i].w, -.0001);    //マイナス入ってるならActive
                    float isLeft = step(.0001, _UdonPlateValue[i].w);       //プラス入ってるなら退室済み(0の時は小さい雨粒)
                    isActive += isLeft;                                     //isLeftがtrueならisActiveもtrueへ

                    float platesDurationTime = _UdonPlateValue[i].z;        //nameplateがActiveになった時点における経過時間
                    float _now = lerp(nowDurationTime, _UdonPlateValue[i].w, isLeft);   //退室済みなら経過時間を退室時のものに固定し水滴の拡大を防ぐ
                    
                    float r = .8;
                    r += .00004 * (_now - platesDurationTime);  //.00001だと6時間で半分くらいだった
                    r = min(1.5f, r);
                    r = lerp(platesDurationTime, r, isActive);
                    
                    float2 pos = _UdonPlateValue[i].xy + .5;

                    //選択したposに近づくようずらす。選択されていない場合はselectpowerでずれないように制御。
                    float2 select = selectPos + .5;
                    float2 vec = normalize(pos - select);
                    float power = saturate(.25 - length(pos - select)) * .5;

                    pos -= vec * power * selectPower;

                    //選択された本体は位置を固定しrangeを通常よりscale倍する
                    if(i == selectNum)
                    {
                        pos = selectPos + .5;
                        float scale = .5;
                        r += r * scale * selectPower;

                        shape_select = length(st - pos);
                        //shape_select = lerp(shape_select, max(.05, shape_select), isLeft);
                        shape_select = pow(shape_select, r);

                        shape_select = shape_select - .05 * selectPower;
                        shape_select = abs(shape_select);

                        continue;
                    }

                    float dist = length(st - pos);
                    //dist = lerp(dist, max(.05, dist), isLeft);

                    dist = pow(dist, r);
                    
                    shape = smin(shape, dist, .08);
                }

                shape = smin(shape, shape_select, .12);

                return shape;
            }
            ENDCG
        }
    }
}
