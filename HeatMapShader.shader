// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
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
			// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
			#pragma exclude_renderers gles
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

				int num_col = 4;
				float4x3 color = float4x3 (
					0.0, 0.0, 1.0,
					0.0, 1.0, 0.0,
					1.0, 1.0, 0.0,
					1.0, 0.0, 0.0
				);
				
				int min_value;
				int max_value;

				float fraction = 0;

				if (reflected <= 0)
				{
					min_value = max_value = 0;
				}
				else if (reflected >= 1)
				{
					min_value = max_value = num_col - 1;
				}
				else
				{
					reflected = reflected * (num_col - 1);
					min_value  = floor(reflected);
					max_value  = min_value + 1;

					min_value = float(min_value);
					fraction = reflected - min_value;
				}

				float red   = (color[max_value][0] - color[min_value][0]) * fraction + color[min_value][0];
				float green = (color[max_value][1] - color[min_value][1]) * fraction + color[min_value][1];
				float blue  = (color[max_value][2] - color[min_value][2]) * fraction + color[min_value][2];

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.col.xyz = float3(red, green, blue);
				o.col.w = 1.0;
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
