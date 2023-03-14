using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using TMPro;


public class SubjectUI : MonoBehaviour, IPointerClickHandler
{
    [SerializeField] private TMP_Text nameText;

    Action<int> onPick;
    public Subject currentSubject;


    public void Init(Subject sub, Action<int> pick)
    {
        currentSubject = sub;
        nameText.text = currentSubject.theme_name;
        onPick = pick;
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        onPick?.Invoke(currentSubject.subject_id);



    }



}
