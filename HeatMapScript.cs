using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatMapScript : MonoBehaviour
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
            Material[] materials = ((MeshRenderer)renderers[i]).materials;

            for (int j = 0; j < materials.Length; j++)
            {
                if (materials[i].shader.name == "HeatMapShader")
                {
                }
            }
        }
    }
}
