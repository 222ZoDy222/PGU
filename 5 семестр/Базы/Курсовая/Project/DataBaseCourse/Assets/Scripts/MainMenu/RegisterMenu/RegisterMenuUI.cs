using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class RegisterMenuUI : MonoBehaviour
{

    /// <summary>
    /// ���� �������
    /// </summary>
    [SerializeField] private CanvasGroup regMenuCanvas, authMenuCanvas;

    /// <summary>
    /// ������ ������������ ��������
    /// </summary>
    [SerializeField] private Button authButtonSwitch, regButtonSwitch;

    /// <summary>
    /// ���� ��� ����������
    /// </summary>
    [SerializeField] private TMP_InputField regNameField, regPassField, authNameField, authPassField;
    private string regName = "";
    private string regPass = "";
    private string authName = "";
    private string authPass = "";
    /// <summary>
    /// ������ ����������� � �����������
    /// </summary>
    [SerializeField] private Button regButton, authButton;



    private void Start()
    {
        AddListeners();
        
    }

    public void ShowMenu()
    {
        ClearFields();
    }

    private void ClearFields()
    {
        DeleteListeners();
        regNameField.text = "";
        authNameField.text = "";
        regPassField.text = "";
        authPassField.text = "";
        AddListeners();
    }

    private void AddListeners()
    {
        goToReg();
        CheckFields();
        regNameField.onValueChanged.AddListener((msg) =>
        {
            regName = msg;
            CheckFields();
        });
        regPassField.onValueChanged.AddListener((msg) =>
        {
            regPass = msg;
            CheckFields();
        });
        authNameField.onValueChanged.AddListener((msg) =>
        {
            authName = msg;
            CheckFields();
        });
        authPassField.onValueChanged.AddListener((msg) =>
        {
            authPass = msg;
            CheckFields();
        });

        authButtonSwitch.onClick.AddListener(goToAuth);

        regButtonSwitch.onClick.AddListener(goToReg);

    }

    private void DeleteListeners()
    {
        regNameField.onValueChanged.RemoveAllListeners();
        regPassField.onValueChanged.RemoveAllListeners();
        authNameField.onValueChanged.RemoveAllListeners();
        authPassField.onValueChanged.RemoveAllListeners();

        authButtonSwitch.onClick.RemoveAllListeners();

        regButtonSwitch.onClick.RemoveAllListeners();
    }

    private void goToAuth()
    {
        regMenuCanvas.AlphaAndRaycastToggle(false);
        authMenuCanvas.AlphaAndRaycastToggle(true);
    }

    private void goToReg()
    {
        authMenuCanvas.AlphaAndRaycastToggle(false);
        regMenuCanvas.AlphaAndRaycastToggle(true);
    }

    private void CheckFields()
    {
        UndefinedUser(false);
        NameExist(false);
        // ���� ��� ���� ����������� ���������
        if (regName != "" && regPass != "")
        {
            regButton.gameObject.SetActive(true);
        } else
        {
            regButton.gameObject.SetActive(false);
        }

        if(authName != "" && authPass != "")
        {
            authButton.gameObject.SetActive(true);
        } else
        {
            authButton.gameObject.SetActive(false);
        }
    }

    public void Registration()
    {
        WebManager.Registration(regName, regPass, (msg) =>
        {
            User user = JsonUtility.FromJson<User>(msg);
            
            // ���� ������������ �����������������
            if(user.userID != 0)
            {
                // ��� ��� ������
                if(user.username == NAME_EXIST)
                {
                    NameExist(true);
                    return;
                } 
                UserInfo.user = user;
                MenuSwitcher.instance.ShowProfileMenu();
                Debug.Log("������������ �����������������");
            } 
            else
            {
                Debug.Log("������������ �� �����������������");
            }

        });
    }

    [SerializeField] private TMP_Text nameExistTextError;
    private void NameExist(bool flag)
    {
        nameExistTextError.gameObject.SetActive(flag);
    }



    // ���� ��� ��� ������, �� � username ����� ��� ������
    public const string NAME_EXIST= "-AlreadyExist1925109251";

    [SerializeField] private TMP_Text userUndefined;
    private void UndefinedUser(bool flag)
    {
        userUndefined.gameObject.SetActive(flag);
    }


    public void Authenfication()
    {
        WebManager.Authentication(authName, authPass, (msg) =>
        {
            User user = JsonUtility.FromJson<User>(msg);

            // ���� ������������ ���
            if (user.userID != 0)
            {
                
                UserInfo.user = user;
                MenuSwitcher.instance.ShowProfileMenu();
                Debug.Log("������������ ���������������");
            }
            else
            {
                UndefinedUser(true);
                Debug.Log("������������ �� ���������������");
            }

        });
    }


}

