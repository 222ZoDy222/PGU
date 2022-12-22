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
        string post = $"act={REGISTRATION_ACT}&name={name}&pass={pass}";

        instance.webSender.PostQueryOnServer(post, REGISTRATION_URL, callback);


    }




    #endregion
}
