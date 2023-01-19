using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class RegisterMenuUI : MonoBehaviour
{

    /// <summary>
    /// Меню канвасы
    /// </summary>
    [SerializeField] private CanvasGroup regMenuCanvas, authMenuCanvas;

    /// <summary>
    /// Кнопки переключения канвасов
    /// </summary>
    [SerializeField] private Button authButtonSwitch, regButtonSwitch;

    /// <summary>
    /// Поля для заполнения
    /// </summary>
    [SerializeField] private TMP_InputField regNameField, regPassField, authNameField, authPassField;
    private string regName = "";
    private string regPass = "";
    private string authName = "";
    private string authPass = "";
    /// <summary>
    /// Кнопки регистрации и авторизации
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
        // Если оба поля регистрации заполнены
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
            
            // Если пользователь зарегестрировался
            if(user.userID != 0)
            {
                // ИМя уже занято
                if(user.username == NAME_EXIST)
                {
                    NameExist(true);
                    return;
                } 
                UserInfo.user = user;
                MenuSwitcher.instance.ShowProfileMenu();
                Debug.Log("Пользователь зарегестрировался");
            } 
            else
            {
                Debug.Log("Пользователь НЕ зарегестрировался");
            }

        });
    }

    [SerializeField] private TMP_Text nameExistTextError;
    private void NameExist(bool flag)
    {
        nameExistTextError.gameObject.SetActive(flag);
    }



    // Если имя уже занято, то в username будет эта строка
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

            // Если пользователя нет
            if (user.userID != 0)
            {
                
                UserInfo.user = user;
                MenuSwitcher.instance.ShowProfileMenu();
                Debug.Log("Пользователь авторизировался");
            }
            else
            {
                UndefinedUser(true);
                Debug.Log("Пользователь НЕ авторезировался");
            }

        });
    }


}

