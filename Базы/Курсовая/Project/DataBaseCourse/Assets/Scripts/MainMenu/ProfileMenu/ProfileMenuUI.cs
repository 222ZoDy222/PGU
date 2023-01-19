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

        HideUsersWithFilesUI();

    }

    private void OnUserUpdate()
    {

        usernameText.text = UserInfo.user.username;

        raitingText.text = UserInfo.user.raiting.ToString();




    }




    [SerializeField] private RectTransform usersWithFilesContainer;
    [SerializeField] private UserWithFilesUI userWithFilesUIPrefab;
    [SerializeField] private CanvasGroup usersWithFilesCanvas;
    public void ShowUsersWithFilesUI()
    {
        usersWithFilesCanvas.AlphaAndRaycastToggle(true);
        WebManager.GetBestUsers((msg) =>
        {
            Debug.Log(msg);
            if (msg != null)
            {
                UserWithFiles[] users = JsonHelper.FromJson<UserWithFiles>(msg);
                if (users != null && users.Length != 0)
                {
                    for (int i = 0; i < users.Length; i++)
                    {
                        SpawnUserWithFiles(users[i]);
                    }
                    

                }



            }
            else
            {
                HideUsersWithFilesUI();
            }
        });
    }

    public void HideUsersWithFilesUI()
    {
        usersWithFilesCanvas.AlphaAndRaycastToggle(false);
    }

    private void SpawnUserWithFiles(UserWithFiles user)
    {
        Instantiate(userWithFilesUIPrefab, usersWithFilesContainer).Init(user);
    }



}
