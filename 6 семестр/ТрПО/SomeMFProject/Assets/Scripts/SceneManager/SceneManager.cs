using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneManager : MonoBehaviour
{
    public static SceneManager instance;



    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;
    }


    [SerializeField] private string NextScene;

    [SerializeField] private Transform restartLevelTrigger;



    public static void NextLevel()
    {
        UnityEngine.SceneManagement.SceneManager.LoadScene(instance.NextScene);
    }

    public static void RestartLevel()
    {
        Application.LoadLevel(Application.loadedLevel);
    }



}
