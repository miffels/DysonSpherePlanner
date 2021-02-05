Shader "UI Ex/Research Stat Histogram" {
	Properties {
		[PerRendererData] _MainTex ("Main Texture", 2D) = "white" {}
		_ProductColor1 ("Prodcut Color 1", Vector) = (1,1,1,1)
		_ZeroColor ("ZeroColor", Vector) = (1,1,1,1)
		_MaxCount1 ("Max Count 1", Float) = 0
		_Multiplier ("Multiplier", Float) = 5
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader {
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask 0 -1
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 11224
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					UNITY_BINDING(1) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					precise vec4 u_xlat_precise_vec4;
					precise ivec4 u_xlat_precise_ivec4;
					precise bvec4 u_xlat_precise_bvec4;
					precise uvec4 u_xlat_precise_uvec4;
					UNITY_BINDING(0) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _ProductColor1;
						vec4 _ZeroColor;
						float _MaxCount1;
						float _Multiplier;
					};
					 struct _Buffer1_type {
						uint[1] value;
					};
					
					layout(std430, binding = 0) readonly buffer _Buffer1 {
						_Buffer1_type _Buffer1_buf[];
					};
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					uvec3 u_xlatu0;
					bool u_xlatb0;
					vec2 u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					bool u_xlatb2;
					vec2 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y + 0.00249999994;
					    u_xlatb0 = abs(u_xlat0.x)<0.00124999997;
					    if(u_xlatb0){
					        SV_Target0 = _ZeroColor;
					        return;
					    }
					    u_xlatb0 = 1.0<vs_TEXCOORD0.y;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = vs_TEXCOORD0.x * 600.0 + -0.5;
					    u_xlat0.x = roundEven(u_xlat0.x);
					    u_xlat2.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
					    u_xlat2.xy = (bool(u_xlatb2)) ? vec2(2.0, 0.5) : vec2(-2.0, -0.5);
					    u_xlat4.x = u_xlat2.y * u_xlat0.x;
					    u_xlat6 = u_xlat0.x * 0.0166666675;
					    u_xlat6 = floor(u_xlat6);
					    u_xlat1.x = u_xlat6 + u_xlat6;
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(2.0, 0.5) : vec2(-2.0, -0.5);
					    u_xlat4.y = u_xlat6 * u_xlat1.y;
					    u_xlat4.xy = fract(u_xlat4.xy);
					    u_xlat2.x = u_xlat2.x * u_xlat4.x + 0.100000001;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat1.x * u_xlat4.y + 0.800000012;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat2.x = u_xlat4.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 2.0 + 0.5;
					    u_xlatu0.x = uint(u_xlat0.x);
					    u_xlatu0.z = _Buffer1_buf[u_xlatu0.x].value[(0 >> 2) + 0];
					    u_xlati0 = int(u_xlatu0.x) + 1;
					    u_xlatu0.x = _Buffer1_buf[u_xlati0].value[(0 >> 2) + 0];
					    u_xlat0.xz = vec2(u_xlatu0.xz);
					    u_xlat0.x = u_xlat0.x * 4.2949673e+09 + u_xlat0.z;
					    u_xlat4.x = max(_MaxCount1, 1.0);
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    u_xlatb0 = u_xlat0.x<vs_TEXCOORD0.y;
					    u_xlat2.x = u_xlat2.x * 0.150000006;
					    u_xlat0.x = (u_xlatb0) ? u_xlat2.x : 1.0;
					    u_xlat0 = u_xlat0.xxxx * _ProductColor1;
					    SV_Target0 = u_xlat0 * vec4(vec4(_Multiplier, _Multiplier, _Multiplier, _Multiplier));
					    return;
					}"
				}
			}
		}
	}
}