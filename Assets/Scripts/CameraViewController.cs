using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.ImageEffects;


public class CameraViewController : MonoBehaviour {
	public RenderTexture source;
	public RenderTexture destination;

	public Material HeatMapGround;
	public Material HeatMapCeiling;
	public Material HeatMapWalls;
	public Material HeatMapHeater;
	public Material HeatMapTeapots;

	private MonoBehaviour grayScale;

	public GameObject exampleTextureShader_Ceiling;
	public GameObject Walls;
	public GameObject Teapots;
	public GameObject Heater;
	public GameObject Ground;


	void Start (){
		grayScale = Camera.main.GetComponent<Grayscale> ();
		grayScale.enabled = false;


		//heatMap = Camera.main.GetComponent<HeatMap> ();
		//heatMap.enabled = false;
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyUp ("0")) {
			grayScale.enabled = false;
			//heatMap.enabled = false;
		} 
		if (Input.GetKeyUp ("1")) {
			grayScale.enabled = true;
			//heatMap.enabled = false;
		} 
		if (Input.GetKeyUp ("2")) {
			grayScale.enabled = false;
			Ground.GetComponent<Renderer>().material = HeatMapGround;
			exampleTextureShader_Ceiling.GetComponent<Renderer>().material = HeatMapCeiling;
			Walls.GetComponent<Renderer>().material = HeatMapWalls;
			Heater.GetComponent<Renderer> ().material = HeatMapHeater;
			Teapots.GetComponent<Renderer>().material = HeatMapTeapots;
		}	
	}
}
