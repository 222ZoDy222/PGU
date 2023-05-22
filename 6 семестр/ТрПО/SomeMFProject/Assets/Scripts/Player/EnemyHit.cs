using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHit : MonoBehaviour
{

    [SerializeField] private float healthHit = 25;

    public Action<float> onHit;

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Player")
        {
            Debug.Log("Hit enemy");
            onHit?.Invoke(25f);
        }
    }
}
