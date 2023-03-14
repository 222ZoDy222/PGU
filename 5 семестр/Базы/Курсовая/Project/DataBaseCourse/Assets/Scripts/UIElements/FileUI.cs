using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using TMPro;

public class FileUI : MonoBehaviour, IPointerClickHandler
{
    [SerializeField] private TMP_Text idText;
    [SerializeField] private TMP_Text dateText;

    Action<File> onPick;
    public File currentFile;

    [SerializeField] private Color userColor;
    [SerializeField] private Image background;

    public void Init(File file, Action<File> pick)
    {
        currentFile = file;
        idText.text = currentFile.id_file.ToString();
        dateText.text = currentFile.date;
        onPick = pick;
        if(file.users_idusers == UserInfo.user.userID)
        {
            background.color = userColor;
        }
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        onPick?.Invoke(currentFile);



    }
}
