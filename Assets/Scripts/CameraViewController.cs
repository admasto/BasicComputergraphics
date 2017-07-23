using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.ImageEffects;


public class CameraViewController : MonoBehaviour {
	//Materialvariablen für die Heatmap
	public Material HeatMapGround;
	public Material HeatMapCeiling;
	public Material HeatMapWalls;
	public Material HeatMapTeapots;

	//Variable für das Script der Grauwertverteilung
	private MonoBehaviour grayScale;

	//Objektvariablen um die Materialen in der Heatmap anzupassen
	public GameObject exampleTextureShader_Ceiling;
	public GameObject Walls;
	public GameObject Teapots;
	public GameObject Ground;

	//Variablen einzelner Teapots zum Rücktausch von speziellen Materialien
	public GameObject metallicTeapot;
	public GameObject lambertTeapot;
	public GameObject phongTeapot;
	public GameObject brightTeapot;
	public GameObject structuredTeapot;
	public GameObject vertexTeapot;
	public GameObject normalTeapot;
	public GameObject simpleTeapot;
	public GameObject defaultTeapot;

	//Variavlen zum Zwischenspeichern der OriginalMaterialien
	public Material defaultMaterial;
	public Material ceiling;
	public Material ground;

	public Material metallicTeapotMat;
	public Material lambertTeapotMat;
	public Material phongTeapotMat;
	public Material brightTeapotMat;
	public Material structuredTeapotMat;
	public Material vertexTeapotMat;
	public Material normalTeapotMat;
	public Material simpleTeapotMat;

	//Flag zur Heatmap Aktivierung
	private bool heatmapFlag;
	public void setHeatmapFlag(bool flag){
		heatmapFlag = flag;
	}
	public bool getHeatmapFlag(){
		return heatmapFlag;
	}

	void Start (){
		//Grauwertverteilung als einfach Image Effect (im Packet Effect enthalten)
		grayScale = Camera.main.GetComponent<Grayscale> ();
		grayScale.enabled = false;
		setHeatmapFlag (false);
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyUp ("0")) {
			if (!grayScale.enabled) { //Ansicht Heatmap --> Original
				//Materialien zurücktauschen.
				changeMaterialsBack();
			}
			//Grauwertverteilung deaktivieren
			grayScale.enabled = false;
		} 
		if (Input.GetKeyUp ("1")) { //Wechsel zur Grauwertansicht
			if (getHeatmapFlag ()) { //Wechsel aus Heatmap
				changeMaterialsBack ();
			}
			grayScale.enabled = true;
			//heatMap.enabled = false;
		} 
		if (Input.GetKeyUp ("2")) { //Wechsel zur Heatmap
			//Gruawertansicht spielt keine Rolle
			setHeatmapFlag (true);
			grayScale.enabled = false;
			Ground.GetComponent<Renderer>().material = HeatMapGround;
			exampleTextureShader_Ceiling.GetComponent<Renderer>().material = HeatMapCeiling;

			Renderer [] wallRenderers = Walls.GetComponentsInChildren<Renderer> ();
			for (int i = 0; i < wallRenderers.Length; i++) {
				wallRenderers [i].material = HeatMapWalls;
			}

			Renderer[] teapotRenderers = Teapots.GetComponentsInChildren<Renderer> ();
			for (int i = 0; i<teapotRenderers.Length; i++){
				teapotRenderers[i].material = HeatMapTeapots;
			}
		}	
	}

	private void changeMaterialsBack(){
		Ground.GetComponent<Renderer>().material = ground;
		exampleTextureShader_Ceiling.GetComponent<Renderer>().material = ceiling;
		defaultTeapot.GetComponent<Renderer>().material = defaultMaterial;
		lambertTeapot.GetComponent<Renderer>().material = lambertTeapotMat;
		phongTeapot.GetComponent<Renderer>().material = phongTeapotMat;
		metallicTeapot.GetComponent<Renderer> ().material = metallicTeapotMat;
		brightTeapot.GetComponent<Renderer> ().material = brightTeapotMat;
		structuredTeapot.GetComponent<Renderer> ().material = structuredTeapotMat;
		normalTeapot.GetComponent<Renderer> ().material = normalTeapotMat;
		vertexTeapot.GetComponent<Renderer> ().material = vertexTeapotMat;
		simpleTeapot.GetComponent<Renderer> ().material = simpleTeapotMat;

		Renderer [] wallRenderers = Walls.GetComponentsInChildren<Renderer> ();
		for (int i = 0; i < wallRenderers.Length; i++) {
			wallRenderers [i].material = defaultMaterial;
		}
	}
}