using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BackgroundMover : MonoBehaviour
{
    [SerializeField] private Transform player;
    private Transform transform;

    private void Awake()
    {
        transform = GetComponent<Transform>();
    }
    // Update is called once per frame
    void Update()
    {
        transform.position = new Vector3(player.position.x, transform.position.y, 0);
    }
}
