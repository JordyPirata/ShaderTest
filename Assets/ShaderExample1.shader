Shader "Unlit/Red"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1) // red in RGBA
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _Color;

            struct MeshData
            {
                float4 vertex : POSITION; // vertex position
                float3 normal : NORMAL; // vertex normal
                float2 uv : TEXCOORD0; 
            };
 
            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);  
                o.normal = v.normal;
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                return float4(i.normal, 1);
            }
            ENDCG
        }
    }
}
