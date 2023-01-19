using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MineLabsMenuUI : MonoBehaviour
{
    [Header("Spawn containers")]
    [SerializeField] private RectTransform tasksContainer;

    [SerializeField] private TaskUI taskPrefab;

    [SerializeField] private TMP_Text haveNoTasksText;
    private List<Task> tasks = new List<Task>();

    public void SpawnMineLabs()
    {
        ClearTasks();
        WebManager.GetTasksByUserID(UserInfo.user.userID, (msg) =>
         {
             Debug.Log(msg);
             Task[] AllTasks = JsonHelper.FromJson<Task>(msg);
             SpawnTasks(AllTasks);

         });
    }


    private void ClearTasks()
    {
        tasksContainer.DestroyAllChildren();
        tasks.Clear();
        haveNoTasksText.gameObject.SetActive(false);
    }

    private void SpawnTasks(Task[] tasks)
    {
        if(tasks == null)
        {
            haveNoTasksText.gameObject.SetActive(true);
            return;
        }
        
        for (int i = 0; i < tasks.Length; i++)
        {
            TaskUI newTask = Instantiate(taskPrefab, tasksContainer);

            newTask.Init(tasks[i], OnTaskPick);
            this.tasks.Add(tasks[i]);

        }
    }


    private void OnTaskPick(Task task)
    {
        for (int i = 0; i < tasks.Count; i++)
        {
            if(tasks[i] == task)
            {
                TaskMenuUI.Show(tasks[i]);
            }
        }
    }


}
