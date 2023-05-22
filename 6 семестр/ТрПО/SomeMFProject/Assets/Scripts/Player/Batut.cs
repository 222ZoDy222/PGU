using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Batut : MonoBehaviour
{

    [SerializeField] private float force = 30;

    public void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.collider.name == "Player")
        {
            Debug.Log("Batut");
            Player.player.rb.AddForce(Player.player.transform.up * force, ForceMode2D.Impulse);
        }
    }




}
