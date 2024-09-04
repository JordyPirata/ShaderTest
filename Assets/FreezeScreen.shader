Shader "Unlit/FreezeScreen"
{
    Properties
    {
        _IceTexture ("Ice Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue" = "AlphaTest" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100
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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _IceTexture;
            float4 _IceTexture_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _IceTexture);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float4 IceColor = tex2D(_IceTexture, i.uv);
                // color with alpha 0 is transparent
                float4 transparent = float4(1,1,1,0);
                float blendFactor = 1-i.uv.x; // Use the horizontal UV coordinate
                float4 firtsImage = lerp(IceColor, transparent, blendFactor);
                blendFactor = 1-i.uv.y; // Use the vertical UV coordinate
                float4 secondImage = lerp(firtsImage, transparent, blendFactor);

                return (secondImage + firtsImage) * 0.5;
            }
            ENDCG
        }
    }
}
