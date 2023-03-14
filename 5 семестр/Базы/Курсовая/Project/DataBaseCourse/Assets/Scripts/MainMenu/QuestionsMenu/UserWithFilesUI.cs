using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class UserWithFilesUI : MonoBehaviour
{

    [SerializeField] private TMP_Text username, countOfFiles;




    public void Init(UserWithFiles user)
    {
        username.text = user.username;
        countOfFiles.text = user.countOFFiles.ToString();
    }





}
