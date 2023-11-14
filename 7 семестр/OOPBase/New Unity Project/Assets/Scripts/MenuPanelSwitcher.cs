using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class MenuPanelSwitcher : MonoBehaviour
{

    [Header("All menues")]
    [SerializeField] private CanvasGroup mainMenuCanvas;
    [SerializeField] private CanvasGroup editDeskCanvas, editCardCanvas, trainingCanvas, duringTraining;


    public Menu currentMenu { get; private set; }

    private void Start()
    {
        ShowEditDesk();
    }

    public void HideAllContainers()
    {
        duringTraining.ShowMenu(false);
        mainMenuCanvas.ShowMenu(false);
        editDeskCanvas.ShowMenu(false);
        editCardCanvas.ShowMenu(false);
        trainingCanvas.ShowMenu(false);
    }


    public void ShowMainMenu()
    {
        HideAllContainers();
        mainMenuCanvas.ShowMenu(true);
    }


    public void ShowEditDesk()
    {
        HideAllContainers();
        editDeskCanvas.ShowMenu(true);
    }

    public void ShowEditCard()
    {
        HideAllContainers();
        editCardCanvas.ShowMenu(true);
    }

    public void ShowTraining()
    {
        HideAllContainers();
        trainingCanvas.ShowMenu(true);
    }

    public void ShowDuringTraining()
    {
        HideAllContainers();
        duringTraining.ShowMenu(true);
    }



    #region Shit

    [SerializeField] private RectTransform createImage, hidePos, showPos;

    public void ShowDeskCreate()
    {
        createImage.DOLocalMove(hidePos.localPosition, 0f);
        createImage.DOLocalMove(showPos.localPosition, 0.5f);
    }

    public void HideDeskCreate()
    {
        createImage.DOLocalMove(hidePos.localPosition, 0.5f);
    }


    [SerializeField] private RectTransform createImage_card, hidePos_card, showPos_card;

    public void ShowCardCreate()
    {
        createImage_card.DOLocalMove(hidePos.localPosition, 0f);
        createImage_card.DOLocalMove(showPos_card.localPosition, 0.5f);
    }

    public void HideCardCreate()
    {
        createImage_card.DOLocalMove(hidePos_card.localPosition, 0.5f);
    }


   
    #endregion



    public enum Menu
    {

        mainMenu,
        editDesk,
        editCard,
        training,


    }


}



public static class CanvasExtension 
{

    public static void ShowMenu(this CanvasGroup canvas, bool value)
    {

        if (value) canvas.alpha = 1;
        else canvas.alpha = 0;

        canvas.blocksRaycasts = value;
        canvas.interactable = value;


    }



}


