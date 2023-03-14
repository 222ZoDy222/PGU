using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UserInfo : MonoBehaviour
{
    public static UserInfo instance;

    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;
    }

    private User _user;
    public static User user
    {
        get => instance._user;

        set
        {
            instance._user = value;
            onUserUpdate?.Invoke();
        }

    }

    public delegate void UserUpdate();

    public static UserUpdate onUserUpdate;



}


