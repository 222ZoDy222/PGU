using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class MenuSwitcher : MonoBehaviour
{

	public static MenuSwitcher instance;


	[SerializeField] private CanvasGroup 
		registrationMenuCanvas,
		profileMenuCanvas,
		subjectsMenuCanvas,
		mineLabsCanvas,
		tasksMenuCanvas;

	[SerializeField] private RegisterMenuUI registerMenuUI;
	[SerializeField] private SubjectsMenuUI subjectsMenuUI;
	[SerializeField] private MineLabsMenuUI mineLabsMenuUI;

	private void Awake()
    {
		if (instance != null) Destroy(instance);
		instance = this;
    }

    private void Start()
    {
		ShowRegistrationMenu();

	}

	private void HideAll() 
	{
		registrationMenuCanvas.AlphaAndRaycastToggle(false);
		profileMenuCanvas.AlphaAndRaycastToggle(false);
		subjectsMenuCanvas.AlphaAndRaycastToggle(false);
		mineLabsCanvas.AlphaAndRaycastToggle(false);
		tasksMenuCanvas.AlphaAndRaycastToggle(false);
	}

	public void ShowRegistrationMenu()
    {
		HideAll();
		registrationMenuCanvas.AlphaAndRaycastToggle(true);
		registerMenuUI.ShowMenu();
    }

	public void ShowProfileMenu()
    {
		HideAll();
		profileMenuCanvas.AlphaAndRaycastToggle(true);
    }

	public void ShowSubjectsMenu()
    {
		HideAll();
		subjectsMenuCanvas.AlphaAndRaycastToggle(true);
		subjectsMenuUI.Show();

	}

	public void ShowMineLabs()
    {
		HideAll();
		mineLabsCanvas.AlphaAndRaycastToggle(true);
		mineLabsMenuUI.SpawnMineLabs();

	}

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
