Shader "CGVorlesung/NormalShader"
{
	Properties
	{
	

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;

			};

			float _DepthNear;
			float _DepthFar;


			v2f vert (appdata_base  v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				o.color.xyz = v.normal*0.5 + 0.5;
				o.color.w = 1.0;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = i.color;
				return col;
			}
			ENDCG
		}
	}
}
