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
        //AddListeners();
        Test();
    }

    private void Test()
    {
        WebManager.Registration("f", "f", (msg) =>
        {
            testClass testVar = JsonUtility.FromJson<testClass>(msg);
            Debug.Log(testVar.name);
            Debug.Log(testVar.var);
        });
    }

    private class testClass
    {
        public string var;

        public string name;
    }

    private void AddListeners()
    {
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
            authPass = msg;
            CheckFields();
        });
        authPassField.onValueChanged.AddListener((msg) =>
        {
            authPass = msg;
            CheckFields();
        });
    }

    private void CheckFields()
    {
        // Если оба поля регистрации заполнены
        if(regName != "" && regPass != "")
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

    }

    public void Authenfication()
    {

    }

}
