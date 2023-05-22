using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{

    [SerializeField] protected float m_health = 100;

    private Rigidbody2D rb;

    public float Health
    {
        get => m_health;
        set
        {
            m_health = value;
            if (m_health <= 0)
            {
                m_health = 0;
                Death();
            }
        }
    }

    [SerializeField] protected float damage = 25;

    public bool isInfinityHealth = false;

    [SerializeField] protected float speed;

    [SerializeField] private EnemyHit enemyHit;


    private void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        if (enemyHit != null) enemyHit.onHit += Hit;
    }

    private void Death()
    {
        Destroy(rb.gameObject);
    }

    public void Hit(float value)
    {
        SetHit(value);
    }

    private void SetHit(float value)
    {
        float h = Health;
        h -= value;
        Health = h;
    }


    public void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.collider.name == "Player")
        {
            Debug.Log("Hit");
            Player.player.Hit(damage);
        }
    }



}
