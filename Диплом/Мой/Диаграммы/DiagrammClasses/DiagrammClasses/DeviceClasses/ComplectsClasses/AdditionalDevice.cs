using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class AdditionalDevice : Device
{


    public Type_additional typeAdditional;

    public Status status;


    private string m_name;

    public string Name
    {
        get => m_name;

        set => m_name = value;
    }

    public void SaveName(string name)
    {
        Name = name;
        Saver.AdditionalNameSaver.SaveName(this);
    }

    public StatsCheck statsCheck;



    public enum Type_additional
    {
        controlPoint,
        radioBomb
    }



    /// <summary>
    /// Подряд пришедшие таймауты
    /// </summary>
    public byte connectionLosts = 0;

    private sbyte m_connection;
    public sbyte connection
    {
        get => m_connection;


        set
        {

            m_connection = value;
            if (m_connection > 100) m_connection = 100;
            else if (m_connection < 0) m_connection = 0;
        }

    }

    public Action onDelete;

    public void Delete()
    {
        onDelete?.Invoke();
        AdditionalAdder.instance.DeleteDevice(this);
        Gameplay.instance.DeleteAdditionalFromGame(this);
    }
    

    // В будущем добавить перегрузки на другие доп. девайсы

}
