// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
Shader "Custom/HeatMapShader"
{
	Properties
	{
		// "Grundwärme"
		_objectTemperature("Object Temperature", float) = 0.0
		// object surface area
		_objectSurfaceArea("Object Surface Area", float) = 0.0
		// ratio between reflected and absorbed energy
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
			uniform float _objectSurfaceArea;
			uniform float _heatSourceSurfaceArea;
			uniform float _heatSourceTemperature;	
			uniform float4 _heatSourcePosition;

			struct v2f
			{
				float4 vertex : SV_POSITION;
				// vertex color attribute
				fixed4 col : COLOR;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;

				// convert object space to world space
				float4 wv = mul(unity_ObjectToWorld, v.vertex);

				// direction to heat source
				float4 direction = _heatSourcePosition - wv;
				// distance to heat source
				float distance = length(_heatSourcePosition - wv);

				// PI
				const float PI = 3.14159;
				// bolzmann constant
				const float BOLZMANN_CONSTANT = 0.0000000567;

				float energy;
				// reflected energy
				float reflected;

				// no heat from source available
				if (_heatSourceTemperature <= _objectTemperature)
				{
					// energy only consists of object energy
					energy = _objectSurfaceArea * BOLZMANN_CONSTANT * pow(_objectTemperature, 4);
					// reflected energy equals object energy, no energy ratio needed
					reflected = energy;
				}
				else
				{
					// dot product returns cosinus between normal vector and direction to heat source
					energy = _heatSourceSurfaceArea * BOLZMANN_CONSTANT * pow(_heatSourceTemperature, 4) * dot(direction, v.normal) / (4 * PI * pow(distance, 2));
					// reflected energy is calculated by multiplying the energy ratio with the total energy
					reflected = energy * _energyRatio;
				}

				// HEATMAP ALGORITHM BY ANDREW NOSKE

				int num_col = 4;
				// color map
				float4x3 color = float4x3 (
					// blue
					0.0, 0.0, 1.0,
					// green
					0.0, 1.0, 0.0,
					//yellow
					1.0, 1.0, 0.0,
					// red
					1.0, 0.0, 0.0
				);
				
				// index 1
				int min_value;
				// index 2
				int max_value;

				// fraction between min and max value
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
					min_value = floor(reflected);
					max_value = min_value + 1;
					fraction = reflected - float(min_value);
				}

				float red = (color[max_value][0] - color[min_value][0]) * fraction + color[min_value][0];
				float green = (color[max_value][1] - color[min_value][1]) * fraction + color[min_value][1];
				float blue = (color[max_value][2] - color[min_value][2]) * fraction + color[min_value][2];

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
