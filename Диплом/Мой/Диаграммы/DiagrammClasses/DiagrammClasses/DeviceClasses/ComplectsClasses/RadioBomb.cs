using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RadioBomb : AdditionalDevice
{




    public RadioBomb(Device dev)
    {

        this.uid = dev.uid;
        this.config = dev.config;
        this.onUpdate += UpdateConfig;
        UpdateConfig();


    }



    public void UpdateConfig()
    { 
        
    }
}
