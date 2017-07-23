Shader "Custom/HeatMapShader"
{
	Properties
	{
		
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 col : COLOR;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;

				float4 wv = mul(unity_ObjectToWorld, v.vertex);

				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				return i.col;
			}
			ENDCG
		}
	}
}
