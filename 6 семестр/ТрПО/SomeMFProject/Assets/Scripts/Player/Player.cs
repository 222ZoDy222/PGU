using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public static Player instance;

    [SerializeField] private PlayerMovement movement;

    public Rigidbody2D rb;

    private float m_health = 100;
    public float health
    {
        get => m_health;

        set
        {
            m_health = value;

            if(m_health <= 0)
            {
                DieMenu.instance.Show();
                Die();
            }
        }
    }

    private void Awake()
    {
        instance = this;
        rb = GetComponent<Rigidbody2D>();
        movement = GetComponent<PlayerMovement>();
    }


    public static Player player { get => instance; }

    public void Hit(float value)
    {

        health -= value;

    }

    private void Die()
    {

        movement.Die();

    }

}
