Shader "enfutu/font_"
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
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 color : COLOR;
				float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
                float4 vertex : SV_POSITION;
				float4 color : COLOR;
            };

            sampler2D _MainTex;
			float _OutlineWidth, _ScaleX, _ScaleY, _PerspectiveFilter;
            float4 _MainTex_ST, _FaceColor, _OutlineColor;
			float4 _UdonSelectValue;
			float4 _UdonPlateValue[100];

            v2f vert (appdata v)
            {
                v2f o;

				/*
				float selectNum = _UdonSelectValue.y;
                float2 selectPos = _UdonPlateValue[selectNum].xy;

				//文字スケールを設定
				float2 pixelSize = UnityObjectToClipPos(v.vertex).w;
				pixelSize /= float2(_ScaleX, _ScaleY) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
				float scale = rsqrt(dot(pixelSize, pixelSize));
				if (UNITY_MATRIX_P[3][3] == 0) scale = lerp(abs(scale) * (1 - _PerspectiveFilter), scale, abs(dot(UnityObjectToWorldNormal(v.normal), normalize(WorldSpaceViewDir(v.vertex)))));

				scale *= .0008;	//使いにくいので小さくする

				float2 lv = v.vertex.xy - selectPos;
				v.vertex.xy = selectPos + lv;
				*/

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv2 = v.vertex.xy;
				o.color = float4(1,1,1,1);//v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 st= i.uv;//floor(i.uv * 10) * .1;

                fixed tex = tex2D(_MainTex, st).a;

				fixed shape = tex;// * alpha;
				
				clip(shape - .4);

				float alpha = (1 - _UdonSelectValue.x * .9) * _UdonSelectValue.w;
				//float4 col = lerp(_OutlineColor, _FaceColor, shape + (.3 + _OutlineWidth * .1));
				float4 col = _FaceColor * alpha;

                return col;
            }
            ENDCG
        }
    }
}
