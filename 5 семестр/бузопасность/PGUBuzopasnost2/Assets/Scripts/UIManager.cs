using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{

    [SerializeField] private Text resultText, textBrut, textDays;

    [SerializeField] private InputField field;


    [SerializeField] private Alghoritm alghoritm;


    [SerializeField] private int triesAtDay = 100;

    [SerializeField] private InputField symbolsField, LField;

    //[SerializeField] private Button tryAlghoritm, tryRandom, RandomGenerate;
    [SerializeField] private Button generateAll;

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

        generateAll.onClick.AddListener(GenerateAll);
    }


    public void GenerateAll()
    {
        GeneratePassword();
        CalculatePassword();
        TryRandomBrut();
    }

    public void OnValueChangetDield(string msg)
    {
        
        field.text = alghoritm.CleanText(msg);
        Sync();
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
        //tryAlghoritm.gameObject.SetActive(false);
        //tryRandom.gameObject.SetActive(false);
        //RandomGenerate.gameObject.SetActive(false);
        generateAll.gameObject.SetActive(false);
        IEnumerator coroutine()
        {
            for (int i = 0; i < 100 * 12; i++)
            {
                yield return null;
                string passGenerate = alghoritm.GeneratePassword();
                textBrut.text = passGenerate;
                if (field.text == passGenerate)
                {
                    resultText.text = "ÂÀÓ ÑÃÅÍÅÐÈÐÎÂÀËÑß!!!! ïîïûòîê ïîíàäîáèëîñü " + i;
                    Log("ÂÀÓ ÑÃÅÍÅÐÈÐÎÂÀËÑß!!!! ïîïûòîê ïîíàäîáèëîñü " + i + " Äíåé ïîíàäîáèëîñü " + Convert.ToInt32(Convert.ToInt32(i / 100) + 1));

                    generateAll.gameObject.SetActive(true);
                    yield break;
                }
                else
                {
                    resultText.text = "Ïîêà íå ñãåíåðèðîâàëñÿ";
                }
            }
            resultText.text = "ÅÕ, íèêàê íå ïîëó÷èëîñü!";
            Log("ÅÕ, íèêàê íå ïîëó÷èëîñü!");
            generateAll.gameObject.SetActive(true);
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
       
        
        if (symbolsField.text == "" || LField.text == "")
        {
            //tryAlghoritm.gameObject.SetActive(false);
            //tryRandom.gameObject.SetActive(false);
            //RandomGenerate.gameObject.SetActive(false);
            generateAll.gameObject.SetActive(false);
        } 
        else
        {
            generateAll.gameObject.SetActive(true);
            try
            {
                int value = Convert.ToInt32(LField.text);
                if (value > 10)
                {
                    value = 10;
                }
                else if (value < 1) value = 1;
                LField.text = value.ToString();
                Sync();
            } catch
            {
                generateAll.gameObject.SetActive(false);
            }
            
            
            //tryAlghoritm.gameObject.SetActive(true);
            //tryRandom.gameObject.SetActive(true);
            //RandomGenerate.gameObject.SetActive(true);
        }
        
    }

   

    private void CalculatePassword()
    {
        string msg = field.text;
        ulong tries = alghoritm.CalculateTries(msg);



        textDays.text = (alghoritm.CalculateDays(tries, triesAtDay) + 1) + " äíåé";
        Log($"äíåé ïîíàäîáèëîñü {textDays.text}, ïîïûòîê ïîíàäîáèëîñü {tries.ToString()}");
    }


}
