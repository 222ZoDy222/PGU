using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class FileWindow : MonoBehaviour
{

    [SerializeField] private GameObject scrollGO, inputFieldGO, saveButtonGO;

    [SerializeField] private TMP_InputField inputField;
    [SerializeField] private Button saveButton, deleteButton;
    [SerializeField] private TMP_Text textFile;

    [SerializeField] private CanvasGroup thisCanvas;

    [SerializeField] private TaskMenuUI TaskMenuUI;

    private File currentFile;

    private void Start()
    {
        saveButton.onClick.AddListener(SaveFile);
        deleteButton.onClick.AddListener(DeleteFile);


    }

    public void Show(File file)
    {

        currentFile = file;
        thisCanvas.AlphaAndRaycastToggle(true);


        if (file.users_idusers == UserInfo.user.userID)
        {
            scrollGO.SetActive(false);
            inputFieldGO.SetActive(true);
            saveButtonGO.SetActive(true);

            inputField.text = file.file;

        } else
        {
            scrollGO.SetActive(true);
            inputFieldGO.SetActive(false);
            saveButtonGO.SetActive(false);

            textFile.text = file.file;
        }
    }

    public void Hide()
    {
        thisCanvas.AlphaAndRaycastToggle(false);
    }



    private void SaveFile()
    {
        if (currentFile == null) return;
        WebManager.SaveFile(currentFile.id_file, inputField.text, currentFile.comment, (msg) =>
          {
              TaskMenuUI.UpdateFiles();
              

          });
    }


    private void DeleteFile()
    {
        if (currentFile == null) return;
        WebManager.DeleteFile(currentFile.id_file, (msg) =>
        {
            if(msg == "1")
            {
                TaskMenuUI.UpdateFiles();
                Hide();
            }
            


        });
    }


}
