using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class QuestionUI : MonoBehaviour
{




    [SerializeField] private TMP_Text textToWrite;

    [SerializeField] private TMP_Text userName;

    [SerializeField] private RectTransform container;

    [SerializeField] private UserAnswerUI userAnswerUIPrefab;
    [SerializeField] private AnswerUI answerUIPrefab;

    [SerializeField] private Button showAnswers;
    [SerializeField] private Button createAnswer;

    public Question currentQuestion;

    [SerializeField] private TMP_Text alreadyAnswered;


    private void Awake()
    {
        createAnswer.onClick.AddListener(CreateAnswer);
        createAnswer.gameObject.SetActive(false);
        showAnswers.onClick.AddListener(UpdateAnswers);
    }

    public void Init(Question question)
    {
        currentQuestion = question;
        WebManager.GetUsernameByUserID(question.user_id, (msg) =>
        {
            Debug.Log(msg);
            userName.text = msg;
        });

        textToWrite.text = question.question_text;

    }


    public void UpdateAnswers()
    {
        container.DestroyAllChildren();

        WebManager.GetAnswersByQuestionID(currentQuestion.question_id, (msg) =>
         {
             Debug.Log(msg);
             if (msg != null)
             {
                 Answer[] answers = JsonHelper.FromJson<Answer>(msg);
                 if (answers != null && answers.Length != 0)
                 {
                     SpawnAnswers(answers);
                     
                 }
             } else
             {
                 haveUserAnswer = false;
             }



         });


    }

    private bool _haveUserAnswer = false;
    private bool haveUserAnswer
    {
        get => _haveUserAnswer;

        set
        {
            _haveUserAnswer = value;
            createAnswer.gameObject.SetActive(!_haveUserAnswer);

        }
    }

    private void SpawnAnswers(Answer[] answers)
    {
        haveUserAnswer = false;

        for (int i = 0; i < answers.Length; i++)
        {
            SpawnAnswer(answers[i]);
        }

        QuestionsMenu.instance.ShowAndHide();
    }

    private void SpawnAnswer(Answer answ)
    {
        
        if(answ.user_id == UserInfo.user.userID)
        {
            UserAnswerUI answerUI = Instantiate(userAnswerUIPrefab, container);
            answerUI.Init(answ,currentQuestion.question_id);
            answerUI.gameObject.SetActive(false);
            answerUI.gameObject.SetActive(true);
            haveUserAnswer = true;
        } 
        else
        {
            AnswerUI answerUI = Instantiate(answerUIPrefab, container);
            
            answerUI.Init(answ);
            answerUI.gameObject.SetActive(false);
            answerUI.gameObject.SetActive(true);
        }
        
    }

    private void CreateAnswer()
    {
        UserAnswerUI answerUI = Instantiate(userAnswerUIPrefab, container);
        answerUI.Init(currentQuestion.question_id);

        QuestionsMenu.instance.ShowAndHide();
    }


















}
