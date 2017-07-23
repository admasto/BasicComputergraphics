using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.ImageEffects;

public class CameraViewController : MonoBehaviour {
	public RenderTexture source;
	public RenderTexture destination;
	private MonoBehaviour grayScale;
	private MonoBehaviour heatMap;

	void Start (){
		grayScale = Camera.main.GetComponent<Grayscale> ();
		grayScale.enabled = false;

		heatMap = Camera.main.GetComponent<HeatMap> ();
		heatMap.enabled = false;
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyUp ("0")) {
			grayScale.enabled = false;
			heatMap.enabled = false;
		} 
		if (Input.GetKeyUp ("1")) {
			grayScale.enabled = true;
			heatMap.enabled = false;
		} 
		if (Input.GetKeyUp ("2")) {
			heatMap.enabled = true;
			grayScale.enabled = false;
		}
	}
}
