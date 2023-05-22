using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DieMenu : MonoBehaviour
{

    public static DieMenu instance;


    private void Awake()
    {
        if (instance != null) Destroy(instance);
        instance = this;
    }

    [SerializeField] private GameObject dieMenu;


    private void Start()
    {
        Hide();
    }

    public void Show()
    {
        dieMenu.SetActive(true);
    }

    public void Hide()
    {
        dieMenu.SetActive(false);
    }





}
