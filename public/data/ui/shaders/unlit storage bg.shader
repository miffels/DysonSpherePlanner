Shader "UI Ex/Storage Bg" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Multiplier ("Multiplier", Float) = 1
		_AlphaPower ("Alpha Power", Float) = 1
		_Color ("Tint", Vector) = (1,1,1,1)
		_Grid ("Grid", Vector) = (1,1,1,1)
		_Bans ("Bans", Float) = 0
		_BansColor ("Bans Color", Vector) = (0,0,0,0.1)
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
			GpuProgramID 7588
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
						vec4 unused_0_2[4];
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
						float _AlphaPower;
						vec4 _Grid;
						float _Bans;
						vec4 _BansColor;
					};
					uniform  sampler2D _MainTex;
					 struct _StateBuffer_type {
						uint[1] value;
					};
					
					layout(std430, binding = 0) readonly buffer _StateBuffer {
						_StateBuffer_type _StateBuffer_buf[];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					uint u_xlatu1;
					bool u_xlatb1;
					vec2 u_xlat4;
					uvec2 u_xlatu4;
					bool u_xlatb4;
					float u_xlat6;
					int u_xlati6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Grid.xy;
					    u_xlatb4 = u_xlat0.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb4 = _Grid.x<u_xlat0.x;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb4 = u_xlat0.y<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb4 = _Grid.y<u_xlat0.y;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = vs_TEXCOORD0.x * _Grid.x;
					    u_xlat6 = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat4.y = u_xlat6 * _Grid.y;
					    u_xlatu4.xy = uvec2(u_xlat4.xy);
					    u_xlat4.xy = vec2(u_xlatu4.xy);
					    u_xlat4.x = u_xlat4.y * _Grid.x + u_xlat4.x;
					    u_xlatu4.x = uint(u_xlat4.x);
					    u_xlat6 = float(u_xlatu4.x);
					    u_xlat1.x = _Grid.x * _Grid.y + (-_Bans);
					    u_xlat6 = u_xlat6 + (-u_xlat1.x);
					    u_xlat6 = u_xlat6 + 0.5;
					    u_xlat6 = u_xlat6 * 10.0;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat6);
					    if(u_xlatb6){
					        SV_Target0 = _BansColor;
					        return;
					    }
					    u_xlatu1 = _StateBuffer_buf[u_xlatu4.x].value[(0 >> 2) + 0];
					    u_xlatu4.x = u_xlatu1 >> 3u;
					    u_xlati6 = int(u_xlatu1 & 7u);
					    u_xlatb6 = u_xlati6==0;
					    u_xlatb1 = int(u_xlatu4.x)==0;
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb4 = int(u_xlatu4.x)==1;
					    if(u_xlatb4){
					        SV_Target0 = _BansColor;
					        return;
					    }
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.x = log2(u_xlat0.w);
					    u_xlat1.x = u_xlat1.x * _AlphaPower;
					    u_xlat0.w = exp2(u_xlat1.x);
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