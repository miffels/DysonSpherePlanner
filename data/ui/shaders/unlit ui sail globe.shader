Shader "UI Ex/Sail Globe" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Multiplier ("Multiplier", Float) = 1
		_AlphaPower ("Alpha Power", Float) = 1
		_Color ("Tint", Vector) = (1,1,1,1)
		_SkyColor ("sky Tint", Vector) = (1,1,1,1)
		_TerrColor ("terrain Tint", Vector) = (1,1,1,1)
		_Sharp ("Sharp", Float) = 1
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
			GpuProgramID 57099
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
						vec4 _Color;
						vec4 unused_0_2[17];
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
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_0[3];
						float _Multiplier;
						float _Sharp;
						float _AlphaPower;
						vec4 _SkyColor;
						vec4 _TerrColor;
						vec4 _Direction0;
						float _DotThresh0;
						vec4 _Direction1;
						float _DotThresh1;
						vec4 _Direction2;
						float _DotThresh2;
						vec4 _Direction3;
						float _DotThresh3;
						vec4 _Direction4;
						float _DotThresh4;
						vec4 _Direction5;
						float _DotThresh5;
						vec4 _Direction6;
						float _DotThresh6;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat3 = sqrt(u_xlat0.x);
					    u_xlatb3 = u_xlat3>=1.0;
					    if(((int(u_xlatb3) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9 = max(_DotThresh0, -1.0);
					    u_xlat9 = min(u_xlat9, 1.0);
					    u_xlat0.w = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat0.zw = sqrt(u_xlat0.xw);
					    u_xlat9 = u_xlat0.w + 9.99999975e-05;
					    u_xlat1.x = dot(_Direction0, _Direction0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * _Direction0.xyz;
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat10 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat10);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat1.x = u_xlat1.x + (-_DotThresh0);
					    u_xlat9 = 20.0 / u_xlat9;
					    u_xlat9 = u_xlat1.x * u_xlat9 + 0.5;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.x = max(_DotThresh1, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction1, _Direction1);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction1.xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat4.x + (-_DotThresh1);
					    u_xlat1.x = 20.0 / u_xlat1.x;
					    u_xlat1.x = u_xlat4.x * u_xlat1.x + 0.5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = max(u_xlat9, u_xlat1.x);
					    u_xlat1.x = max(_DotThresh2, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction2, _Direction2);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction2.xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat4.x + (-_DotThresh2);
					    u_xlat1.x = 20.0 / u_xlat1.x;
					    u_xlat1.x = u_xlat4.x * u_xlat1.x + 0.5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = max(u_xlat9, u_xlat1.x);
					    u_xlat1.x = max(_DotThresh3, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction3, _Direction3);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction3.xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat4.x + (-_DotThresh3);
					    u_xlat1.x = 20.0 / u_xlat1.x;
					    u_xlat1.x = u_xlat4.x * u_xlat1.x + 0.5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = max(u_xlat9, u_xlat1.x);
					    u_xlat1.x = max(_DotThresh4, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction4, _Direction4);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction4.xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat4.x + (-_DotThresh4);
					    u_xlat1.x = 20.0 / u_xlat1.x;
					    u_xlat1.x = u_xlat4.x * u_xlat1.x + 0.5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = max(u_xlat9, u_xlat1.x);
					    u_xlat1.x = max(_DotThresh5, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction5, _Direction5);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction5.xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat4.x + (-_DotThresh5);
					    u_xlat1.x = 20.0 / u_xlat1.x;
					    u_xlat1.x = u_xlat4.x * u_xlat1.x + 0.5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = max(u_xlat9, u_xlat1.x);
					    u_xlat1.x = max(_DotThresh6, -1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
					    u_xlat4.x = dot(_Direction6, _Direction6);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * _Direction6.xyz;
					    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x + (-_DotThresh6);
					    u_xlat3 = 20.0 / u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3 + 0.5;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = max(u_xlat0.x, u_xlat9);
					    u_xlat1 = (-_SkyColor) + _TerrColor;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _SkyColor;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.x = log2(u_xlat1.w);
					    u_xlat2.x = u_xlat2.x * _AlphaPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.x = (-u_xlat1.w) + u_xlat2.x;
					    u_xlat1.w = _Sharp * u_xlat2.x + u_xlat1.w;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    u_xlat2 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(_Multiplier);
					    u_xlat0.x = u_xlat1.w * u_xlat0.w + -0.00100000005;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
			}
		}
	}
}