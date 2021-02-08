Shader "UI Ex/Storage Icons" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Multiplier ("Multiplier", Float) = 1
		_AlphaPower ("Alpha Power", Float) = 1
		_Color ("Tint", Vector) = (1,1,1,1)
		_Grid ("Grid", Vector) = (1,1,1,1)
		_Rect ("Rect", Vector) = (0.1,0.1,1.25,1.25)
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
			GpuProgramID 44987
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
						vec4 unused_0_2[3];
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
						vec4 _Grid;
						vec4 _Rect;
					};
					uniform  sampler2D _MainTex;
					 struct _IndexBuffer_type {
						uint[1] value;
					};
					
					layout(std430, binding = 0) readonly buffer _IndexBuffer {
						_IndexBuffer_type _IndexBuffer_buf[];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					uvec2 u_xlatu0;
					bool u_xlatb0;
					vec4 u_xlat1;
					float u_xlat2;
					bool u_xlatb2;
					float u_xlat4;
					bool u_xlatb4;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.x * _Grid.x;
					    u_xlat2 = fract(u_xlat0.x);
					    u_xlat2 = u_xlat2 + (-_Rect.x);
					    u_xlat1.x = u_xlat2 * _Rect.z;
					    u_xlatb2 = u_xlat1.x<0.0;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb2 = 1.0<u_xlat1.x;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2 = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat2 = u_xlat2 * _Grid.y;
					    u_xlat4 = fract(u_xlat2);
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat4 = u_xlat4 + (-_Rect.y);
					    u_xlat1.y = u_xlat4 * _Rect.w;
					    u_xlatb4 = u_xlat1.y<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb4 = 1.0<u_xlat1.y;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlatu0.x = uint(u_xlat0.x);
					    u_xlatu0.y = uint(u_xlat2);
					    u_xlat0.xy = vec2(u_xlatu0.xy);
					    u_xlat0.x = u_xlat0.y * _Grid.x + u_xlat0.x;
					    u_xlatu0.x = uint(u_xlat0.x);
					    u_xlatu0.x = _IndexBuffer_buf[u_xlatu0.x].value[(0 >> 2) + 0];
					    if((int(u_xlatu0.x))==0){discard;}
					    u_xlat0.x = float(u_xlatu0.x);
					    u_xlat0.x = u_xlat0.x * _Grid.z;
					    u_xlat4 = floor(u_xlat0.x);
					    u_xlat0.y = u_xlat4 * _Grid.w;
					    u_xlat0.xy = u_xlat1.xy * _Grid.zw + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.w = u_xlat0.w * 1.04999995 + -0.0500000007;
					    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
					    u_xlat1 = u_xlat0 * vs_COLOR0;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(_Multiplier);
					    u_xlat0.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
			}
		}
	}
}