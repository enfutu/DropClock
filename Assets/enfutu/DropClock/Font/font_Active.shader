Shader "enfutu/font_Active"
{
    Properties
	{
		[HideInInspector]_FaceTex			("Face Texture", 2D) = "white" {}
		[HideInInspector]_FaceUVSpeedX		("Face UV Speed X", Range(-5, 5)) = 0.0
		[HideInInspector]_FaceUVSpeedY		("Face UV Speed Y", Range(-5, 5)) = 0.0
		[HDR]_FaceColor		("Font Color", Color) = (1,1,1,1)
		[HideInInspector]_FaceDilate			("Face Dilate", Range(-1,1)) = 0

		[HideInInspector][HDR]_OutlineColor	("Outline Color", Color) = (0,0,0,1)
		[HideInInspector]_OutlineTex			("Outline Texture", 2D) = "white" {}
		[HideInInspector]_OutlineUVSpeedX	("Outline UV Speed X", Range(-5, 5)) = 0.0
		[HideInInspector]_OutlineUVSpeedY	("Outline UV Speed Y", Range(-5, 5)) = 0.0
		[HideInInspector]_OutlineWidth		("Outline Thickness", Range(0, 1)) = 0
		[HideInInspector]_OutlineSoftness	("Outline Softness", Range(0,1)) = 0

		[HideInInspector]_Bevel				("Bevel", Range(0,1)) = 0.5
		[HideInInspector]_BevelOffset		("Bevel Offset", Range(-0.5,0.5)) = 0
		[HideInInspector]_BevelWidth			("Bevel Width", Range(-.5,0.5)) = 0
		[HideInInspector]_BevelClamp			("Bevel Clamp", Range(0,1)) = 0
		[HideInInspector]_BevelRoundness		("Bevel Roundness", Range(0,1)) = 0

		[HideInInspector]_LightAngle			("Light Angle", Range(0.0, 6.2831853)) = 3.1416
		[HideInInspector][HDR]_SpecularColor	("Specular", Color) = (1,1,1,1)
		[HideInInspector]_SpecularPower		("Specular", Range(0,4)) = 2.0
		[HideInInspector]_Reflectivity		("Reflectivity", Range(5.0,15.0)) = 10
		[HideInInspector]_Diffuse			("Diffuse", Range(0,1)) = 0.5
		[HideInInspector]_Ambient			("Ambient", Range(1,0)) = 0.5

		[HideInInspector]_BumpMap 			("Normal map", 2D) = "bump" {}
		[HideInInspector]_BumpOutline		("Bump Outline", Range(0,1)) = 0
		[HideInInspector]_BumpFace			("Bump Face", Range(0,1)) = 0

		[HideInInspector]_ReflectFaceColor	("Reflection Color", Color) = (0,0,0,1)
		[HideInInspector]_ReflectOutlineColor("Reflection Color", Color) = (0,0,0,1)
		[HideInInspector]_Cube 				("Reflection Cubemap", Cube) = "black" { /* TexGen CubeReflect */ }
		[HideInInspector]_EnvMatrixRotation	("Texture Rotation", vector) = (0, 0, 0, 0)


		[HideInInspector][HDR]_UnderlayColor	("Border Color", Color) = (0,0,0, 0.5)
		[HideInInspector]_UnderlayOffsetX	("Border OffsetX", Range(-1,1)) = 0
		[HideInInspector]_UnderlayOffsetY	("Border OffsetY", Range(-1,1)) = 0
		[HideInInspector]_UnderlayDilate		("Border Dilate", Range(-1,1)) = 0
		[HideInInspector]_UnderlaySoftness	("Border Softness", Range(0,1)) = 0

		[HideInInspector][HDR]_GlowColor			("Color", Color) = (0, 1, 0, 0.5)
		[HideInInspector]_GlowOffset			("Offset", Range(-1,1)) = 0
		[HideInInspector]_GlowInner			("Inner", Range(0,1)) = 0.05
		[HideInInspector]_GlowOuter			("Outer", Range(0,1)) = 0.05
		[HideInInspector]_GlowPower			("Falloff", Range(1, 0)) = 0.75

		[HideInInspector]_WeightNormal		("Weight Normal", float) = 0
		[HideInInspector]_WeightBold			("Weight Bold", float) = 0.5

		[HideInInspector]_ShaderFlags		("Flags", float) = 0
		[HideInInspector]_ScaleRatioA		("Scale RatioA", float) = 1
		[HideInInspector]_ScaleRatioB		("Scale RatioB", float) = 1
		[HideInInspector]_ScaleRatioC		("Scale RatioC", float) = 1

		_MainTex			("Font Atlas", 2D) = "white" {}
		[HideInInspector]_TextureWidth		("Texture Width", float) = 512
		[HideInInspector]_TextureHeight		("Texture Height", float) = 512
		[HideInInspector]_GradientScale		("Gradient Scale", float) = 5.0
		[HideInInspector]_ScaleX				("Scale X", float) = 1.0
		[HideInInspector]_ScaleY				("Scale Y", float) = 1.0
		[HideInInspector]_PerspectiveFilter	("Perspective Correction", Range(0, 1)) = 0.875
		[HideInInspector]_Sharpness			("Sharpness", Range(-1,1)) = 0

		[HideInInspector]_VertexOffsetX		("Vertex OffsetX", float) = 0
		[HideInInspector]_VertexOffsetY		("Vertex OffsetY", float) = 0

		[HideInInspector]_MaskCoord			("Mask Coordinates", vector) = (0, 0, 32767, 32767)
		[HideInInspector]_ClipRect			("Clip Rect", vector) = (-32767, -32767, 32767, 32767)
		[HideInInspector]_MaskSoftnessX		("Mask SoftnessX", float) = 0
		[HideInInspector]_MaskSoftnessY		("Mask SoftnessY", float) = 0

		_StencilComp		("Stencil Comparison", Float) = 8
		_Stencil			("Stencil ID", Float) = 0
		_StencilOp			("Stencil Operation", Float) = 0
		_StencilWriteMask	("Stencil Write Mask", Float) = 255
		_StencilReadMask	("Stencil Read Mask", Float) = 255

		_CullMode			("Cull Mode", Float) = 0
		_ColorMask			("Color Mask", Float) = 15

		_LUT ("LUT", 2D) = "black" {}
	}

    SubShader
    {
	    Tags
	    {
		    "Queue"="Transparent+3"
		    "IgnoreProjector"="True"
		    "RenderType"="Transparent"
	    }

	    Stencil
	    {
		    Ref [_Stencil]
		    Comp [_StencilComp]
		    Pass [_StencilOp]
		    ReadMask [_StencilReadMask]
		    WriteMask [_StencilWriteMask]
	    }

	    Cull [_CullMode]
	    ZWrite Off
	    Lighting Off
	    Fog { Mode Off }
	    ZTest [unity_GUIZTestMode]
	    Blend One OneMinusSrcAlpha
	    ColorMask [_ColorMask]

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
			#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 color : COLOR;
				float3 normal : NORMAL;
            };

			struct v2g {
                float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float vid : TEXCOORD1;
                fixed4 color : COLOR;
				float3 normal : NORMAL;
            };

            struct g2f {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
				float4 color : COLOR;
            };

            sampler2D _MainTex, _LUT;
			float _OutlineWidth, _ScaleX, _ScaleY, _PerspectiveFilter;
            float4 _MainTex_ST, _FaceColor, _OutlineColor;
			float4 _UdonFontValue;	//x:power, y:文字数, zw:なし
			float4 _UdonSelectValue;
			float4 _UdonPlateValue[100];

            v2g vert (appdata v, uint vid : SV_VertexID)
            {			
				v2g o;
				o.vertex = v.vertex;
				o.uv = v.uv;
				o.vid = vid;
				o.color = v.color;
				o.normal = v.normal;
                return o;
            }

			float2 Rotate(float2 v, float angleRad)
			{
				float s = sin(-angleRad);
				float c = cos(-angleRad);
				return float2(v.x * c + v.y * s,
							  -v.x * s + v.y * c);
			}

            [maxvertexcount(3)]
            void geom (triangle v2g input[3], inout TriangleStream<g2f> stream) 
			{
				float selectPower = saturate(_UdonSelectValue.x * 1);
                float selectNum = _UdonSelectValue.y;
                float durationTime = _UdonSelectValue.z;
                float2 selectPos = _UdonPlateValue[selectNum].xy;
				float isName = input[0].color.r;

				uint id = floor(input[1].vid / 4.) + .5;

				float2 center = (input[0].vertex.xy + input[2].vertex.xy) / 2.;
				float2 p0 = 0;

				float2 target0 = selectPos - p0;
				float2 target1 = 0;
								
				float2 st = 0;
				float offset = 1. / 128.;

				st.x = offset * floor(128. * (1 - selectPower));	//逆再生
				st.y = offset * id;
				
				st.x += offset * .5;
				st.y += offset * .5;

				float3 tex = tex2Dlod(_LUT, float4(st, 0, 0));
				
				float2 vec = tex.rg * .25;
				vec = Rotate(vec, _Time.y * -.1);

				float nameFontScale = .8;
				/*
				//文字スケールを設定
				float2 pixelSize = UnityObjectToClipPos(input[0].vertex).w;
				pixelSize /= float2(_ScaleX, _ScaleY) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
				float scale = rsqrt(dot(pixelSize, pixelSize));
				if (UNITY_MATRIX_P[3][3] == 0) scale = lerp(abs(scale) * (1 - _PerspectiveFilter), scale, abs(dot(UnityObjectToWorldNormal(input[0].normal), normalize(WorldSpaceViewDir(input[0].vertex)))));

				scale *= .01;	//使いにくいので小さくする
				*/

                [unroll]
                for (int i = 0; i < 3; i++) {
                    v2g v = input[i];
                    
					g2f o;

					float2 lv = v.vertex.xy - center;
					lv *= lerp(nameFontScale * 1.5, nameFontScale, isName);
					target1.x = (center - selectPos) * selectPower * lerp(1, nameFontScale, isName);
					//target1 = lerp(target1, Rotate(float2(-.2 * nameFontScale, 0), -.3 * id - _Time.y * .1), isName);


					float2 pos = p0;// + vec;
					pos += target0;				
					pos += target1;
					pos += lv * tex.b * 20;

					pos.y += lerp(0, .05, isName);
					pos.y += sin(_Time.y + id * .5) * .005;

					v.vertex.xy = pos;
					o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
					//o.uv2 = (pos - selectPos) * 10 + .5;
					o.uv2 = pos;// - float2(.5, .5);

					o.color.rgb = 0;
					o.color.a = saturate(1 - tex.b) * selectPower;

                    stream.Append(o);
                }
                stream.RestartStrip();
            }


            fixed4 frag (g2f i) : SV_Target
            {
				
				
				float2 st= i.uv;
				fixed tex = tex2D(_MainTex, st).a;

				fixed shape = tex * i.color.a;// * (1 - _UdonFontValue.x);

				clip(shape - .4);

				//float4 col = lerp(_OutlineColor, _FaceColor, step(.4 + _OutlineWidth * .1, shape));
				float4 col = _FaceColor;

                return col;
            }
            ENDCG
        }
    }
}
