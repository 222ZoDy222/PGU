using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class SubjectsMenuUI : MonoBehaviour
{
    [Header("Spawn containers")]
    [SerializeField] private RectTransform subjectsContainer, tasksContainer;

    [Header("create Buttons")]
    [SerializeField] private Button createSubjectButton, createTaskButton;

    [Header("containersToShow")]
    [SerializeField] private GameObject subjectsGO, tasksGO;

    [Header("Prefabs")]
    [SerializeField] private SubjectUI subjectPrefab;
    [SerializeField] private TaskUI taskPRefab;

    public Action<int> onSubjectPickAction;

    public Action<Task> onTaskPickAction;

    private List<Task> tasks = new List<Task>();

    private int selectedSubject = -1;
    private List<Subject> subjects = new List<Subject>();
   

    private void Start()
    {
        onSubjectPickAction = OnSubjectPick;
        onTaskPickAction = OnTaskPick;
    }


    private void OnSubjectPick(int idSubject)
    {
        selectedSubject = idSubject;
        ShowTasksContainer();
        GetTasksForSubject(idSubject);
    }

    public void Show()
    {
        ClearAllContainers();
        GetAllSubjects();
        HideAll();
        ShowSubjectsContainer();
    }

    private void HideAll()
    {
        subjectsGO.SetActive(false);
        tasksGO.SetActive(false);
    }

    private void ShowSubjectsContainer()
    {
        subjectsGO.SetActive(true);
    }

    private void ShowTasksContainer()
    {
        tasksGO.SetActive(true);
        ClearTaskContainer();
    }

    private void GetAllSubjects()
    {
        WebManager.GetAllSubjects((msg) =>
        {
            Debug.Log(msg);
            Subject[] Allsubjects = JsonHelper.FromJson<Subject>(msg);
            SpawnSubjects(Allsubjects);

        });
    }

    private void GetTasksForSubject(int subject_id)
    {
        ClearTasks();
        WebManager.GetTasksBySubject(subject_id, (msg) =>
         {
             Debug.Log(msg);
             if(msg != null)
             {
                 Task[] AllTasks = JsonHelper.FromJson<Task>(msg);
                 if (AllTasks != null && AllTasks.Length != 0)
                 {
                     SpawnTasks(AllTasks);
                 }
             }
             
         });
    }


    private void ClearTasks()
    {
        tasks.Clear();
        tasksContainer.DestroyAllChildren();
    }

    private void SpawnSubjects(Subject[] subjects)
    {
        this.subjects.Clear();
        for (int i = 0; i < subjects.Length; i++)
        {
            SpawnSubject(subjects[i]);
        }

    }
    
    private void SpawnSubject(Subject sub)
    {
        Instantiate(subjectPrefab, subjectsContainer).Init(sub, onSubjectPickAction);
        subjects.Add(sub);
    }

    private void SpawnTasks(Task[] tasks)
    {
        for (int i = 0; i < tasks.Length; i++)
        {
            SpawnTask(tasks[i]);
            this.tasks.Add(tasks[i]);
        }
    }

    private void SpawnTask(Task task)
    {
        Instantiate(taskPRefab, tasksContainer).Init(task, onTaskPickAction);
    }

    private void ClearAllContainers()
    {
        subjectsContainer.DestroyAllChildren();
        if(tasksContainer) tasksContainer.DestroyAllChildren();
    }

    private void ClearTaskContainer()
    {
        tasksContainer.DestroyAllChildren();
        tasks.Clear();
    }

    private void OnTaskPick(Task task)
    {
        for (int i = 0; i < tasks.Count; i++)
        {
            if (tasks[i] == task)
            {
                TaskMenuUI.Show(tasks[i]);
            }
        }
    }




    [Header("Adders")]
    [SerializeField] private GameObject taskAdderContainer;
    [SerializeField] private GameObject subjectAdderContainer;

    [SerializeField] private TMP_InputField subjectNameField, taskNameField;

    [SerializeField] private GameObject errorNameSubjectContainer;

    public void ShowCreateSubjectContainer()
    {
        errorNameSubjectContainer.SetActive(false);
        subjectAdderContainer.SetActive(true);
    }
    public void CloseCreateSubjectContainer()
    {
        subjectAdderContainer.SetActive(false);
    }

    public void CreateNewSubject()
    {
        if (subjectNameField.text == "") return;

        WebManager.CreateNewSubject(subjectNameField.text, (msg) =>
        {
            Debug.Log(msg);
            if(msg == "-1")
            {
                errorNameSubjectContainer.SetActive(true);
            } else if(msg == "1")
            {
                CloseCreateSubjectContainer();
                ClearAllContainers();
                GetAllSubjects();
                
            }
        });

    }

    public void ShowCreateTaskContainer()
    {
        
        taskAdderContainer.SetActive(true);
    }
    public void CloseCreateTaskContainer()
    {
        taskAdderContainer.SetActive(false);
    }

    public void CreateNewTask()
    {
        if (taskNameField.text == "") return;

        WebManager.CreateNewTask(taskNameField.text, selectedSubject, (msg) =>
        {
            Debug.Log(msg);
            if (msg == "-1")
            {
                errorNameSubjectContainer.SetActive(true);
            }
            else if (msg == "1")
            {
                CloseCreateTaskContainer();
                ClearTaskContainer();
                GetTasksForSubject(selectedSubject);
                
            }
        });

    }



}
