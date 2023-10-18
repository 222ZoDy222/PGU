using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(CanvasScaler))]
public class AdaptiveCanvasScaler : MonoBehaviour
{
    private Canvas canvas;
    private CanvasScaler canvasScaler;

    [SerializeField] private bool isMainCanvas;

    private Vector2 referenceResolution;

    // Делегат на вызов изменения разрешения
    public delegate void OnResolutionChange();

    public static OnResolutionChange AdaptiveFirstScreen;
    public static OnResolutionChange AdaptiveSecondScreen;


    private void Awake()
    {
        canvas = GetComponent<Canvas>();
        canvasScaler = GetComponent<CanvasScaler>();

        referenceResolution = new Vector2(canvasScaler.referenceResolution.x, canvasScaler.referenceResolution.y);
        aspectDiv = referenceResolution.x / referenceResolution.y; // 1.777778
    }


    private float aspectDiv;
    private float thisAspectDiv = 0;

    private IEnumerator Start()
    {



        yield return null;
        StartCoroutine(CheckResolution());
    }

    IEnumerator CheckResolution()
    {

        while (true)
        {
            yield return new WaitForSeconds(1);

            // Берем разрешение монитора
            //float w = Screen.width;
            //float h = Screen.height;
            // При Запуске ПО всегда входит
            // Если разрешение вдруг поменялось, то canvas scaler подстраивается под него
            if (!((float)thisAspectDiv == (float)(canvas.renderingDisplaySize.x / canvas.renderingDisplaySize.y)))
            {
                thisAspectDiv = canvas.renderingDisplaySize.x / canvas.renderingDisplaySize.y;
                AdaptiveScreen();
                yield return null;
                AdaptiveSync();
            }

        }
    }





    public Vector2 GetResolution
    {
        get
        {
            return new Vector2(canvas.renderingDisplaySize.x, canvas.renderingDisplaySize.y);
        }
    }

    private void AdaptiveScreen()
    {
        // Если соотношение сторон квадратнее, чем 16:9
        if (thisAspectDiv < aspectDiv)
        {
            canvasScaler.matchWidthOrHeight = 0;
        }
        else // Если соотношение сторон длинее, чем 16:9
        {
            canvasScaler.matchWidthOrHeight = 1;
        }



    }

    private void AdaptiveSync()
    {
        if (isMainCanvas)
        {
            AdaptiveFirstScreen?.Invoke();
        }
        else
        {
            AdaptiveSecondScreen?.Invoke();
        }
    }
}
