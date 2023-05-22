using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NextSceneTrigger : MonoBehaviour
{
    [SerializeField] private bool isNextScene = true;

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Player")
        {
            if (isNextScene)
                SceneManager.NextLevel();
            else
            {
                SceneManager.RestartLevel();
            }
        }

    }
    
    

}
