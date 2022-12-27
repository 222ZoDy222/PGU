using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ProfileMenuUI : MonoBehaviour
{

    [SerializeField] private TMP_Text usernameText;
    [SerializeField] private TMP_Text raitingText;

    private void Start()
    {

        UserInfo.onUserUpdate += OnUserUpdate;

    }

    private void OnUserUpdate()
    {

        usernameText.text = UserInfo.user.username;

        raitingText.text = UserInfo.user.raiting.ToString();




    }




}
