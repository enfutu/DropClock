// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ShaderFes/PosterShader2021"
{
	Properties
	{
		_EmissionTint("EmissionTint", Color) = (0,0,0,0)
		_Top("Top", 2D) = "white" {}
		_Smoothness("Smoothness", Float) = 1
		_Plus("Plus", 2D) = "black" {}
		_Bottom("Bottom", 2D) = "white" {}
		_MetalicMask("MetalicMask", 2D) = "white" {}
		_WaveMask("WaveMask", 2D) = "white" {}
		_BackDepthScale("Back Depth Scale", Range( 0 , 1)) = 0
		_PlusDepth("PlusDepth", Range( 0 , 2)) = 0
		_BottomColorTint("BottomColorTint", Color) = (0,0,0,0)
		_Wave1("Wave1", Vector) = (1,1,0,0)
		_Wave2("Wave2", Vector) = (1,1,0,0)
		_Wave3("Wave3", Vector) = (1,1,0,0)
		_WaveLine_1("WaveLine_1", Vector) = (1,1,0,0)
		_WaveLine_2("WaveLine_2", Vector) = (1,1,0,0)
		_WaveLine_3("WaveLine_3", Vector) = (1,1,0,0)
		_TopWaveLine_1("TopWaveLine_1", Vector) = (1,1,0,0)
		_TopWaveLine_2("TopWaveLine_2", Vector) = (1,1,0,0)
		_TopWaveLine_3("TopWaveLine_3", Vector) = (1,1,0,0)
		_PlusColor("PlusColor", Color) = (0,0,0,0)
		_WaveColor("WaveColor", Color) = (0,0,0,0)
		_Wave2Color("Wave2Color", Color) = (0,0,0,0)
		_Wave3Color("Wave3Color", Color) = (0,0,0,0)
		_WaveLine_1_Color("WaveLine_1_Color", Color) = (0,0,0,0)
		_WaveLine_2_Color("WaveLine_2_Color", Color) = (0,0,0,0)
		_WaveLine_3_Color("WaveLine_3_Color", Color) = (0,0,0,0)
		_TopWaveLine_Color1("TopWaveLine_Color1", Color) = (0,0,0,0)
		_TopWaveLine_Color_2("TopWaveLine_Color_2", Color) = (0,0,0,0)
		_TopWaveLine_Color_3("TopWaveLine_Color_3", Color) = (0,0,0,0)
		_Wave1_Mask("Wave1_Mask", Float) = 0
		_TopWave_Mask("TopWave_Mask", Float) = 0
		_CircleMask_Scale("CircleMask_Scale", Float) = 0
		_CircleMask_Ypos("CircleMask_Ypos", Float) = 0
		_CircleMask_Subtract("CircleMask_Subtract", Float) = 0
		_Date("Date", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform sampler2D _Top;
		uniform float _CircleMask_Ypos;
		uniform float _CircleMask_Scale;
		uniform float _CircleMask_Subtract;
		uniform sampler2D _WaveMask;
		uniform float4 _WaveMask_ST;
		uniform float4 _TopWaveLine_1;
		uniform float _TopWave_Mask;
		uniform float4 _TopWaveLine_Color1;
		uniform float4 _TopWaveLine_2;
		uniform float4 _TopWaveLine_Color_2;
		uniform float4 _TopWaveLine_3;
		uniform float4 _TopWaveLine_Color_3;
		uniform sampler2D _Bottom;
		uniform float _BackDepthScale;
		uniform float4 _BottomColorTint;
		uniform float4 _Wave1;
		uniform float _Wave1_Mask;
		uniform float4 _WaveColor;
		uniform float4 _Wave2;
		uniform float4 _Wave2Color;
		uniform float4 _Wave3;
		uniform float4 _Wave3Color;
		uniform float4 _WaveLine_1;
		uniform float4 _WaveLine_1_Color;
		uniform float4 _WaveLine_2;
		uniform float4 _WaveLine_2_Color;
		uniform float4 _WaveLine_3;
		uniform float4 _WaveLine_3_Color;
		uniform sampler2D _Plus;
		uniform float4 _Plus_ST;
		uniform float _PlusDepth;
		uniform float4 _PlusColor;
		uniform sampler2D _Date;
		uniform float4 _Date_ST;
		uniform float4 _EmissionTint;
		uniform sampler2D _MetalicMask;
		uniform float4 _MetalicMask_ST;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float4 tex2DNode1 = tex2D( _Top, i.uv_texcoord );
			float2 uv_TexCoord329 = i.uv_texcoord + float2( -0.5,-0.5 );
			float2 appendResult345 = (float2(uv_TexCoord329.x , ( ( uv_TexCoord329.y * 1.414214 ) + _CircleMask_Ypos )));
			float CircleMask363 = (0.0 + (cos( ( saturate( ( distance( float2( 0,0 ) , ( appendResult345 * _CircleMask_Scale ) ) - _CircleMask_Subtract ) ) * UNITY_PI ) ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0));
			float lerpResult248 = lerp( 0.0 , tex2DNode1.r , CircleMask363);
			float2 uv_WaveMask = i.uv_texcoord * _WaveMask_ST.xy + _WaveMask_ST.zw;
			float2 appendResult279 = (float2(( ( uv_WaveMask.x * _TopWaveLine_1.x ) + ( _TopWaveLine_1.z * _Time.y ) + _TopWaveLine_1.z ) , ( ( uv_WaveMask.y * _TopWaveLine_1.y ) + _TopWaveLine_1.w )));
			float Mask2311 = ( 1.0 - step( (i.uv_texcoord).y , _TopWave_Mask ) );
			float2 appendResult280 = (float2(( ( uv_WaveMask.x * _TopWaveLine_2.x ) + ( _TopWaveLine_2.z * _Time.y ) + _TopWaveLine_2.z ) , ( ( uv_WaveMask.y * _TopWaveLine_2.y ) + _TopWaveLine_2.w )));
			float2 appendResult285 = (float2(( ( uv_WaveMask.x * _TopWaveLine_3.x ) + ( _TopWaveLine_3.z * _Time.y ) + _TopWaveLine_3.z ) , ( ( uv_WaveMask.y * _TopWaveLine_3.y ) + _TopWaveLine_3.w )));
			float2 Offset12 = ( ( 0.0 - 1 ) * ( i.viewDir.xy / i.viewDir.z ) * _BackDepthScale ) + i.uv_texcoord;
			float4 lerpResult75 = lerp( ( ( ( ( ( float4( 0,0,0,0 ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult279 ) ) * Mask2311 ) * _TopWaveLine_Color1 ) ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult280 ) ) * Mask2311 ) * _TopWaveLine_Color_2 ) ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult285 ) ) * Mask2311 ) * _TopWaveLine_Color_3 ) ) + ( ( 1.0 - tex2D( _Bottom, Offset12 ) ) * _BottomColorTint ) ) + tex2DNode1.r ) , float4( 0,0,0,0 ) , CircleMask363);
			float2 appendResult78 = (float2(( ( uv_WaveMask.x * _Wave1.x ) + ( _Wave1.z * _Time.y ) + _Wave1.z ) , ( ( uv_WaveMask.y * _Wave1.y ) + _Wave1.w )));
			float temp_output_91_0 = step( (i.uv_texcoord).y , _Wave1_Mask );
			float Mask241 = ( 1.0 - temp_output_91_0 );
			float2 appendResult129 = (float2(( ( uv_WaveMask.x * _Wave2.x ) + ( _Wave2.z * _Time.y ) + _Wave2.z ) , ( ( uv_WaveMask.y * _Wave2.y ) + _Wave2.w )));
			float4 lerpResult139 = lerp( ( 1.0 - ( ( tex2D( _WaveMask, appendResult78 ) + Mask241 ) * _WaveColor ) ) , ( 1.0 - ( ( tex2D( _WaveMask, appendResult129 ) + Mask241 ) * _Wave2Color ) ) , 0.5);
			float2 appendResult155 = (float2(( ( uv_WaveMask.x * _Wave3.x ) + ( _Wave3.z * _Time.y ) + _Wave3.z ) , ( ( uv_WaveMask.y * _Wave3.y ) + _Wave3.w )));
			float4 lerpResult163 = lerp( lerpResult139 , ( 1.0 - ( ( tex2D( _WaveMask, appendResult155 ) + Mask241 ) * _Wave3Color ) ) , 0.5);
			float2 appendResult178 = (float2(( ( uv_WaveMask.x * _WaveLine_1.x ) + ( _WaveLine_1.z * _Time.y ) + _WaveLine_1.z ) , ( ( uv_WaveMask.y * _WaveLine_1.y ) + _WaveLine_1.w )));
			float2 appendResult205 = (float2(( ( uv_WaveMask.x * _WaveLine_2.x ) + ( _WaveLine_2.z * _Time.y ) + _WaveLine_2.z ) , ( ( uv_WaveMask.y * _WaveLine_2.y ) + _WaveLine_2.w )));
			float2 appendResult228 = (float2(( ( uv_WaveMask.x * _WaveLine_3.x ) + ( _WaveLine_3.z * _Time.y ) + _WaveLine_3.z ) , ( ( uv_WaveMask.y * _WaveLine_3.y ) + _WaveLine_3.w )));
			float2 uv_Plus = i.uv_texcoord * _Plus_ST.xy + _Plus_ST.zw;
			float2 Offset316 = ( ( 0.0 - 1 ) * ( i.viewDir.xy / i.viewDir.z ) * _PlusDepth ) + uv_Plus;
			float4 lerpResult76 = lerp( lerpResult75 , ( ( ( ( ( lerpResult163 * temp_output_91_0 ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult178 ) ) * Mask241 ) * _WaveLine_1_Color ) ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult205 ) ) * Mask241 ) * _WaveLine_2_Color ) ) + ( ( ( 1.0 - tex2D( _WaveMask, appendResult228 ) ) * Mask241 ) * _WaveLine_3_Color ) ) + ( tex2D( _Plus, Offset316 ) * _PlusColor ) ) , CircleMask363);
			float2 uv_Date = i.uv_texcoord * _Date_ST.xy + _Date_ST.zw;
			float4 temp_output_382_0 = ( ( lerpResult248 + lerpResult76 ) * tex2D( _Date, uv_Date ) );
			o.Albedo = temp_output_382_0.rgb;
			o.Emission = ( temp_output_382_0 * _EmissionTint ).rgb;
			float2 uv_MetalicMask = i.uv_texcoord * _MetalicMask_ST.xy + _MetalicMask_ST.zw;
			o.Metallic = tex2D( _MetalicMask, uv_MetalicMask ).r;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18912
