using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuSwitcher : MonoBehaviour
{
    



}


public static class CanvasGroupExtension
{
	public static void AlphaAndRaycastToggle(this CanvasGroup canvasGroup, bool isActive)
	{
		canvasGroup.blocksRaycasts = isActive;
		canvasGroup.interactable = isActive;
		canvasGroup.alpha = isActive ? 1 : 0;
	}

	public static void DestroyAllChildren(this Transform transform)
	{
		foreach (Transform child in transform) UnityEngine.Object.Destroy(child.gameObject);
	}
}
