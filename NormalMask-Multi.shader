Shader "Blake/NormalMask Multi"
{
    Properties
    {
        [Header(Main)]
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _OMS ("OMS (RGB)", 2D) = "white" {}
        _Occlusion("Occlusion", Range(0,1)) = 1.0
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.0

        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalStrength ("Normal Strength", Range(0, 2)) = 1.0
        _DetailNormalMap ("Detail Normal Map", 2D) = "bump" {}
        _DetailNormalStrength ("Detail Normal Strength", Range(0, 2)) = 1.0

        [Header(Normal Mask 1 (white by def))]
        _NormalMask1 ("Normal Map Mask 1 (RGB)", 2D) = "white" {}
        _MaskRedStrength1 ("Mask 1 Red Strength", Range(0, 1)) = 1.0
        _MaskGreenStrength1 ("Mask 1 Green Strength", Range(0, 1)) = 1.0
        _MaskBlueStrength1 ("Mask 1 Blue Strength", Range(0, 1)) = 1.0

        [Header(Normal Mask 2)]
        _NormalMask2 ("Normal Map Mask 2 (RGB)", 2D) = "black" {}
        _MaskRedStrength2 ("Mask 2 Red Strength", Range(0, 1)) = 1.0
        _MaskGreenStrength2 ("Mask 2 Green Strength", Range(0, 1)) = 1.0
        _MaskBlueStrength2 ("Mask 2 Blue Strength", Range(0, 1)) = 1.0

        [Header(Normal Mask 3)]
        _NormalMask3 ("Normal Map Mask 3 (RGB)", 2D) = "black" {}
        _MaskRedStrength3 ("Mask 3 Red Strength", Range(0, 1)) = 1.0
        _MaskGreenStrength3 ("Mask 3 Green Strength", Range(0, 1)) = 1.0
        _MaskBlueStrength3 ("Mask 3 Blue Strength", Range(0, 1)) = 1.0

        [Header(Normal Mask 4)]
        _NormalMask4 ("Normal Map Mask 4 (RGB)", 2D) = "black" {}
        _MaskRedStrength4 ("Mask 4 Red Strength", Range(0, 1)) = 1.0
        _MaskGreenStrength4 ("Mask 4 Green Strength", Range(0, 1)) = 1.0
        _MaskBlueStrength4 ("Mask 4 Blue Strength", Range(0, 1)) = 1.0

        [Header(Normal Mask 5)]
        _NormalMask5 ("Normal Map Mask 5 (RGB)", 2D) = "black" {}
        _MaskRedStrength5 ("Mask 5 Red Strength", Range(0, 1)) = 1.0
        _MaskGreenStrength5 ("Mask 5 Green Strength", Range(0, 1)) = 1.0
        _MaskBlueStrength5 ("Mask 5 Blue Strength", Range(0, 1)) = 1.0

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.5

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _NormalMask1;
        sampler2D _NormalMask2;
        sampler2D _NormalMask3;
        sampler2D _NormalMask4;
        sampler2D _NormalMask5;
        sampler2D _DetailNormalMap;
        sampler2D _OMS;
        half _Occlusion;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        half _NormalStrength;
        half _DetailNormalStrength;

        half _MaskRedStrength1, _MaskGreenStrength1;
        half _MaskRedStrength2, _MaskGreenStrength2;
        half _MaskRedStrength3, _MaskGreenStrength3;
        half _MaskRedStrength4, _MaskGreenStrength4;
        half _MaskRedStrength5, _MaskGreenStrength5;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float2 uv_DetailNormalMap;
            float2 uv_OMS;
            float2 uv_NormalMask1;
            float2 uv_NormalMask2;
            float2 uv_NormalMask3;
            float2 uv_NormalMask4;
            float2 uv_NormalMask5;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            fixed4 oms = tex2D(_OMS, IN.uv_OMS); 
            half occlusion = oms.r * _Occlusion;
            half metallic = oms.g * _Metallic;
            half smoothess = oms.b * _Glossiness;

            o.Albedo = c.rgb;
            o.Occlusion = occlusion;
            o.Metallic = metallic;
            o.Smoothness = smoothess;

            fixed3 tangentNormal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
            fixed3 detailNormal = UnpackNormal(tex2D(_DetailNormalMap, IN.uv_DetailNormalMap));


            fixed4 mask1 = tex2D(_NormalMask1, IN.uv_NormalMask1);
            fixed4 mask2 = tex2D(_NormalMask2, IN.uv_NormalMask2);
            fixed4 mask3 = tex2D(_NormalMask3, IN.uv_NormalMask3);
            fixed4 mask4 = tex2D(_NormalMask4, IN.uv_NormalMask4);
            fixed4 mask5 = tex2D(_NormalMask5, IN.uv_NormalMask5);

            fixed redMax = max(mask1.r * _MaskRedStrength1, max(mask2.r * _MaskRedStrength2, max(mask3.r * _MaskRedStrength3, max(mask4.r * _MaskRedStrength4, mask5.r * _MaskRedStrength5))));
            fixed greenMax = max(mask1.g * _MaskGreenStrength1, max(mask2.g * _MaskGreenStrength2, max(mask3.g * _MaskGreenStrength3, max(mask4.g * _MaskGreenStrength4, mask5.g * _MaskGreenStrength5))));
            fixed blueMax = max(mask1.b * _MaskGreenStrength1, max(mask2.b * _MaskGreenStrength2, max(mask3.b * _MaskGreenStrength3, max(mask4.b * _MaskGreenStrength4, mask5.b * _MaskGreenStrength5))));

            fixed maxMaskFactor = max(redMax, max(greenMax,blueMax));

            tangentNormal *= _NormalStrength;

            fixed3 blendedNormal = fixed3(0, 0, 1).xyz;
            blendedNormal.x = lerp(blendedNormal.x, tangentNormal.x, maxMaskFactor);
            blendedNormal.y = lerp(blendedNormal.y, tangentNormal.y, maxMaskFactor);
            // o.Normal = blendedNormal;

            detailNormal *= _DetailNormalStrength;
            fixed3 mix = fixed3(0,0,1).xyz;
            mix.x = saturate(blendedNormal.x *2 + detailNormal.x *2);
            mix.y = saturate(blendedNormal.y *2 + detailNormal.y *2);
            o.Normal = mix;

        }
        ENDCG
    }
    FallBack "Diffuse"
}

// Originally created by Bl@ke, on October 15, 2024.