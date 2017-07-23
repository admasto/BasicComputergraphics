/*using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GreyValueCam : MonoBehaviour {

	private RenderTexture sourceImage;
	private RenderTexture diestinationImage;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void OnRenderImage (source, destination){

	}
}
*/
using System;
using UnityEngine;

namespace UnityStandardAssets.ImageEffects
{
	[ExecuteInEditMode]
	[AddComponentMenu("Image Effects/Color Adjustments/Grayscale")]
	public class Grayscale : ImageEffectBase {
		public Texture  textureRamp;

		[Range(-1.0f,1.0f)]
		public float    rampOffset;

		// Called by camera to apply image effect
		void OnRenderImage (RenderTexture source, RenderTexture destination) {
			material.SetTexture("_RampTex", textureRamp);
			material.SetFloat("_RampOffset", rampOffset);
			Graphics.Blit (source, destination, material);
		}
	}
}