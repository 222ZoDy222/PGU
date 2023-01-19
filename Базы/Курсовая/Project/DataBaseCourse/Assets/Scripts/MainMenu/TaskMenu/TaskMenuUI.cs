using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class TaskMenuUI : MonoBehaviour
{

    public static TaskMenuUI instance;

    [SerializeField] private CanvasGroup canvasGroup;

    [Header("Text elements")]
    [SerializeField] private TMP_Text taskName;

    Task currentTask;

    [SerializeField] private FileWindow fileWindow;

    private List<File> files = new List<File>();

    [SerializeField] private RectTransform filesContainer;

    [SerializeField] private FileUI filePrefab;

    [SerializeField] private Button createFileButton;

    [SerializeField] private TMP_Text haveNoTasksText;
    
    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;



        createFileButton.onClick.AddListener(CreateNewFile);

    }


    public static void Show(Task task)
    {
        
        instance.fileWindow.Hide();
        instance.canvasGroup.AlphaAndRaycastToggle(true);
        instance.FillTaskUI(task);
        instance.UpdateFiles();
    }

    private void FillTaskUI(Task task)
    {
        currentTask = task;
        taskName.text = task.task_name;
    }

    public void UpdateFiles()
    {
        haveNoTasksText.gameObject.SetActive(false);
        ClearFiles();
        WebManager.GetFilesByTaskID(currentTask.task_id, (msg) =>
        {
            Debug.Log(msg);
            if (msg != null)
            {
                File[] files = JsonHelper.FromJson<File>(msg);
                if (files != null && files.Length != 0)
                {
                    SpawnFiles(files);
                }
            } else
            {
                fileWindow.Hide();
                haveNoTasksText.gameObject.SetActive(true);
            }
        });
    }

    public static void Hide()
    {
        instance.canvasGroup.AlphaAndRaycastToggle(false);
    }

    private void ClearFiles()
    {
        filesContainer.DestroyAllChildren();
        files.Clear();
    }

    private void SpawnFiles(File[] files)
    {
        ClearFiles();
        for (int i = 0; i < files.Length; i++)
        {
            SpawnFile(files[i]);
            this.files.Add(files[i]);
        }
    }

    private void SpawnFile(File file)
    {
        Instantiate(filePrefab, filesContainer).Init(file, OnFilePick);
    }

    private void OnFilePick(File file)
    {
        fileWindow.Show(file);
    }


    private void CreateNewFile()
    {
        WebManager.CreateNewFile(currentTask.task_id, UserInfo.user.userID, (msg) =>
          {

              Debug.Log(msg);
              if (msg != null)
              {
                  File[] files = JsonHelper.FromJson<File>(msg);
                  if (files != null && files.Length != 0)
                  {
                      SpawnFile(files[0]);
                      OnFilePick(files[0]);
                  }
              }

          });
    }

    [ContextMenu("Show questions")]
    public void ShowQuestions()
    {
        if (currentTask == null) return;
        QuestionsMenu.instance.Show(currentTask);
    }



}
