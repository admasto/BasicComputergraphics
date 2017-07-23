using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraViewController : MonoBehaviour {

	GreyValueCam greyValues = gameObject.GetComponent<GreyValueCam>();
	HeatmapCam heatmap = gameObject.GetComponent<HeatMapCam>();
	TemperaturemapCam temperaturemap = gameObject.GetComponent<TemperaturemapCam>();

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyUp ("0")) {

		} 
		if (Input.GetKeyUp ("1")) {
			greyValues.OnRenderImage ();
		} 
		if (Input.GetKeyUp ("2")) {
			heatmap.OnRenderImage ();
		}
		if (Input.GetKeyUp ("3")) {
			temperaturemap.OnRenderImage ();
		}
	}
}
