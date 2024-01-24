using System;
using System.IO.Ports;

public class Radiobase
{

    public string name;

    public SerialPort serialPort;

    public UInt32 uid;

    /// <summary>
    /// Врятли возможно сделать, так что оно всегда 0
    /// </summary>
    public UInt16 mileage;

    public byte revision;
    public byte version;


    public byte frequency
    {
        get => m_frequency;
        set
        {
            m_frequency = value;
            onUpdate?.Invoke();
        }
    }
    private byte m_frequency = 0;


    public void FillNull()
    {
        uid = 0;
        mileage = 0;
        revision = 0;
        version = 0;
        name = null;
    }

    public void FillValues(byte[] conf)
    {
        uid = (UInt32)(conf[0] << 24 | conf[1] << 16 | conf[2] << 8 | conf[3]);

        revision = conf[4];
        version = conf[5];

        mileage = (UInt16)(conf[6] << 8 | conf[7]);

        onUpdate?.Invoke();
    }


    public bool HaveFrequency
    {
        get
        {
            if (version == 0) return false;
            return true;
        }
    }

    public Action onUpdate;


}
