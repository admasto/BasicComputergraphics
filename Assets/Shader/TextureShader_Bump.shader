Shader "Unlit/TextureShader_Bump"
{
	
	// Tutorial - Vertex und Fragment Shader examples: https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html 

	Properties
	{
		_MainTex ("Color Texture", 2D) = "white" {}
		_BumpMap ("Bump Map", 2D) = "bump" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
        LOD 100

		Pass
		{
			CGPROGRAM

			// Definition über die Shader die verwendet werden, und wie sie heißen
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"			
			#include "Lighting.cginc" // für Lighting

			// Struct zum Austausch der Daten zwischen Vertex und Fragment Shader
			struct v2f
			{
				// Weitergabe der konvertierten Vertex Positionen in Homogenen Koordinaten
				float4 vertex : SV_POSITION;

				// Weitergabe der Textur Koordinaten
				float2 uv : TEXCOORD0;


			};
			
			// Zu verwendende Textur
            sampler2D _MainTex;
			sampler2D _BumpMap;

			// VERTEX SHADER
			// 'appdata_base' ist ein standard struct das genutzt werden kann um den Vertex Shader mit Daten zu füttern
			// https://docs.unity3d.com/Manual/SL-VertexProgramInputs.html
			// http://wiki.unity3d.com/index.php?title=Shader_Code
			v2f vert (appdata_base vertexIn)
			{
				v2f vertexOut;

				// Transformation der Vertices aus Objekt-Koordinaten in Clip-Koordinaten
				vertexOut.vertex = UnityObjectToClipPos(vertexIn.vertex);

				// Direkte Weitergabe der interpolierten Texturkoordinaten
				vertexOut.uv = vertexIn.texcoord;

				
				return vertexOut;
			}

			// FRAGMENT / PIXEL SHADER
			// Als input erhält er die interpolierten Output-Daten des Vertex-Shaders.
			// Dieser Typ des Fragment Shaders erfordert eigentlich kein Input, da er für jedes Fragment einfach nur eine Farbe zurück gibt.
			// Output ist 4d vector der die Farbe des Fragments/Pixels angibt.
			// SV_Target gibt an, dass es sich shcon um die "Target" Farbe handelt. Alternativ könnte auch das Struct fragmentOut
			// als Rückgabe des Fragment Shaders verwendet werden.
			fixed4 frag (v2f fragIn) : SV_Target
			{
				// Greife den pixel der Textur an der Stelle (u;v) ab und setze ihn als Farbe.
                fixed4 color = tex2D(_MainTex, fragIn.uv);

				// Berechnen der Normalenvektoren im Welt-Koordinatensystem gegeben der Bumpmap.
				half3 worldNormal = UnpackNormal(tex2D(_BumpMap, fragIn.uv));
				//worldNormal = UnityObjectToWorldNormal(worldNormal);

				// Standard Diffuse (Lambert) Shading
				// Gewichtung durch Skalarprodukt (Dot-Produkt) zwischen Normalen-Vektor
				// Richtung der Beleuchtungsquelle
				half nl = max(0, dot(-worldNormal, _WorldSpaceLightPos0.xyz));
                
				// Diffuser Anteil multipliziert mit der Lichtfarbe
                color *= nl * _LightColor0;

                return color;
			}
			ENDCG
		}
	}
}
