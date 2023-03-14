using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class UserAnswerUI : MonoBehaviour
{

    [SerializeField] private TMP_InputField textField;

    [SerializeField] private TMP_Text textToWrite;

    [SerializeField] private TMP_Text userName;

    [SerializeField] private Button save, delete;

    private int question_id = -1;

    private void Awake()
    {
        textField.onValueChanged.AddListener(onFieldChange);
        save.onClick.AddListener(SaveAnswer);
        delete.onClick.AddListener(DeleteAnswer);

    }

    private void onFieldChange(string text)
    {
        textToWrite.text = textField.text;
    }

    public void Init(Answer answer, int question_id)
    {
        this.question_id = question_id;
        userName.text = UserInfo.user.username;
        textField.text = answer.answerText;
    }

    public void Init(int question_id)
    {
        this.question_id = question_id;
        userName.text = UserInfo.user.username;
    }

    private void DeleteAnswer()
    {
        WebManager.DeleteAnswer(question_id, UserInfo.user.userID, (msg) =>
        {
            if (msg == "1")
            {
                QuestionsMenu.instance.UpdateQuestions();
            }

        });
    }

    private void SaveAnswer()
    {
        if (textField.text == "") return;

        WebManager.CreateAnswer(textField.text, question_id, UserInfo.user.userID, (msg) =>
          {
              if(msg == "1")
              {
                  QuestionsMenu.instance.UpdateQuestions();
              }

          });

    }

}
