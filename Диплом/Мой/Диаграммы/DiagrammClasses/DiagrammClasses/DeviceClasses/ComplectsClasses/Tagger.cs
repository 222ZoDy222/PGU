using System;
using System.Collections.Generic;
using System.Linq;

public class Tagger : Device
{
    

    public byte damage;        // Урон 
    public byte shotPower;   // Мощность выстрела 1-10

    
    public byte charge;     // заряд батареи


    public byte shotColor;          // Выстрел красным-1 или цвет команды-0
    public byte smartLed;           // Умная подсветка 0-выкл. 1-гор.цв.ком. 2- гор.при выстр. 3-уровень жизни
    public byte vibro;              // Вибро(0-нет 1-выстрел 2- событие)
    public byte weaponType;         // Ворон-0 Дельта-1      ****Тип
    public byte brightLed;          // Яркость подсветки(1-10)
    public byte volume;             // Громкость(1-10)
    public byte friendlyHit;        // Поражение от своих( 0- не попадает 1-попадает)
    public byte overHeat;           // флаг перегрева(0-не учитываем,1-идет перегрев)
    public byte startReload;        // флаг начала игры с перезарядки обоймы(1-не надо перезаряжать,0-надо)
    public byte autoReload;         // флаг авто перезарядки обоймы
    public byte realisticReload;    // флаг включения реальной смены обоймы(0-пеезаряд без вынемания обоймы)
    public byte secondHand;         // флаг разрешения применения второй руки 
    public byte semi_automatic;     // Флаг выбора полуавтоматической стрельбы (1-вкл,0-выкл)
    public UInt16 maxTemperature;   // Температура прекращения стрелбы при перегреве
    public UInt16 minTemperature;   // Температура разрешения стрелбы после перегреве
    public byte countSemiShots;     // Количество выстрелов в полуавтоматическом режиме
    public byte reloadTime;         // Задержка перезарядки в мс
    public byte clipsCount;         // Kоличество обойм 
    public byte bulletCount;        // Kоличество пуль в обойме
    public byte breakdownTime;      // Время поломки при попадании
    public byte disconnectTime;     // Время отключения от повязки при потере связи
    public UInt16 fireRate;         // Скорострельность (30-1200)
    public byte hitSensor;          // Датчик поражения - отсутствует, работает на поломку, работает на урон

    
    public bool HaveConfiguration;


    private HeadBand _currentBand;
    
    /// <summary>
    /// Повязка, к которой сейчас привязан этот тагер
    /// НЕЛЬЗЯ ПРИСВАИВАТЬ NULL (используй headband.DeleteTager() )
    /// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    /// </summary>
    public HeadBand currentBand 
    {
        get
        {
            return _currentBand;
        }
        set
        {
            
            _currentBand = value;
            
        }
    }

    private sbyte _connection = 100;
    public sbyte connection
    {
        get
        {
            return _connection;
        }
        set
        {

            _connection = value;
            if (_connection > 100) _connection = 100;
            else if (_connection < 0) _connection = 0;
            if (_connection == 0)
            {
                
                setError?.Invoke(true);
                if(currentBand != null)
                    currentBand.DeleteTager(this);
            }
            else
            {
                setError?.Invoke(false);
            }
        }
    }



    public delegate void TagerConnectionsDelegate(bool value);

    public TagerConnectionsDelegate setError;

    public Action onDelete;

    public Action onUpdate;



    private bool IsHeadbandListenMe()
    {
        for (int i = 0; i < currentBand.taggers.Count; i++)
        {
            if (currentBand.taggers[i] == this) return true;
        }
        return false;
    }

    public int GetTaggerIndex(uint uid)
    {
        for (int i = 0; i < currentBand.taggers.Count; i++)
        {
            if (currentBand.taggers[i].uid == uid) return i;
        }
        return -1;
    }

    public void UpdateConfig()
    {
        byte[] conf = this.config;

        if(conf == null)
        {
            HaveConfiguration = false;
            return;
        }

        #region fill
        this.damage = (byte)(conf[0] >> 4);
        this.shotPower = (byte)(conf[0] & 0x0f);        
        this.shotColor = (byte)(conf[1] >> 7);
        this.smartLed = (byte)(conf[1] >> 4 & 0x03);
        this.vibro = (byte)(conf[1] >> 2 & 0x03);        
        this.weaponType = (byte)(conf[2]);        
        this.brightLed = (byte)(conf[3] >> 4);
        this.volume = (byte)(conf[3] & 0x0f);
        this.hitSensor = (byte)(conf[4] >> 7 & 0x01);
        this.friendlyHit = (byte)(conf[4] >> 6 & 0x01);
        this.overHeat = (byte)(conf[4] >> 5 & 0x01);
        this.startReload = (byte)(conf[4] >> 4 & 0x01);
        this.autoReload = (byte)(conf[4] >> 3 & 0x01);
        this.realisticReload = (byte)(conf[4] >> 2 & 0x01);
        this.secondHand = (byte)(conf[4] >> 1 & 0x01);
        this.semi_automatic = (byte)(conf[4] & 0x01);
        
        this.maxTemperature = (ushort)((ushort)(conf[5] << 8 | conf[6]) & 0x1ff);
        this.minTemperature = (ushort)(conf[7] << 8 | conf[8]);

        this.charge = (byte)(conf[5] >> 4 & 0x0f);

        this.countSemiShots = (byte)(conf[9] >> 4);
        this.reloadTime = (byte)(conf[9] & 0x0f);
        
        this.clipsCount = conf[10];
        
        this.bulletCount = conf[11];
        
        this.breakdownTime = (byte)(conf[12] >> 4);
        this.disconnectTime = (byte)(conf[12] & 0x0f);
        
        this.fireRate = (ushort)(conf[13] << 8 | conf[14]);
        this.REVISION = (byte)(conf[15]);
        this.VERSION = (byte)(conf[16]);

        #endregion
        this.HaveConfiguration = true;
        onUpdate?.Invoke();



    }

    /// <summary>
    /// Возвращает есть ли таггер с таким uid в массиве tags
    /// </summary>
    public static bool HaveThisTagger(List<Tagger> tags, uint uid)
    {
        for (int i = 0; i < tags.Count; i++)
        {
            if (tags[i].uid == uid) return true;
        }

        return false;
    }

    public Tagger()
    {
        HaveConfiguration = false;
    }

    public Tagger(Device dev)
    {
        if (dev.config[0] != 1)
        {
            HaveConfiguration = false;
            return;

        }

        if (dev.config == null) return;

        this.config = dev.config;
        try
        {
            UpdateConfig();
        }
        catch
        {
            this.HaveConfiguration = false;
            return;
        }

        this.uid = dev.uid;
        this.HaveConfiguration = true;
        connection = 100;

    }




    public PresetConfiguration preset;



    public delegate void SelectConfig(bool flag);
    public SelectConfig selectConfig;

}