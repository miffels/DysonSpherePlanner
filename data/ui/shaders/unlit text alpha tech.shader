Shader "UI Ex/Text Alpha Tech (for credits)" {
	Properties {
		_MainTex ("Font Texture", 2D) = "white" {}
		_Multiplier ("Multiplier", Float) = 1
		_Color ("Text Color", Vector) = (1,1,1,1)
		_ScanLineOmega ("Scan Line (freq, amp, level, )", Vector) = (10,0.7,0.3,0)
		_AnimFade ("Fade", Float) = 0
		_FadeArea ("Fade Area", Vector) = (0,1,0,0)
		_FadeOffset ("Fade Offset Texture", 2D) = "black" {}
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
			GpuProgramID 13524
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _Color;
						vec4 unused_0_3[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
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
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						float _Multiplier;
						vec4 _ScanLineOmega;
						float _AnimFade;
						vec4 _FadeArea;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _FadeOffset;
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy + (-_FadeArea.xz);
					    u_xlat4.xy = (-_FadeArea.xz) + _FadeArea.yw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
					    u_xlat0.z = (-u_xlat0.y) + 1.0;
					    u_xlat1 = texture(_FadeOffset, u_xlat0.xz);
					    u_xlat2 = _AnimFade + -1.0;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.y = u_xlat1.x * 2.0 + u_xlat0.x;
					    u_xlat0.xy = u_xlat0.xy * vec2(500.0, 500.0);
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat0.y;
					    u_xlat0.x = u_xlat0.x + -0.300000012;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4.x = u_xlat1.w * vs_COLOR0.w;
					    u_xlat6 = (-vs_COLOR0.w) * u_xlat1.w + 0.200000003;
					    u_xlat0.x = u_xlat0.x * u_xlat6 + u_xlat4.x;
					    u_xlat4.x = u_xlat0.x + -0.00100000005;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlatb4 = u_xlat4.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = _Time.y * 0.0199999996 + vs_TEXCOORD1.y;
					    u_xlat4.x = u_xlat4.x * _ScanLineOmega.x;
					    u_xlat4.x = sin(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _ScanLineOmega.y;
					    u_xlat4.x = max(u_xlat4.x, -1.0);
					    u_xlat4.x = min(u_xlat4.x, 1.0);
					    u_xlat4.x = u_xlat4.x + _ScanLineOmega.z;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat2 = u_xlat0.y * u_xlat4.x;
					    u_xlat4.x = inversesqrt(_Multiplier);
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = u_xlat2 * u_xlat0.x;
					    SV_Target0.xyz = vs_COLOR0.xyz * vec3(_Multiplier);
					    return;
					}"
				}
			}
		}
	}
}