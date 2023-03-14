using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class QuestionsMenu : MonoBehaviour
{

    public static QuestionsMenu instance;

    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;
    }

    [SerializeField] private RectTransform container;

    [SerializeField] private QuestionUI questionUIPRefab;

    [SerializeField] private CanvasGroup thisCanvas;

    [SerializeField] private Button hideButton;

    private Task currentTask;

    [SerializeField] private GameObject objectToHideAndShow;

    private void Start()
    {
        hideButton.onClick.AddListener(Hide);
        Hide();
    }

    public void ShowAndHide()
    {
        IEnumerator coroutine()
        {
            yield return null;
            
            yield return null;
            objectToHideAndShow.SetActive(false);
            yield return null;
           
            yield return null;
            objectToHideAndShow.SetActive(true);
            yield return null;
            
            yield return null;
            objectToHideAndShow.SetActive(false);
            yield return null;
           
            yield return null;
            objectToHideAndShow.SetActive(false);
            yield return null;
            
            yield return null;
            objectToHideAndShow.SetActive(true);
            objectToHideAndShow.SetActive(true);
        }
        StartCoroutine(coroutine());
    }
    
    public void Show(Task task)
    {
        thisCanvas.AlphaAndRaycastToggle(true);
        currentTask = task;

        UpdateQuestions();
    }

    public void Hide()
    {
        thisCanvas.AlphaAndRaycastToggle(false);
    }


    public void UpdateQuestions()
    {
        container.DestroyAllChildren();

        WebManager.GetQuestionsByTaskID(currentTask.task_id, (msg) =>
        {
            Debug.Log(msg);
            if (msg != null)
            {
                Question[] questions = JsonHelper.FromJson<Question>(msg);
                if (questions != null && questions.Length != 0)
                {
                    SpawnQuestions(questions);
                }
            }


        });
    }


    private void SpawnQuestions(Question[] questions)
    {

        for (int i = 0; i < questions.Length; i++)
        {

            Instantiate(questionUIPRefab, container).Init(questions[i]);

        }

    }


    [SerializeField] private CanvasGroup createQuestionCanvas;
    [SerializeField] private TMPro.TMP_InputField questionField;

    public void ShowCreateQuestionUI()
    {
        createQuestionCanvas.AlphaAndRaycastToggle(true);
    }

    public void HideCreateQuestionUI()
    {
        createQuestionCanvas.AlphaAndRaycastToggle(false);
    }


    public void CreateQuestion()
    {
        if (questionField.text == "") return;



        WebManager.CreateQuestion(questionField.text, currentTask.task_id, UserInfo.user.userID, (msg) =>
           {
               if(msg == "1")
               {
                   HideCreateQuestionUI();
                   UpdateQuestions();
               }

           });

    }







}
