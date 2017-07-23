using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeaterScript : MonoBehaviour
{
    public float temperature;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        Object[] renderers = GameObject.FindObjectsOfType(typeof(MeshRenderer));

        for (int i = 0; i < renderers.Length; i++)
        {
            Material[] materials = ((MeshRenderer) renderers[i]).materials;

            for (int j = 0; j < materials.Length; j++)
            {
                if (materials[j].shader.name.Equals("Custom/HeatMapShader"))
                {
                    materials[j].SetFloat("_heatSourceTemperature", temperature);

                    Vector4 pos = new Vector4(gameObject.transform.position.x, gameObject.transform.position.y, gameObject.transform.position.z, 1);
                    materials[j].SetVector("_heatSourcePosition", pos);
                }
            }
        }
    }
}
