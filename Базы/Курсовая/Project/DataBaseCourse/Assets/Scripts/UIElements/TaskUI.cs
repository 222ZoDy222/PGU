using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using TMPro;

public class TaskUI : MonoBehaviour, IPointerClickHandler
{
    [SerializeField] private TMP_Text nameText;
    [SerializeField] private TMP_Text dateText;

    Action<Task> onPick;
    public Task currentTask;


    public void Init(Task task, Action<Task> pick)
    {
        currentTask = task;
        nameText.text = currentTask.task_name;
        dateText.text = currentTask.task_date;
        onPick = pick;
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        onPick?.Invoke(currentTask);



    }

}
