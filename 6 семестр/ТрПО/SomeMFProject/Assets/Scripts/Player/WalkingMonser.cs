using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WalkingMonser : Enemy
{

    [SerializeField] private Transform target;

    [SerializeField] private Transform target_1, target_2;
    private bool targetBool = false;

    Animator anim;

    private void Start()
    {
        target = target_2;
        anim = GetComponent<Animator>();
        speed = 4f;
        anim.Play("Monster");
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = Vector2.MoveTowards(transform.position, target.position, speed * Time.deltaTime);
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Target_monser_enemy")
        {
            targetBool = !targetBool;
            if (targetBool) target = target_1;
            else target = target_2;

        }
    }

    
}
