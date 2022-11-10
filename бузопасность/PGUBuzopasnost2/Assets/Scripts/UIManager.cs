using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{

    [SerializeField] private Text resultText;

    [SerializeField] private InputField field;


    [SerializeField] private Alghoritm alghoritm;


    [SerializeField] private int triesAtDay = 100;

    [SerializeField] private InputField symbolsField, LField;

    [SerializeField] private Button tryAlghoritm, tryRandom, RandomGenerate;


    private void Start()
    {
        LField.text = "4";
        symbolsField.text = "ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßabcdefghijklmnopqrstuvwxyz";
        field.onValueChanged.AddListener(OnValueChangetDield);

        symbolsField.onValueChanged.AddListener((msg)=> { checkBUttons(); });
        LField.onValueChanged.AddListener((msg) => { checkBUttons(); });
        field.onValueChanged.AddListener((msg) => { checkBUttons(); });
        path = Application.dataPath;
        path += "/data.txt";
        Log("start");
    }

    public void OnValueChangetDield(string msg)
    {
        field.text = alghoritm.CleanText(msg);
    }

    string path;
    public void Log(string msg)
    {
        string old = "";
        if (File.Exists(path))
        {
            old = File.ReadAllText(path);
        }
        old += "\n";
        old += msg;

        File.WriteAllText(path, old);

    }

    public void TryRandomBrut()
    {
        tryAlghoritm.gameObject.SetActive(false);
        tryRandom.gameObject.SetActive(false);
        RandomGenerate.gameObject.SetActive(false);
        IEnumerator coroutine()
        {
            for (int i = 0; i < 100 * 12; i++)
            {
                yield return null;
                if(field.text == alghoritm.GeneratePassword())
                {
                    resultText.text = "ÂÀÓ ÑÃÅÍÅÐÈÐÎÂÀËÑß!!!! ïîïûòîê ïîíàäîáèëîñü " + i;
                    Log("ÂÀÓ ÑÃÅÍÅÐÈÐÎÂÀËÑß!!!! ïîïûòîê ïîíàäîáèëîñü " + i);
                    tryAlghoritm.gameObject.SetActive(true);
                    tryRandom.gameObject.SetActive(true);
                    RandomGenerate.gameObject.SetActive(true);
                    yield break;
                }
                else
                {
                    resultText.text = "Ïîêà íå ñãåíåðèðîâàëñÿ";
                }
            }
            resultText.text = "ÅÕ, íèêàê íå ïîëó÷èëîñü!";
            Log("ÅÕ, íèêàê íå ïîëó÷èëîñü!");
            tryAlghoritm.gameObject.SetActive(true);
            tryRandom.gameObject.SetActive(true);
            RandomGenerate.gameObject.SetActive(true);
        }
        StartCoroutine(coroutine());

    }

    public void GeneratePassword()
    {
        field.text = alghoritm.GeneratePassword();
    }


    public void Sync()
    {
        int L = Convert.ToInt32(LField.text);
        string m = symbolsField.text;
        alghoritm.Sync(L, m);
    }

    public void checkBUttons()
    {
        if(symbolsField.text == "" || LField.text == "")
        {
            tryAlghoritm.gameObject.SetActive(false);
            tryRandom.gameObject.SetActive(false);
            RandomGenerate.gameObject.SetActive(false);
        } 
        else
        {
            tryAlghoritm.gameObject.SetActive(true);
            tryRandom.gameObject.SetActive(true);
            RandomGenerate.gameObject.SetActive(true);
        }
    }

    public void CLick()
    {
        string msg = field.text;
        int tries = alghoritm.CalculateTries(msg);

        resultText.text = alghoritm.CalculateDays(tries, triesAtDay) + " äíåé";
        Log(resultText.text);
    }



}
