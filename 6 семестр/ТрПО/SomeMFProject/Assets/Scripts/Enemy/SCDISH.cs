using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SCDISH : MonoBehaviour
{

    Rigidbody2D rb;
    Vector3 m_YAxis;

    private void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
    }

    public void StartDrop()
    {
        rb.bodyType = RigidbodyType2D.Dynamic;
        //m_YAxis = new Vector3(0, 5, 0);
        //rb.velocity = m_YAxis;
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.collider.name == "Player")
        {
            Player.player.Hit(120f);

        } else
        {
            Destroy(rb.gameObject);
        }

    }
    
}
