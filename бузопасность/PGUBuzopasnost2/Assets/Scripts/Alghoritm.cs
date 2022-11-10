using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Alghoritm : MonoBehaviour
{

    [SerializeField] private string symbols;

    string ggg = "ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßabcdefghijklmnopqrstuvwxyz";

    public char[] s;
    public int Length;

    public int L = 4;

    private void Start()
    {

        Sync(4,ggg);
    }

    public string GeneratePassword()
    {
        string result = "";
        for (int i = 0; i < L; i++)
        {
            result += s[UnityEngine.Random.Range(0, Length-1)];
        }
        return result;
    }

    public int CalculateTries(string pass)
    {
        int passLength = pass.Length;

        char[] pl = pass.ToCharArray();
        int firstStep = 0;
        for (int i = L; i < passLength; i++)
        {
            firstStep += Pow(Length, i);
        }
        /////////////////////////////////////////////////////

        int secondStep = 0;
        for (int i = 0; i < pl.Length; i++)
        {
            secondStep += GetIndex(pl[i]) * Pow(Length, pl.Length - i);
        }

        return firstStep + secondStep;



    }

    public int CalculateDays(int tries, int tryiesAtDay)
    {

        double days = (tries / tryiesAtDay);

        return (int)days;

    }

    public int Pow(int a, int b)
    {
        return Convert.ToInt32(Math.Pow(a, b));
    }

    private int GetIndex(char c)
    {
        for (int i = 0; i < s.Length; i++)
        {
            if (c == s[i]) return i;
        }
        Debug.LogError("It will never happend");
        return 0;
    }


    private bool IsOkWord(char c)
    {
        for (int i = 0; i < s.Length; i++)
        {
            if (c == s[i]) return true;
        }
        return false;
    }

    public string CleanText(string msg)
    {
        string result = "";
        for (int i = 0; i < msg.Length; i++)
        {
            if (IsOkWord(msg[i])) result += msg[i];
        }
        return result;

    }



    public void Sync(int L, string symbols)
    {

        this.L = L;
        s = symbols.ToCharArray();
        Length = s.Length;
    }

}
