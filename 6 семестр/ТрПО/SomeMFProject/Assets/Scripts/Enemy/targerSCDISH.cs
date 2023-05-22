using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class targerSCDISH : MonoBehaviour
{

    [SerializeField] List<SCDISH> sc;

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Player")
        {
            for (int i = 0; i < sc.Count; i++)
            {
                if(sc[i] != null) sc[i].StartDrop();
            }

        }

    }
}
