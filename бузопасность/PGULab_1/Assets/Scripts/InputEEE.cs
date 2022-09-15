using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InputEEE : MonoBehaviour
{
    [SerializeField] private InputField inputField;
    [SerializeField] private Text outPut;
    [SerializeField] private TW_MultiStrings_RandomText matrixShit;

    private string KAY = "сергей";

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

    }


    private char GetKeyCode(char key, int index)
    {


        return '0';
    }

    public void OnValueChanged(string msg)
    {
        // никита
        // сергей
        // _оымшк
        
        msg = msg.ToLower();
        int lengthText = inputField.text.Length;
        var length = msg.Length;

        string result = "";

        for (int i = 0; i < length; i++)
        {
            int i1 = getIndex(msg[i]);
            int i2 = getIndex(KAY[getIndexKey(i)]);
            //i2 = getIndexKey_1(KAY[i]);
            result += ALPABIT[i1, i2];
        }
        outPut.text = result;
        matrixShit.ORIGINAL_TEXT = result;
        matrixShit.StartTypewriter();
    }
    
    private int getIndexKey(int i)
    {

        while(i >= KAY.Length)
        {
            i -= KAY.Length;
        }
        return i;

    }

    private int getIndexKey_1(char msg)
    {
        for (int i = 0; i < KAY.ToCharArray().Length; i++)
        {
            if (msg == KAY[i]) return i;
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
