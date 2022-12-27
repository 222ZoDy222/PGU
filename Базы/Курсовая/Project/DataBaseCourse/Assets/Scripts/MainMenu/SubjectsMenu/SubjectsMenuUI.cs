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

    public Action<int> onTaskPickAction;

    private void Start()
    {
        onSubjectPickAction = OnSubjectPick;
    }


    private void OnSubjectPick(int idSubject)
    {
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
        WebManager.GetTasks(subject_id, (msg) =>
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

    private void SpawnSubjects(Subject[] subjects)
    {

        for (int i = 0; i < subjects.Length; i++)
        {
            SpawnSubject(subjects[i]);
        }

    }
    
    private void SpawnSubject(Subject sub)
    {
        Instantiate(subjectPrefab, subjectsContainer).Init(sub, onSubjectPickAction);
    }

    private void SpawnTasks(Task[] tasks)
    {
        for (int i = 0; i < tasks.Length; i++)
        {
            SpawnTask(tasks[i]);
        }
    }

    private void SpawnTask(Task task)
    {
        Instantiate(taskPRefab, tasksContainer).Init(task, onTaskPickAction);
    }

    private void ClearAllContainers()
    {
        subjectsContainer.DestroyAllChildren();
        tasksContainer.DestroyAllChildren();
    }

    private void ClearTaskContainer()
    {
        tasksContainer.DestroyAllChildren();
    }


}
