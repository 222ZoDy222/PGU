using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

#if UNITY_EDITOR
using UnityEditor;
[CustomEditor(typeof(TW_MultiStrings_RandomPointer)), CanEditMultipleObjects]
[Serializable]
public class TW_MultiStrings_RandomPointer_Editor : Editor
{
    private int indexOfString;
    private TW_MultiStrings_RandomPointer TW_MS_RandomPointerScript;

    private void Awake()
    {
        TW_MS_RandomPointerScript = (TW_MultiStrings_RandomPointer)target;
    }

    private void MakeArrayGUI(SerializedObject obj, string name)
    {
        int size = obj.FindProperty(name + ".Array.size").intValue;
        int newSize = size;
        if (newSize != size)
            obj.FindProperty(name + ".Array.size").intValue = newSize;
        int[] array_value = new int[newSize];
        for (int i = 1; i < newSize; i++)
        {
            array_value[i] = i;
        }
        string[] array_content = new string[newSize];
        for (int i = 1; i < newSize; i++)
        {
            array_content[i] = (array_value[i] + 1).ToString();
        }
        if (TW_MS_RandomPointerScript.MultiStrings.Length == 0)
            EditorGUILayout.HelpBox("Number of Strings must be more than 0!", MessageType.Error);
        EditorGUILayout.HelpBox("Chose number of string in PoPup and edit text in TextArea below", MessageType.Info, true);
        indexOfString = EditorGUILayout.IntPopup("Edit string №", indexOfString, array_content, array_value, EditorStyles.popup);
        TW_MS_RandomPointerScript.MultiStrings[indexOfString] = EditorGUILayout.TextArea(TW_MS_RandomPointerScript.MultiStrings[indexOfString], GUILayout.ExpandHeight(true));
    }

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        SerializedObject SO = new SerializedObject(TW_MS_RandomPointerScript);
        MakeArrayGUI(SO, "MultiStrings");
    }
}
#endif

public class TW_MultiStrings_RandomPointer : MonoBehaviour {

    public bool LaunchOnStart = true;
    public int timeOut = 1;
    public RandomCharsType Charstype = RandomCharsType.UpperCase;
    public enum RandomCharsType { LowerCase, UpperCase, LowerUpperCase, Digits, Symbols, All };
    public string[] MultiStrings = new string[1];
    public string ORIGINAL_TEXT;

    private float time = 0f;
    private int сharIndex = 0;
    private int index_of_string = 0;
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
        MultiStrings[0] = gameObject.GetComponent<Text>().text;
        ORIGINAL_TEXT = gameObject.GetComponent<Text>().text;
        gameObject.GetComponent<Text>().text = "";
        if (LaunchOnStart)
        {
            StartTypewriter();
        }
    }

	void Update () {
        if (start == true){
            NewLineCheck(ORIGINAL_TEXT);
        }
    }

    public void StartTypewriter()
    {
        start = true;
        сharIndex = 0;
        time = 0f;
    }

    public void SkipTypewriter(){
        сharIndex = ORIGINAL_TEXT.Length - 1;
    }

    public void NextString()
    {
        start = true;
        сharIndex = 0;
        time = 0f;
        if (index_of_string + 1 < MultiStrings.Length){
            index_of_string++;
        }
        else{
            index_of_string = 0;
        }
        ORIGINAL_TEXT = MultiStrings[index_of_string];
    }

    public void LastString()
    {
        start = true;
        ORIGINAL_TEXT = MultiStrings[MultiStrings.Length - 1];
        сharIndex = ORIGINAL_TEXT.Length - 1;
    }

    private void NewLineCheck(string S)
    {
        if (S.Contains("\n"))
        {
            StartCoroutine(MakeRandomTypewriterTextWithNewLine(S, MakeList(S)));
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
