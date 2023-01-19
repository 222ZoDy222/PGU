using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WebManager : MonoBehaviour
{
    public static WebManager instance;

    [SerializeField] private WebSender webSender;

    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;
    }


    #region registration
    //////////////////////////////////////
    /////   R E G I S T R A T I O N  ///// 
    //////////////////////////////////////

    private const string REGISTRATION_ACT = "1";

    private const string REGISTRATION_URL = "http://localhost/Registration/Registration.php";

    public static void Registration(string name, string pass, Action<string> callback)
    {
        string post = $"act={REGISTRATION_ACT}&username={name}&password={pass}";

        instance.webSender.PostQueryOnServer(post, REGISTRATION_URL, callback);


    }

    ////////////////////////////////////////
    /////    AUTHENTICATION             ////
    ////////////////////////////////////////

    private const string AUTHENTICATION_ACT = "2";

    private const string AUTHENTICATION_URL = "http://localhost/Registration/Registration.php";

    public static void Authentication(string name, string pass, Action<string> callback)
    {
        string post = $"act={AUTHENTICATION_ACT}&username={name}&password={pass}";

        instance.webSender.PostQueryOnServer(post, AUTHENTICATION_URL, callback);


    }

    #endregion



    #region subjects
    ////////////////////////////////////////
    /////      S U B J E C T S          ////
    ////////////////////////////////////////

    private const string SUBJECTS_URL = "http://localhost/Labs/Subjects.php";

    private const string GET_SUBJECTS_ACT = "11";

    public static void GetAllSubjects(Action<string> callback)
    {
        string post = $"act={GET_SUBJECTS_ACT}";
        instance.webSender.PostQueryOnServer(post, SUBJECTS_URL, callback);
    }


    private const string CREATE_SUBJECTS_ACT = "12";
    public static void CreateNewSubject(string subject_name, Action<string> callback)
    {
        //$subject_name={subject_name}
        string post = $"act={CREATE_SUBJECTS_ACT}&subject_name={subject_name}";
        instance.webSender.PostQueryOnServer(post, SUBJECTS_URL, callback);

    }


    #endregion



    #region Tasks
    ////////////////////////////////////////
    /////      T A S K S                //// 
    ////////////////////////////////////////

    private const string TASK_URL = "http://localhost/Labs/Tasks.php";

    private const string GET_TASKS_ACT = "21";

    public static void GetTasksBySubject(int subject_id, Action<string> callback)
    {
        string post = $"act={GET_TASKS_ACT}&subject_id={subject_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }


    private const string GET_TASKS_USER_ID_ACT = "23";
    public static void GetTasksByUserID(int user_id, Action<string> callback)
    {
        
        string post = $"act={GET_TASKS_USER_ID_ACT}&user_id={user_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }

    private const string CREATE_TASK_ACT = "22";
    public static void CreateNewTask(string task_name, int subject_id, Action<string> callback)
    {
        //$subject_name={subject_name}
        string post = $"act={CREATE_TASK_ACT}&task_name={task_name}&subject_id={subject_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);

    }

    #endregion



    #region Files

    private const string GET_FILES_BY_TASK_ACT = "24";

    public static void GetFilesByTaskID(int task_id, Action<string> callback)
    {
        string post = $"act={GET_FILES_BY_TASK_ACT}&task_id={task_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }

    private const string CREATE_FILE_ACT = "25";

    public static void CreateNewFile(int task_id, int user_id, Action<string> callback)
    {
        string post = $"act={CREATE_FILE_ACT}&task_id={task_id}&user_id={user_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }

    private const string SAVE_FILE_ACT = "26";
    public static void SaveFile(int file_id, string file_text, string comment ,Action<string> callback)
    {
        string post = $"act={SAVE_FILE_ACT}&file_id={file_id}&file={file_text}&comment={comment}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }

    private const string DELETE_FILE_ACT = "27";
    public static void DeleteFile(int file_id, Action<string> callback)
    {
        string post = $"act={DELETE_FILE_ACT}&file_id={file_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }



    #endregion




    #region Answers & Questions

    private const string QUESTIONS_URL = "http://localhost/Labs/Questions.php";
    private const string QUESTIONS_BY_TASK_ACT = "40";
    public static void GetQuestionsByTaskID(int task_id, Action<string> callback)
    {
        string post = $"act={QUESTIONS_BY_TASK_ACT}&task_id={task_id}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }


    private const string ANSWERS_BY_QUESTION_ACT= "41";
    public static void GetAnswersByQuestionID(int question_id, Action<string> callback)
    {
        string post = $"act={ANSWERS_BY_QUESTION_ACT}&question_id={question_id}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }


    private const string CREATE_QUESTION_ACT = "43";
    public static void CreateQuestion(string questionText, int Task_idTask , int users_idusers1, Action<string> callback)
    {
        string post = $"act={CREATE_QUESTION_ACT}&questionText={questionText}&Task_idTask={Task_idTask}&users_idusers1={users_idusers1}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }

    private const string CREATE_ANSWER_ACT = "44";
    public static void CreateAnswer(string answerText, int question_id, int user_id, Action<string> callback)
    {
        string post = $"act={CREATE_ANSWER_ACT}&answerText={answerText}&question_id={question_id}&user_id={user_id}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }

    private const string DELETE_ANSWER_ACT = "45";
    public static void DeleteAnswer(int question_id, int user_id, Action<string> callback)
    {
        string post = $"act={DELETE_ANSWER_ACT}&user_id={user_id}&question_id={question_id}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }

    #endregion




    #region USERS

    private const string USERNAME_BY_QUESTION_ACT = "42";
    public static void GetUsernameByUserID(int user_id, Action<string> callback)
    {
        string post = $"act={USERNAME_BY_QUESTION_ACT}&user_id={user_id}";
        instance.webSender.PostQueryOnServer(post, QUESTIONS_URL, callback);
    }

    #endregion

}
