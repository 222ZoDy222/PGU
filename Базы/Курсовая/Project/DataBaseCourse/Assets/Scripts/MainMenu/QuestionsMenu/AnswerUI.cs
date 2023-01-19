using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class AnswerUI : MonoBehaviour
{
    [SerializeField] private TMP_Text textToWrite;

    [SerializeField] private TMP_Text userName;

    [SerializeField] private VerticalLayoutGroup verticalLayout;

    private IEnumerator Start()
    {
        yield return null;
        verticalLayout.padding.top += 20;
        yield return null;
        verticalLayout.padding.top = 0;
    }

    public void Init(Answer answer)
    {
        WebManager.GetUsernameByUserID(answer.user_id, (msg) =>
        {
            Debug.Log(msg);
            userName.text = msg;
        });

        textToWrite.text = answer.answerText;
    }




}
