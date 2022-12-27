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




    #endregion



    #region Tasks
    ////////////////////////////////////////
    /////      T A S K S                //// 
    ////////////////////////////////////////

    private const string TASK_URL = "http://localhost/Labs/Tasks.php";

    private const string GET_TASKS_ACT = "21";

    public static void GetTasks(int subject_id, Action<string> callback)
    {
        string post = $"act={GET_TASKS_ACT}&subject_id={subject_id}";
        instance.webSender.PostQueryOnServer(post, TASK_URL, callback);
    }

    #endregion

}
