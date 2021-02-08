Shader "UI Ex/Widget Alpha Audio" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Multiplier ("Multiplier", Float) = 1
		_AlphaPower ("Alpha Power", Float) = 1
		_Color ("Tint", Vector) = (1,1,1,1)
		_Sharp ("Sharp", Float) = 1
		_SampleCount ("Sample Count", Float) = 0
		_SampleTime ("Sample Time", Float) = 0
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
			GpuProgramID 54077
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
						vec4 unused_0_2[2];
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
					#ifdef GL_ARB_shader_storage_buffer_object
					#extension GL_ARB_shader_storage_buffer_object : enable
					#endif
					#ifdef GL_ARB_shader_image_load_store
					#extension GL_ARB_shader_image_load_store : enable
					#endif
					
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
						int _SampleCount;
						float _SampleTime;
					};
					uniform  sampler2D _MainTex;
					 struct _SampleBuffer_type {
						uint[1] value;
					};
					
					layout(std430, binding = 0) readonly buffer _SampleBuffer {
						_SampleBuffer_type _SampleBuffer_buf[];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					bool u_xlatb3;
					vec2 u_xlat4;
					uint u_xlatu4;
					float u_xlat6;
					uint u_xlatu6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat4.x = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat6 = float(uint(_SampleCount));
					    u_xlat4.x = u_xlat4.x / u_xlat6;
					    u_xlat4.x = u_xlat4.x * 500.0 + _SampleTime;
					    u_xlat4.x = fract(u_xlat4.x);
					    u_xlatu6 = uint(_SampleCount) + 4294967295u;
					    u_xlat6 = float(u_xlatu6);
					    u_xlat4.x = u_xlat6 * u_xlat4.x;
					    u_xlatu4 = uint(u_xlat4.x);
					    u_xlat1.x = uintBitsToFloat(_SampleBuffer_buf[u_xlatu4].value[(0 >> 2) + 0]);
					    u_xlat4.x = -abs(u_xlat1.x) * 0.800000012 + 1.0;
					    u_xlat4.xy = u_xlat4.xx * u_xlat0.xy;
					    u_xlatb1 = 2u<uint(_SampleCount);
					    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat4.xy : u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = log2(u_xlat0.w);
					    u_xlat1.x = u_xlat1.x * _AlphaPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = (-u_xlat0.w) + u_xlat1.x;
					    u_xlat0.w = _Sharp * u_xlat1.x + u_xlat0.w;
					    u_xlat1 = u_xlat0 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.xyz = u_xlat1.xyz * vec3(_Multiplier);
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
			}
		}
	}
}