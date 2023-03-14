using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

#if UNITY_EDITOR
using UnityEditor;
[CustomEditor(typeof(TW_Regular)), CanEditMultipleObjects]
[Serializable]
public class TW_Regular_Editor : Editor
{
    private static string[] PointerSymbols = { "None", "<", "_", "|", ">" };
    private TW_Regular TW_RegularScript;

    private void Awake()
    {
        TW_RegularScript = (TW_Regular)target;
    }

    private void MakePopup(SerializedObject obj)
    {
        TW_RegularScript.pointer = EditorGUILayout.Popup("Pointer symbol",TW_RegularScript.pointer, PointerSymbols, EditorStyles.popup);
    }

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        SerializedObject SO = new SerializedObject(TW_RegularScript);
        MakePopup(SO);
    }
}
#endif

public class TW_Regular : MonoBehaviour {

    public bool LaunchOnStart = true;
    public int timeOut = 1;
    [HideInInspector]
    public int pointer=0;
    public string ORIGINAL_TEXT;

    private float time = 0f;
    private int сharIndex = 0;
    private bool start;
    private List<int> n_l_list;
    private static string[] PointerSymbols = { "None", "<", "_", "|", ">" };

    void Start () {
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

    private void NewLineCheck(string S)
    {
        if (S.Contains("\n")){
            StartCoroutine(MakeTypewriterTextWithNewLine(S, GetPointerSymbol(), MakeList(S)));
        }
        else{
            StartCoroutine(MakeTypewriterText(S,GetPointerSymbol()));
        }
    }

    private IEnumerator MakeTypewriterText(string ORIGINAL, string POINTER)
    {
        start = false;
        if (сharIndex != ORIGINAL.Length + 1)
        {
            string emptyString = new string(' ', ORIGINAL.Length - POINTER.Length);
            string TEXT = ORIGINAL.Substring(0, сharIndex);
            if (сharIndex < ORIGINAL.Length) TEXT = TEXT + POINTER + emptyString.Substring(сharIndex);
            gameObject.GetComponent<Text>().text = TEXT;
            time += 1;
            yield return new WaitForSeconds(0.01f);
            CharIndexPlus();
            start = true;
        }
    }

    private IEnumerator MakeTypewriterTextWithNewLine(string ORIGINAL, string POINTER, List<int> List)
    {
        start = false;
        if (сharIndex != ORIGINAL.Length + 1)
        {
            string emptyString = new string(' ', ORIGINAL.Length - POINTER.Length);
            string TEXT = ORIGINAL.Substring(0, сharIndex);
            if (сharIndex < ORIGINAL.Length) TEXT = TEXT + POINTER + emptyString.Substring(сharIndex);
            TEXT = InsertNewLine(TEXT, List);
            gameObject.GetComponent<Text>().text = TEXT;
            time += 1f;
            yield return new WaitForSeconds(0.01f);
            CharIndexPlus();
            start = true;
        }
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

    private string GetPointerSymbol()
    {
        if (pointer == 0){
            return "";
        }
        else{
            return PointerSymbols[pointer];
        }
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