62;65;1708;774;8439.059;3326.635;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;325;-7625.083,-3458.623;Inherit;False;2503.921;2884.768;UnderWave;5;115;116;141;192;370;;0.4358141,0,0.6320754,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-7570.376,-3408.623;Inherit;False;2399.214;893.6662;Wave1;20;109;29;79;89;82;102;106;103;90;80;112;78;91;110;85;114;84;108;23;241;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;116;-7575.083,-2424.558;Inherit;False;2399.214;893.6662;Wave2;16;137;136;135;133;132;131;129;127;125;124;123;122;119;118;117;242;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;89;-7005.925,-2816.956;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;117;-7525.083,-2087.076;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;120;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;109;-7520.377,-3071.14;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;107;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;141;-7573.82,-1420.489;Inherit;False;2399.214;893.6662;Wave3;16;161;160;159;158;157;156;155;151;150;149;148;146;144;143;142;243;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;119;-7285.875,-1810.125;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;327;-3211.185,-5285.738;Inherit;False;2516.534;2914.747;CeilWave;3;254;253;251;;0,0.7950234,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;326;-7629.069,-184.1979;Inherit;False;2510.48;2821.366;TopWave;3;164;193;217;;0,0.3606725,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;90;-6764.103,-2822.903;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;120;-7475.083,-2037.076;Inherit;False;Property;_Wave2;Wave2;11;0;Create;True;1;;0;0;False;0;False;1,1,0,0;0.6,2.75,0.15,-0.17;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;142;-7523.82,-1083.006;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;145;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-7439.287,-3358.623;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;118;-7443.994,-2374.558;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;79;-7281.167,-2794.189;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-6693.928,-2953.276;Inherit;False;Property;_Wave1_Mask;Wave1_Mask;29;0;Create;True;0;0;0;False;0;False;0;0.515;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;107;-7470.377,-3021.14;Inherit;False;Property;_Wave1;Wave1;10;0;Create;True;1;WaveLines;0;0;False;0;False;1,1,0,0;0.7,2.62,0.2,-0.17;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;251;-3161.185,-5235.738;Inherit;False;2399.214;893.6662;Wave1;20;295;291;290;284;282;279;268;267;263;262;260;257;255;252;306;307;308;309;310;311;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-7033.205,-2338.154;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-7028.869,-3213.585;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-7020.956,-1971.238;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-7579.069,-134.1979;Inherit;False;2399.214;893.6662;Wave1;15;183;182;180;178;174;173;172;171;170;168;166;165;188;190;245;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;144;-7284.611,-806.0551;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;145;-7473.82,-1033.006;Inherit;False;Property;_Wave3;Wave3;12;0;Create;True;1;;0;0;False;0;False;1,1,0,0;0.5,3,0.13,-0.17;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;143;-7442.731,-1370.489;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-7016.248,-2955.302;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-7028.497,-3322.219;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;91;-6495.796,-2903.855;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.27;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-7033.577,-2229.521;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;351;-3381.474,372.0961;Inherit;False;2907.22;539.8603;CircleMask;2;367;368;;0,0.6415094,0.3989249,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;193;-7567.803,834.4074;Inherit;False;2399.214;893.6662;Wave1;15;213;212;211;210;207;205;202;201;200;199;198;196;195;194;246;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-7019.692,-967.1683;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;-7529.069,203.2852;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;167;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-6715.786,-3310.137;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-7032.314,-1225.451;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;-7031.941,-1334.084;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;252;-3111.185,-4898.255;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;256;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;367;-3273.904,438.0554;Inherit;False;1233.031;420.994;Circle;8;332;340;345;348;349;341;350;329;;0.1226415,0.1226415,0.1226415,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;253;-3149.919,-4267.134;Inherit;False;2399.214;893.6662;Wave1;15;298;296;293;292;289;287;280;277;275;273;271;270;265;261;258;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;127;-6720.492,-2326.073;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;125;-6760.825,-2156.07;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;-6756.117,-3140.135;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;110;-6240.472,-2902.394;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;194;-7517.803,1171.89;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;197;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;150;-6759.563,-1152.001;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;151;-6719.229,-1322.003;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;255;-2871.976,-4621.304;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;257;-3030.096,-5185.737;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;256;-3060.016,-4849.255;Inherit;False;Property;_TopWaveLine_1;TopWaveLine_1;16;0;Create;True;1;;0;0;False;0;False;1,1,0,0;0.45,2.78,0.2,0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;168;-7289.86,480.2361;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;129;-6505.394,-2227.673;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;241;-6053.424,-2904;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;329;-3223.904,509.8285;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.5,-0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;254;-3152.224,-3302.263;Inherit;False;2399.214;893.6662;Wave1;15;301;300;299;297;294;288;285;283;281;278;276;274;269;266;264;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;217;-7570.108,1799.278;Inherit;False;2399.214;893.6662;Wave1;15;237;236;235;233;232;228;227;226;224;223;222;221;220;218;247;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;78;-6500.687,-3211.737;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;258;-3099.919,-3929.651;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;259;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;166;-7447.98,-84.19722;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;167;-7477.9,252.2853;Inherit;False;Property;_WaveLine_1;WaveLine_1;13;0;Create;True;1;;0;0;False;0;False;1,1,0,0;4.88,2.78,1.1,-0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;261;-2860.71,-3652.7;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;242;-6237.184,-1967.899;Inherit;False;241;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-2986.847,743.0494;Inherit;False;Property;_CircleMask_Ypos;CircleMask_Ypos;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-2619.306,-5149.333;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;197;-7466.634,1221.89;Inherit;False;Property;_WaveLine_2;WaveLine_2;14;0;Create;True;1;;0;0;False;0;False;1,1,0,0;2.1,2.74,1,-0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;264;-3102.224,-2964.78;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;272;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;85;-6233.193,-3238.636;Inherit;True;Property;_WaveMask;WaveMask;6;0;Create;True;0;0;0;False;0;False;-1;None;26ffed5b86e267a4fbba5028370cb5c6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;263;-2619.679,-5040.7;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-2607.057,-4782.417;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;341;-2977.808,587.0945;Inherit;False;1.414214;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;-6237.899,-2254.572;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-7037.19,-47.79295;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-7024.941,319.123;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;218;-7520.108,2136.761;Inherit;False;388.4797;251.7362;X_wide_Y_height_Z_Speed_W_YPos;1;219;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;155;-6504.13,-1223.603;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;195;-7436.714,884.4081;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;265;-3018.83,-4217.133;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-7037.563,60.84013;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;306;-2476.737,-4605.232;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;196;-7278.594,1448.841;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;259;-3048.75,-3879.651;Inherit;False;Property;_TopWaveLine_2;TopWaveLine_2;17;0;Create;True;1;;0;0;False;0;False;1,1,0,0;1,3.05,0.4,-0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;133;-5854.593,-2228.13;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;-6764.811,134.2906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;243;-6404.645,-997.5612;Inherit;False;241;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;221;-7280.899,2413.712;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;266;-3021.135,-3252.263;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;308;-2164.741,-4741.553;Inherit;False;Property;_TopWave_Mask;TopWave_Mask;30;0;Create;True;0;0;0;False;0;False;0;0.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;267;-2306.595,-5137.252;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;114;-5849.887,-3212.194;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;-7013.675,1287.728;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;137;-5860.908,-1947.805;Inherit;False;Property;_Wave2Color;Wave2Color;21;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;220;-7439.019,1849.278;Inherit;True;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;-7025.924,920.8124;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;174;-6724.479,-35.71197;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;268;-2346.927,-4967.25;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;273;-2608.413,-4072.095;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;307;-2234.916,-4611.18;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;219;-7468.939,2186.761;Inherit;False;Property;_WaveLine_3;WaveLine_3;15;0;Create;True;1;;0;0;False;0;False;1,1,0,0;2.85,2.74,0.5,-0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;-7026.297,1029.446;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;269;-2863.015,-2687.829;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;157;-6236.636,-1250.502;Inherit;True;Property;_TextureSample2;Texture Sample 2;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;272;-3051.055,-2914.78;Inherit;False;Property;_TopWaveLine_3;TopWaveLine_3;18;0;Create;True;1;;0;0;False;0;False;1,1,0,0;0.81,2.74,0.7,0.05;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;349;-2793.113,588.929;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;271;-2608.04,-4180.729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;23;-5816.77,-3064.321;Inherit;False;Property;_WaveColor;WaveColor;20;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-2595.791,-3813.813;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;192;-6296.413,-2505.551;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;275;-2335.661,-3998.645;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;158;-5859.646,-943.7355;Inherit;False;Property;_Wave3Color;Wave3Color;22;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;309;-1966.608,-4692.132;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.27;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;279;-2091.494,-5038.852;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;277;-2295.328,-4168.648;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;276;-2598.096,-2848.942;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-2610.345,-3215.858;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;348;-2668.876,710.9951;Inherit;False;Property;_CircleMask_Scale;CircleMask_Scale;31;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;-2610.718,-3107.224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;222;-7015.98,2252.599;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;201;-6713.212,932.8934;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;178;-6509.379,62.68803;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-7028.229,1885.683;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-5853.331,-1224.06;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;345;-2624.078,511.0859;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-5549.45,-3122.471;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-7028.602,1994.317;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;202;-6753.545,1102.896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;-5554.156,-2138.407;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;-2458.478,510.8861;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;205;-6498.113,1031.293;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;108;-5350.162,-3119.722;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;180;-6241.885,35.78951;Inherit;True;Property;_TextureSample3;Texture Sample 3;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;136;-5354.869,-2135.658;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;227;-6755.85,2067.767;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-2297.633,-3203.777;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;226;-6715.517,1897.764;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;282;-1824.001,-5065.751;Inherit;True;Property;_TextureSample9;Texture Sample 9;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;140;-4423.202,-1659.833;Inherit;False;Constant;_half;half;20;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;280;-2080.228,-4070.248;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;370;-6276.14,-2502.709;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;310;-1740.216,-4699.351;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;368;-1997.082,446.1848;Inherit;False;1439.114;343.3834;AntiAlias;6;358;355;354;353;356;352;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;283;-2337.966,-3033.774;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;-5552.894,-1134.338;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;311;-1545.604,-4834.958;Inherit;False;Mask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;284;-1510.699,-5148.553;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;361;-518.7509,-2367.497;Inherit;False;1695.666;516.2383;Back;8;8;21;10;16;11;12;20;6;;0.8207547,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;369;-4028.097,-2479.563;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;332;-2275.874,488.0554;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;139;-4235.629,-1785.648;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.5471698;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;285;-2082.533,-3105.377;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;207;-6230.619,1004.395;Inherit;True;Property;_TextureSample5;Texture Sample 5;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;287;-1812.735,-4097.146;Inherit;True;Property;_TextureSample10;Texture Sample 10;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;245;-6300.06,329.5081;Inherit;False;241;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;188;-5928.583,-47.01325;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;161;-5353.607,-1131.588;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;358;-1947.082,673.5682;Inherit;False;Property;_CircleMask_Subtract;CircleMask_Subtract;33;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;228;-6500.418,1996.164;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-446.9003,-2294.439;Float;False;Property;_BackDepthScale;Back Depth Scale;7;0;Create;True;0;0;0;False;0;False;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;246;-6157.817,1601.509;Inherit;False;241;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;291;-1390.672,-4705.69;Inherit;False;Property;_TopWaveLine_Color1;TopWaveLine_Color1;26;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.3999999,0.3999999,0.3999999,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;10;-350.1867,-2186.722;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;292;-1739.933,-3500.032;Inherit;False;311;Mask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;290;-1303.257,-4998.778;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;288;-1815.04,-3132.275;Inherit;True;Property;_TextureSample11;Texture Sample 11;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;289;-1499.433,-4179.949;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;163;-4089.251,-1661.04;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;210;-5917.317,921.5921;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;-5721.141,102.7624;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;232;-6232.924,1969.266;Inherit;True;Property;_TextureSample6;Texture Sample 6;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;85;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;355;-1707.053,496.1848;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;182;-5864.896,342.5557;Inherit;False;Property;_WaveLine_1_Color;WaveLine_1_Color;23;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.4339613,0.4339613,0.4339613,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;244;-4008.936,-2478.254;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-392.3603,-2008.756;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-5709.874,1071.368;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;352;-1510.498,497.4542;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;233;-5919.622,1886.463;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;297;-1807.113,-2819.924;Inherit;False;311;Mask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;295;-1140.259,-4949.586;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ParallaxMappingNode;12;133.285,-2295.055;Inherit;False;Planar;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;293;-1291.99,-4030.173;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-3831.501,-1609.895;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;296;-1435.745,-3790.38;Inherit;False;Property;_TopWaveLine_Color_2;TopWaveLine_Color_2;27;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2999999,0.2999999,0.2999999,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;294;-1501.738,-3215.078;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;247;-6170.018,2521.168;Inherit;False;241;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;211;-5853.629,1311.161;Inherit;False;Property;_WaveLine_2_Color;WaveLine_2_Color;24;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1886785,0.1886785,0.1886785,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-5558.143,151.9538;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;189;-3552.929,-1518.344;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;-5546.877,1120.559;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PiNode;356;-1294.647,497.6726;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;299;-1294.295,-3065.302;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;300;-1438.05,-2825.509;Inherit;False;Property;_TopWaveLine_Color_3;TopWaveLine_Color_3;28;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2999999,0.2999999,0.2999999,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;362;636.0209,-456.894;Inherit;False;1292.256;529.6582;Plus;7;314;315;319;316;317;321;320;;0.02512543,0.001779997,0.3773585,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;445.8799,-2317.497;Inherit;True;Property;_Bottom;Bottom;4;0;Create;True;0;0;0;False;0;False;-1;None;f153ecd6357f5f84cab3797c525dec4f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;236;-5855.934,2276.032;Inherit;False;Property;_WaveLine_3_Color;WaveLine_3_Color;25;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1132067,0.1132067,0.1132067,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;302;-274.2748,-3907.652;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;298;-1128.993,-3980.982;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-5712.179,2036.239;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;301;-1131.298,-3016.111;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;8;777.0167,-2312.887;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;216;-3333.545,-1443.518;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;21;751.6739,-2063.259;Inherit;False;Property;_BottomColorTint;BottomColorTint;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.3999999,0.3999999,0.3999999,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;319;743.7949,-406.894;Inherit;False;0;317;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;303;-54.89063,-3832.826;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-5549.182,2085.43;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;315;686.0209,-262.6354;Float;False;Property;_PlusDepth;PlusDepth;8;0;Create;True;0;0;0;False;0;False;0;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;353;-1100.506,496.8759;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;314;779.3731,-165.0025;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;240;-3064.284,-1366.255;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;1014.915,-2208.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;304;185.7364,-3739.504;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ParallaxMappingNode;316;1075.052,-359.7545;Inherit;False;Planar;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;354;-847.968,496.2816;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;321;1440.408,-139.2357;Inherit;False;Property;_PlusColor;PlusColor;19;0;Create;True;1;Colors;0;0;False;0;False;0,0,0,0;0.2924527,0.2924527,0.2924527,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;359;-1187.895,-696.9398;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;317;1353.422,-382.6895;Inherit;True;Property;_Plus;Plus;3;0;Create;True;0;0;0;False;0;False;-1;None;77cebb4dd6e1a704e829514378ffd8bc;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;305;1507.341,-2231.902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;363;-432.788,494.9114;Inherit;False;CircleMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;782.4195,-1502.474;Inherit;True;Property;_Top;Top;1;0;Create;True;0;0;0;False;0;False;-1;None;b86f9828e98b6074bad282616e56bc5e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;365;1680.714,-1786.806;Inherit;False;363;CircleMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;320;1766.277,-377.8088;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;360;-1168.195,-693.2017;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;372;2282.624,-778.9797;Inherit;False;478.5791;283.0257;CenterMask;2;76;373;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;371;1556.554,-1548.355;Inherit;False;531.9855;304;Circle_Black;2;364;248;;0,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;1780.555,-2003.617;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;1606.554,-1367.677;Inherit;False;363;CircleMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;373;2354.29,-606.6321;Inherit;False;363;CircleMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;75;1954.007,-1935.885;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;318;2122.879,-704.8552;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;248;1823.539,-1498.355;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;376;2447.923,-1293.497;Inherit;False;0;374;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;76;2579.203,-728.9797;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;374;2815.832,-1223.128;Inherit;True;Property;_Date;Date;34;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;250;2870.408,-762.9093;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;382;3179.944,-851.89;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;328;2935.205,-562.9996;Inherit;False;Property;_EmissionTint;EmissionTint;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;312;2862.187,-330.5049;Inherit;True;Property;_MetalicMask;MetalicMask;5;0;Create;True;0;0;0;False;0;False;-1;None;92ec5e5190f546f4d87bdae6ab2d7ede;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;3340.353,-294.2466;Inherit;False;Property;_Smoothness;Smoothness;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;156;-6166.814,-827.8553;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;131;-6107.533,-1882.141;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;3236.63,-579.8575;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3654.03,-741.1754;Float;False;True;-1;2;;0;0;Standard;ShaderFes/PosterShader2021;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;90;0;89;0
WireConnection;124;0;118;1
WireConnection;124;1;120;1
WireConnection;102;0;29;2
WireConnection;102;1;107;2
WireConnection;122;0;120;3
WireConnection;122;1;119;0
WireConnection;82;0;107;3
WireConnection;82;1;79;0
WireConnection;106;0;29;1
WireConnection;106;1;107;1
WireConnection;91;0;90;0
WireConnection;91;1;112;0
WireConnection;123;0;118;2
WireConnection;123;1;120;2
WireConnection;148;0;145;3
WireConnection;148;1;144;0
WireConnection;80;0;106;0
WireConnection;80;1;82;0
WireConnection;80;2;107;3
WireConnection;149;0;143;2
WireConnection;149;1;145;2
WireConnection;146;0;143;1
WireConnection;146;1;145;1
WireConnection;127;0;124;0
WireConnection;127;1;122;0
WireConnection;127;2;120;3
WireConnection;125;0;123;0
WireConnection;125;1;120;4
WireConnection;103;0;102;0
WireConnection;103;1;107;4
WireConnection;110;0;91;0
WireConnection;150;0;149;0
WireConnection;150;1;145;4
WireConnection;151;0;146;0
WireConnection;151;1;148;0
WireConnection;151;2;145;3
WireConnection;129;0;127;0
WireConnection;129;1;125;0
WireConnection;241;0;110;0
WireConnection;78;0;80;0
WireConnection;78;1;103;0
WireConnection;260;0;257;1
WireConnection;260;1;256;1
WireConnection;85;1;78;0
WireConnection;263;0;257;2
WireConnection;263;1;256;2
WireConnection;262;0;256;3
WireConnection;262;1;255;0
WireConnection;341;0;329;2
WireConnection;132;1;129;0
WireConnection;172;0;166;1
WireConnection;172;1;167;1
WireConnection;170;0;167;3
WireConnection;170;1;168;0
WireConnection;155;0;151;0
WireConnection;155;1;150;0
WireConnection;171;0;166;2
WireConnection;171;1;167;2
WireConnection;133;0;132;0
WireConnection;133;1;242;0
WireConnection;173;0;171;0
WireConnection;173;1;167;4
WireConnection;267;0;260;0
WireConnection;267;1;262;0
WireConnection;267;2;256;3
WireConnection;114;0;85;0
WireConnection;114;1;241;0
WireConnection;198;0;197;3
WireConnection;198;1;196;0
WireConnection;200;0;195;1
WireConnection;200;1;197;1
WireConnection;174;0;172;0
WireConnection;174;1;170;0
WireConnection;174;2;167;3
WireConnection;268;0;263;0
WireConnection;268;1;256;4
WireConnection;273;0;265;2
WireConnection;273;1;259;2
WireConnection;307;0;306;0
WireConnection;199;0;195;2
WireConnection;199;1;197;2
WireConnection;157;1;155;0
WireConnection;349;0;341;0
WireConnection;349;1;350;0
WireConnection;271;0;265;1
WireConnection;271;1;259;1
WireConnection;270;0;259;3
WireConnection;270;1;261;0
WireConnection;192;0;91;0
WireConnection;275;0;273;0
WireConnection;275;1;259;4
WireConnection;309;0;307;0
WireConnection;309;1;308;0
WireConnection;279;0;267;0
WireConnection;279;1;268;0
WireConnection;277;0;271;0
WireConnection;277;1;270;0
WireConnection;277;2;259;3
WireConnection;276;0;272;3
WireConnection;276;1;269;0
WireConnection;278;0;266;1
WireConnection;278;1;272;1
WireConnection;274;0;266;2
WireConnection;274;1;272;2
WireConnection;222;0;219;3
WireConnection;222;1;221;0
WireConnection;201;0;200;0
WireConnection;201;1;198;0
WireConnection;201;2;197;3
WireConnection;178;0;174;0
WireConnection;178;1;173;0
WireConnection;223;0;220;1
WireConnection;223;1;219;1
WireConnection;159;0;157;0
WireConnection;159;1;243;0
WireConnection;345;0;329;0
WireConnection;345;1;349;0
WireConnection;84;0;114;0
WireConnection;84;1;23;0
WireConnection;224;0;220;2
WireConnection;224;1;219;2
WireConnection;202;0;199;0
WireConnection;202;1;197;4
WireConnection;135;0;133;0
WireConnection;135;1;137;0
WireConnection;340;0;345;0
WireConnection;340;1;348;0
WireConnection;205;0;201;0
WireConnection;205;1;202;0
WireConnection;108;0;84;0
WireConnection;180;1;178;0
WireConnection;136;0;135;0
WireConnection;227;0;224;0
WireConnection;227;1;219;4
WireConnection;281;0;278;0
WireConnection;281;1;276;0
WireConnection;281;2;272;3
WireConnection;226;0;223;0
WireConnection;226;1;222;0
WireConnection;226;2;219;3
WireConnection;282;1;279;0
WireConnection;280;0;277;0
WireConnection;280;1;275;0
WireConnection;370;0;192;0
WireConnection;310;0;309;0
WireConnection;283;0;274;0
WireConnection;283;1;272;4
WireConnection;160;0;159;0
WireConnection;160;1;158;0
WireConnection;311;0;310;0
WireConnection;284;0;282;0
WireConnection;369;0;370;0
WireConnection;332;1;340;0
WireConnection;139;0;108;0
WireConnection;139;1;136;0
WireConnection;139;2;140;0
WireConnection;285;0;281;0
WireConnection;285;1;283;0
WireConnection;207;1;205;0
WireConnection;287;1;280;0
WireConnection;188;0;180;0
WireConnection;161;0;160;0
WireConnection;228;0;226;0
WireConnection;228;1;227;0
WireConnection;290;0;284;0
WireConnection;290;1;311;0
WireConnection;288;1;285;0
WireConnection;289;0;287;0
WireConnection;163;0;139;0
WireConnection;163;1;161;0
WireConnection;163;2;140;0
WireConnection;210;0;207;0
WireConnection;190;0;188;0
WireConnection;190;1;245;0
WireConnection;232;1;228;0
WireConnection;355;0;332;0
WireConnection;355;1;358;0
WireConnection;244;0;369;0
WireConnection;212;0;210;0
WireConnection;212;1;246;0
WireConnection;352;0;355;0
WireConnection;233;0;232;0
WireConnection;295;0;290;0
WireConnection;295;1;291;0
WireConnection;12;0;11;0
WireConnection;12;2;16;0
WireConnection;12;3;10;0
WireConnection;293;0;289;0
WireConnection;293;1;292;0
WireConnection;191;0;163;0
WireConnection;191;1;244;0
WireConnection;294;0;288;0
WireConnection;183;0;190;0
WireConnection;183;1;182;0
WireConnection;189;0;191;0
WireConnection;189;1;183;0
WireConnection;213;0;212;0
WireConnection;213;1;211;0
WireConnection;356;0;352;0
WireConnection;299;0;294;0
WireConnection;299;1;297;0
WireConnection;6;1;12;0
WireConnection;302;1;295;0
WireConnection;298;0;293;0
WireConnection;298;1;296;0
WireConnection;235;0;233;0
WireConnection;235;1;247;0
WireConnection;301;0;299;0
WireConnection;301;1;300;0
WireConnection;8;0;6;0
WireConnection;216;0;189;0
WireConnection;216;1;213;0
WireConnection;303;0;302;0
WireConnection;303;1;298;0
WireConnection;237;0;235;0
WireConnection;237;1;236;0
WireConnection;353;0;356;0
WireConnection;240;0;216;0
WireConnection;240;1;237;0
WireConnection;20;0;8;0
WireConnection;20;1;21;0
WireConnection;304;0;303;0
WireConnection;304;1;301;0
WireConnection;316;0;319;0
WireConnection;316;2;315;0
WireConnection;316;3;314;0
WireConnection;354;0;353;0
WireConnection;359;0;240;0
WireConnection;317;1;316;0
WireConnection;305;0;304;0
WireConnection;305;1;20;0
WireConnection;363;0;354;0
WireConnection;1;1;11;0
WireConnection;320;0;317;0
WireConnection;320;1;321;0
WireConnection;360;0;359;0
WireConnection;19;0;305;0
WireConnection;19;1;1;1
WireConnection;75;0;19;0
WireConnection;75;2;365;0
WireConnection;318;0;360;0
WireConnection;318;1;320;0
WireConnection;248;1;1;1
WireConnection;248;2;364;0
WireConnection;76;0;75;0
WireConnection;76;1;318;0
WireConnection;76;2;373;0
WireConnection;374;1;376;0
WireConnection;250;0;248;0
WireConnection;250;1;76;0
WireConnection;382;0;250;0
WireConnection;382;1;374;0
WireConnection;323;0;382;0
WireConnection;323;1;328;0
WireConnection;0;0;382;0
WireConnection;0;2;323;0
WireConnection;0;3;312;1
WireConnection;0;4;3;0
ASEEND*/
//CHKSM=A9E7020BE8C5964FB9AFEC2E9E77F292895027DC