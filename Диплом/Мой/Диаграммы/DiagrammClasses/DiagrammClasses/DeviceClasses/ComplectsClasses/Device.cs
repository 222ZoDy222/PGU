using System;

public class Device 
{
    public UInt32 uid;

    public string UID8X { get => uid.ToString("X8"); }

    public byte[] config
    {
        get
        {
            return m_config;
        }

        set
        {
            if(m_config != null)
            {
                prevConfig = new byte[m_config.Length];
                m_config.CopyTo(prevConfig, 0);
                
                
            }
            
            

            m_config = value;

        }
    }


    protected byte[] m_config;

    protected byte[] prevConfig;

    /// <summary>
    /// ID девайса - есть у повязок и доп устройств
    /// Если нет конфигурации и по умолчанию = 0
    /// </summary>
    public byte id;

    /// <summary>
    /// Бит четности, изменяется при получении статистики
    /// Есть у повязок и доп устройств
    /// </summary>
    public bool parityBit;


    public byte VERSION;    // Версия прошивки
    public byte REVISION;    // Ревизия платы


    public Action onUpdate;
   
}
