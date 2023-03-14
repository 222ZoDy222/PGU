using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InputEEE : MonoBehaviour
{
    [SerializeField] private InputField inputField;
    [SerializeField] private Text outPut;
    [SerializeField] private TW_MultiStrings_RandomText matrixShit;


    [SerializeField] private InputField keyField;


    [SerializeField] private Button getFromFile;

    [SerializeField] private GameObject errorLimit;
    [SerializeField] private GameObject errorMsg;

    private string KEY = "сергей";

    private string alphabit = " абвгдежзийклмнопрстуфхцчшщъыэюя";

    private char[,] ALPABIT;

    

    private void Awake()
    {
        //ALPABIT = alphabit.ToCharArray();

        ALPABIT = new char[alphabit.Length, alphabit.Length];
        for (int i = 0; i < alphabit.Length; i++)
        {
            for (int j = 0; j < alphabit.Length; j++)
            {
                if(i+j >= alphabit.Length)
                {
                    ALPABIT[i,j] = alphabit[i + j - alphabit.Length];
                    
                } else
                {
                    ALPABIT[i,j] = alphabit[i + j];
                }
                
            }
        }


    }

    // Start is called before the first frame update
    void Start()
    {

        inputField.onValueChanged.AddListener(OnValueChanged);

        keyField.onEndEdit.AddListener(FillKay);

        getFromFile.onClick.AddListener(GetFromFile);

        keyField.text = KEY;
    }

    private void GetFromFile()
    {
        string path = Application.dataPath + "/data.txt";

        string text = System.IO.File.ReadAllText(path);

        if (text == null || text == "") return;
        if (!isOk(text))
        {
            inputField.text = "";
            errorMsg.SetActive(true);
            return;
        }
        if (text.Length > 30)
        {
            errorLimit.SetActive(true);
            errorMsg.SetActive(false);
            outPut.text = "";
            return;
        }
        inputField.text = text;
        OnValueChanged(text);

    }

    private bool isOk(string msg)
    {
        if(msg.Length > 30)
        {
            errorLimit.SetActive(true);
            errorMsg.SetActive(false);
            outPut.text = "";
           
        } else
        {
            errorLimit.SetActive(false);
        }
        bool[] flags = new bool[msg.Length];
        for (int i = 0; i < flags.Length; i++) flags[i] = false;
        
        for (int i = 0; i < msg.Length; i++)
        {
            for (int j = 0; j < alphabit.Length; j++)
            {

                if(msg[i] == alphabit[j])
                {
                    flags[i] = true;
                    break;
                }

            }
        }

        for (int i = 0; i < flags.Length; i++)
        {
            if (!flags[i])
            {
                errorMsg.SetActive(true);
                return false;
            }
        }
        errorMsg.SetActive(false);
        return true;

    }

    private void FillKay(string msg)
    {

        msg = msg.ToLower();
        if(msg == "")
        {
            errorMsg.SetActive(true);
            //KEY = "сергей";
            keyField.text = "";
            outPut.text = "";
            return;
        }
        else
        {
            if (!isOk(msg))
            {
                errorMsg.SetActive(true);
                //KEY = "сергей";
                keyField.text = "";
                outPut.text = "";
                return;
            }
            else
            {
                errorMsg.SetActive(false);

                KEY = msg;
            }
            
        }
            

        OnValueChanged(inputField.text);
    }

    

    public void OnValueChanged(string msg)
    {
        // никита
        // сергей
        // _оымшк
        
        msg = msg.ToLower();
        if (!isOk(msg))
        {
            errorMsg.SetActive(true);
            outPut.text = "";
            
            return;
        }
        if (!isOk(KEY))
        {
            errorMsg.SetActive(true);
            return;
        }
        int lengthText = inputField.text.Length;
        var length = msg.Length;

        string result = "";

        for (int i = 0; i < length; i++)
        {
            int i1 = getIndex(msg[i]);
            int i2 = getIndex(KEY[getIndexKey(i)]);
            //i2 = getIndexKey_1(KAY[i]);
            result += ALPABIT[i1, i2];
        }
        outPut.text = result;
        matrixShit.ORIGINAL_TEXT = result;
        matrixShit.StartTypewriter();
    }
    
    private int getIndexKey(int i)
    {

        while(i >= KEY.Length)
        {
            i -= KEY.Length;
        }
        return i;

    }

    private int getIndexKey_1(char msg)
    {
        for (int i = 0; i < KEY.ToCharArray().Length; i++)
        {
            if (msg == KEY[i]) return i;
        }
        return 0;
    }

    private int getIndex(char msg)
    {
        for (int i = 0; i < alphabit.ToCharArray().Length; i++)
        {
            if (msg == alphabit[i]) return i;
        }
        return 0;
    }



}
