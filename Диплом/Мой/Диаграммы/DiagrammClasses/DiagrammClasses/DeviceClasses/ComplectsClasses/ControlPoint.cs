using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class ControlPoint : AdditionalDevice
{


    

    public byte team;                           // ����� �������(����) � ������� ����������� �����
    public byte f_friendly_fire;                // ���� ��������� ����� ������� 0 - 1
    public UInt16[] hits = new UInt16[4];           // ���������� ��������� �� ������ �������(����) 1 - 999
    public byte[] hold_time_min = new byte[4];  // ����� ��������� ��� ������ ������� ��� 0 - 255
    public byte[] hold_time_sec = new byte[4];  // ������� 0 - 60  
    public byte period_radiation_min;           // ������ ��������� ��������� ������ 0 - 255
    public byte period_radiation_sec;           // ������ ��������� ��������� ������� 0 - 60
    public byte period_radiation_val;           // ���� ��������� ��������� 1 - 100  
    public byte scenario = 255;                 // �������� �� �������� �������� 1 - 15
    public byte immunity;                       // ������������ 0-10 ��� ��� 0.1 (100)
    public byte bright_led;                     // ������������ ������� ����������� 0 - 255
    public byte powershot;                      // �������� �������� 1 - 10

    public byte hitMode;                        // ����� ����� ��������� - ����/���������
    public bool HaveHitMode
    {
        //REVISION = 200;
        //VERSION = 0;
        get
        {
            if (VERSION == 0 && REVISION == 200) return false;
            return true;
        }
    }

    public byte type;

    public byte charge;                         // ����� ������� 0-10


    public ControlPoint(Device dev)
    {
        
        this.uid = dev.uid;
        this.config = dev.config;
        Saver.AdditionalNameSaver.LoadName(this);
        this.onUpdate += UpdateConfig;
        this.statsCheck = new StatsCheck();
        UpdateConfig();


    }

    public Action onConfigUpdate;


    

    public void UpdateConfig()
    {
        byte[] conf = this.config;

       
        status = Status.NULL;


        #region fill CP configuration 

        this.type = (byte)(conf[0]);

        this.team = (byte)(conf[1] >> 6);

        this.f_friendly_fire = (byte)((conf[1] >> 5) & 0x01);

        this.charge = (byte)((conf[1]) & 0x0f);

        
        this.hits[0] = (ushort)(((conf[2] & 0x03) << 8) | (conf[3]));
        this.hits[1] = (ushort)(((conf[4] & 0x03) << 8) | (conf[5]));
        this.hits[2] = (ushort)(((conf[6] & 0x03) << 8) | (conf[7]));
        this.hits[3] = (ushort)(((conf[8] & 0x03) << 8) | (conf[9]));


        this.hold_time_sec[0] = (byte)(conf[2] >> 2);
        this.hold_time_sec[1] = (byte)(conf[4] >> 2);
        this.hold_time_sec[2] = (byte)(conf[6] >> 2);
        this.hold_time_sec[3] = (byte)(conf[8] >> 2);

        this.hold_time_min[0] = (byte)(conf[10]);
        this.hold_time_min[1] = (byte)(conf[11]);
        this.hold_time_min[2] = (byte)(conf[12]);
        this.hold_time_min[3] = (byte)(conf[13]);

        this.period_radiation_min = (byte)(conf[14]);
        this.period_radiation_sec = (byte)(conf[15] & 0x3F);
        this.period_radiation_val = (byte)(conf[16]);

        

        byte oldScenario = this.scenario;
        
        this.scenario = (byte)(conf[17] & 0x0f);
        //if (oldScenario != scenario) onConfigUpdate?.Invoke();

        this.powershot = (byte)(conf[17] >> 4);

        this.immunity = (byte)(conf[18]);
        this.bright_led = (byte)(conf[19]);
        this.id = conf[20];

        if(conf.Length == 22)
        {
            REVISION = 200;
            VERSION = 0;
        }
        // 15.12.2023 ��������� ����� ������� �������� �� ����� �����
        // ������� ��� ����, ����� ������ ������ ������ ���� ��������
        if (conf.Length >= 26)
        {
            this.hitMode = (byte)((conf[15] >> 6) & 0x01);
            REVISION = (byte)(conf[21]);
            VERSION = (byte)(conf[22]);
        }


        // ���� ������ ���������
        if (prevConfig == null)
        {
            onConfigUpdate?.Invoke();
        }
        else
        {
            if (!prevConfig.SequenceEqual(conf)) onConfigUpdate?.Invoke();
        }



        #endregion





    }

    public ControlPointGame gamePoint;

}
