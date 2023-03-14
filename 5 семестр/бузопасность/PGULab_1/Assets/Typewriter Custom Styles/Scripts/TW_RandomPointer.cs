using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TW_RandomPointer : MonoBehaviour {

    public bool LaunchOnStart = true;
    public int timeOut = 1;
    public RandomCharsType Charstype = RandomCharsType.UpperCase;
    public enum RandomCharsType { LowerCase, UpperCase, LowerUpperCase, Digits, Symbols, All };
    public string ORIGINAL_TEXT;

    private float time = 0f;
    private int сharIndex = 0;
    private bool start;
    private List<int> n_l_list;

    private static System.Random random = new System.Random();
    private static string lowerCase = "abcdefghijklmnopqrstuvwxyz";
    private static string upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static string lowerupperCase = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static string digits = "0123456789";
    private static string symbols = "#@$^*?~&";
    private static string all = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#@$^*?~&";

    void Start () {
        ORIGINAL_TEXT = gameObject.GetComponent<Text>().text;
        gameObject.GetComponent<Text>().text = "";
        if (LaunchOnStart)
        {
            StartTypewriter();
        }
    }
	
	void Update () {
        if (start == true) {
            NewLineCheck(ORIGINAL_TEXT);
        }
    }

    public void StartTypewriter()
    {
        start = true;
        сharIndex = 0;
        time = 0f;
    }

    public void SkipTypewriter() {
        сharIndex = ORIGINAL_TEXT.Length - 1;
    }

    private void NewLineCheck(string S)
    {
        if (S.Contains("\n"))
        {
            StartCoroutine(MakeRandomTypewriterTextWithNewLine(S,MakeList(S)));
        }
        else
        {
            StartCoroutine(MakeRandomTypewriterText(S));
        }
    }

    private IEnumerator MakeRandomTypewriterText(string ORIGINAL)
    {
        start = false;
        if (сharIndex != ORIGINAL.Length + 1)
        {
            string emptyString = new string(' ', ORIGINAL.Length - 1);
            string TEXT = ORIGINAL.Substring(0, сharIndex) + RandomChar(ORIGINAL, сharIndex);
            if (сharIndex < ORIGINAL.Length) TEXT = TEXT + emptyString.Substring(сharIndex);
            gameObject.GetComponent<Text>().text = TEXT;
            time += 1f;
            yield return new WaitForSeconds(0.01f);
            CharIndexPlus();
            start = true;
        }
    }

    private IEnumerator MakeRandomTypewriterTextWithNewLine(string ORIGINAL, List<int> List)
    {
        start = false;
        if (сharIndex != ORIGINAL.Length + 1)
        {
            string emptyString = new string(' ', ORIGINAL.Length - 1);
            string TEXT = ORIGINAL.Substring(0, сharIndex) + RandomChar(ORIGINAL, сharIndex);
            if (сharIndex < ORIGINAL.Length) TEXT = TEXT + emptyString.Substring(сharIndex);
            TEXT = InsertNewLine(TEXT, List);
            gameObject.GetComponent<Text>().text = TEXT;
            time += 1f;
            yield return new WaitForSeconds(0.01f);
            CharIndexPlus();
            start = true;
        }
    }

    private string RandomChar(string ORIGINAL, int currentCharIndex)
    {
        string randomChar;
        if (currentCharIndex != ORIGINAL.Length)
        {
            string chars = GetCharsType(Charstype);
            randomChar = new string(chars[random.Next(0, chars.Length)], 1).ToString();
        }
        else
        {
            randomChar = "";
        }
        return randomChar;
    }

    private List<int> MakeList(string S)
    {
        n_l_list = new List<int>();
        for (int i = 0; i < S.Length; i++)
        {
            if (S[i] == '\n')
            {
                n_l_list.Add(i);
            }
        }
        return n_l_list;
    }

    private string InsertNewLine(string _TEXT, List<int> _List)
    {
        for (int index = 0; index < _List.Count; index++)
        {
            if (сharIndex - 1 < _List[index])
            {
                _TEXT = _TEXT.Insert(_List[index], "\n");
            }
        }
        return _TEXT;
    }

    private string GetCharsType(RandomCharsType T)
    {
        string s = "";
        if (T == RandomCharsType.LowerCase)
            s = lowerCase;
        if (T == RandomCharsType.UpperCase)
            s = upperCase;
        if (T == RandomCharsType.LowerUpperCase)
            s = lowerupperCase;
        if (T == RandomCharsType.Digits)
            s = digits;
        if (T == RandomCharsType.Symbols)
            s = symbols;
        if (T == RandomCharsType.All)
            s = all;
        return s;
    }

    private void CharIndexPlus()
    {
        if (time == timeOut)
        {
            time = 0f;
            сharIndex += 1;
        }
    }

}
