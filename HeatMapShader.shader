Shader "Custom/HeatMapShader"
{
	Properties
	{
		_heatSourcePosition("Heat Source Position", Vector) = (0, 0, 0)
		_heatSourceTemperature("Heat Source Temperature", float) = 0.0
		_objectTemperature("Object Temperature", float) = 0.0
		_energyRatio("Energy Ratio", Range (0.0, 1.0)) = 1.0
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			
			uniform float _energyRatio;
			uniform float _objectTemperature;
			uniform float _heatSourceTemperature;	
			uniform float4 _heatSourcePosition;

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 col : COLOR;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;

				float4 wv = mul(unity_ObjectToWorld, v.vertex);

				float4 direction = wv - _heatSourcePosition;
				float distance = length(wv - _heatSourcePosition);

				const float BOLTZMANN = 0.0000000567;

				float dotProduct = dot(direction, -v.normal);
				float energy = pow(_objectTemperature + _heatSourceTemperature, 4) * BOLTZMANN * dotProduct;

				float reflected = energy * _energyRatio;

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
