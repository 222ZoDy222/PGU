using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class HeadBand : Device
{



    private byte _team;              // Номер команды(цвет)
    public byte team
    {
        get => _team;

        set
        {
            if (value != _team)
            {
                _is_team_changed = true;
                _team = value;
            }
        }
    }
    public bool _is_team_changed = false;

    public UpdatePlayer onTeamUpdate;
    public byte invulnerability;    // Неуязвимость 0-10 сек шаг 0.1
    public byte shock;              // Шок(блокировка тагера) 0-10 сек шаг 0.1  (0-100)
    public byte timerLightingDeath; // Время отключения сигнала смерти(таймер откл подсвтки) 0-60 сек
    public byte life;               // Жизнь 1-100
    public UInt16 health;           // Здоровье 0-999
    public byte armor;            // Броня 0-255
    public byte armorChance;        // Броня ,шанс попадания 0-100(10 делений)
    public byte autoReliveSec;      // Авто воскрешение,сек 0-59
    public byte autoReliveMin;      // Авто воскрешение,мин 0-255
    public byte regenerationSec;    // Авто восстановление, время (регенирация),сек 0-59
    public byte regenerationMin;    // Авто восстановление, время (регенирация),мин 0-255
    public byte regenerationValue;  // Авто восстановление, значение (регенирация)  0-100
    public byte bleedingSec;        // Кровотечени,время,сек 0-59
    public byte bleedingMin;        // Кровотечени,время,мин 0-255
    public byte bleedingValue;      // Кровотечение,значение ( включать при уроне более 50ед) 0-100
    public byte brighLed;           // Яркость светодиодов на повязке 0-255
    public byte startDelay;         // Задержка после старта до активации тагера 0-60 сек
    public byte backLight;          // Фоновое свечение 0-10
    public byte disconnectDevicesAfterDeath;// Отвязывать все устройства после смерти 0-1
    public byte indicateInvertion;  // Инверсия индикации 0-1
    public byte friendlyHit;        // Поражение от своих( 0- не попадает 1-попадает)   передать на тагер при новом подключении 0-1
    public byte vibro;              // Вибро 0-1
    public byte vibroZonality;      // Зональность вибро
    public byte pauseDelay;         // Время задержки после выхода из паузы
    public byte maxCountTaggers;    // количество подвязываемого оружия 1-5

    public byte restoreClipsByKits; // Пополнение обойм с помощью аптечки

    /// <summary>
    /// Есть ли у повязки параметр пополнения обойм от аптечки
    /// </summary>
    public bool CanRestoreClips
    {
        get
        {
            if ((this.REVISION == 2 && this.VERSION >= 5)
                || (this.REVISION > 2)
                ||
                (this.REVISION == 1 && this.VERSION >= 5))
            {
                return true;
            }
            return false;
        }
    }

    

    public byte admin_id; // ID администратора

    

    public byte charge = 100;             // Заряд батареи 

    public byte type;


    private bool m_haveConfiguration;
    // Если ли конфигурация у повязки
    public bool HaveConfiguration
    {
        get => m_haveConfiguration;
        set
        {
            m_haveConfiguration = value;
            if(!m_haveConfiguration)
            {
                connection = 0;
            }
            
        }
    }
    

    // Статус повязки (В игре, на паузе, мертв ...)
    public Status status;


    private sbyte _connection;
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
            if(_connection == 0)
            {
                setError?.Invoke(true);
            }
            else
            {
                setError?.Invoke(false);
            }
        }
    }

    public PresetConfiguration preset;
    
    
    public HeadBand()
    {
        
        
        
    }

    public HeadBand(Device dev)
    {
        this.uid = dev.uid;
        
        if (dev.config[0] != 1)
        {
            HaveConfiguration = false;
            return;
            
        }

        if (dev.config == null) return;

        this.config = dev.config;
        dev.onUpdate += UpdateConfig;

        UpdateConfig();

        
        this.HaveConfiguration = true;
        connection = 100;


        


    }


    public void SetConfig(HeadBand band)
    {
        this.config = band.config;
        UpdateConfig();
    }

    public void UpdateConfig()
    {
        byte[] conf = this.config;

        

        parityBit = true;
        status = Status.NULL;

        #region fill Headband configuration 

        this.type = (byte)(conf[0]);

        // Если это НЕ повязка 
        if (type != 1)
        {
            UnityEngine.Debug.LogError("Почему-то не повязка");
            return;
        }
        try
        {

            this.REVISION = conf[22];
            this.VERSION = conf[23];

            this.team = (byte)(conf[1] >> 6);
            this.timerLightingDeath = (byte)(conf[1] & 0x3f);

            this.disconnectDevicesAfterDeath = (byte)(conf[2] >> 7);
            this.invulnerability = (byte)(conf[2] & 0x7f);

            this.indicateInvertion = (byte)(conf[3] >> 7);
            this.shock = (byte)(conf[3] & 0x7f);

            this.friendlyHit = (byte)(conf[4] >> 7);
            this.life = (byte)(conf[4] & 0x7f);

            this.health = (ushort)(((conf[5] & 0x0f) << 8) | (conf[6]));

            if (CanRestoreClips)
            {
                this.restoreClipsByKits = (byte)(conf[7] >> 7);
            }
           

            this.armor = (byte)(conf[8]);

            this.armorChance = (byte)(conf[9] >> 4);
            this.backLight = (byte)(conf[9] & 0xf);

            this.vibro = (byte)(conf[10] >> 7);
            this.autoReliveSec = (byte)(conf[10] & 0x7f);

            this.autoReliveMin = (byte)(conf[11]);
            this.regenerationSec = (byte)(conf[12] & 0x7f);
            this.vibroZonality = (byte)(conf[12] >> 7);
            this.regenerationMin = conf[13];
            this.regenerationValue = conf[14];
            this.bleedingSec = conf[15];
            this.bleedingMin = conf[16];
            this.bleedingValue = conf[17];
            this.brighLed = conf[18];
            this.startDelay = conf[19];
            this.pauseDelay = conf[20];
            this.maxCountTaggers = conf[21];

            //UnityEngine.Debug.Log("Версия прошивки - " + this.firmwareVersion);

            this.id = conf[24];

            // Если ревизия и версия без id администратора 
            if(this.REVISION == 1 && this.VERSION <= 2)
            {
                this.admin_id = this.id;
            } 
            else
            {
                if(conf.Length >= 26)
                {
                    this.admin_id = conf[25];
                }                
            }

            //UnityEngine.Debug.Log($"band uid - {band.uid} revision - {band.revisionVersion} version - {band.firmwareVersion}");


            this.charge = (byte)(conf[5] >> 4);

            this.HaveConfiguration = true;


        } catch(Exception ex)
        {
            UnityEngine.Debug.LogError(ex.Message);
        }



        #endregion

        additionalParameters.configurationFails = 0;

        OnHeadbandUpdate?.Invoke();


        

    }


    public delegate void UpdatePlayer();

    private List<Tagger> _taggers = new List<Tagger>();
    
    public List<Tagger> taggers
    {
        get
        {
            return _taggers;
        }

        set
        {
            if(value == null)
            {
                UnityEngine.Debug.LogError("Taggers is null");
                return;
            }
            _taggers = value;
            updateTaggers?.Invoke();

        }
    }

    /// <summary>
    /// Видит эти тагеры на данный момент
    /// </summary>
    /// <param name="tags"></param>
    public void SeeTaggers(List<Tagger> tags, sbyte connectionValue = 25)
    {

        // Всем тагерам connection - 5
        try
        {
            for (int i = 0; i < taggers.Count; i++)
            {
                taggers[i].connection -= connectionValue;
            }
            
        } catch(Exception ex)
        {
            UnityEngine.Debug.Log(ex);
        }
        
        // Если тагеры вообще не видит сейчас, значит просто всем тагерам -5 и выходим
        if (tags == null || tags.Count == 0)
        {
            CheckForConnectionTaggers();
            return;
        }

        // Всем тагерам, которые видны сейчас connection + 5
        foreach(var newTag in tags)
        {
            bool haveTagger = false;
            foreach(var tag in taggers)
            {
                // Если этот тагер был
                if(newTag.uid == tag.uid)
                {
                    tag.connection += connectionValue;
                    tag.config = newTag.config;
                    tag.UpdateConfig();
                    haveTagger = true;
                    break;
                }

            }
            // Если тагер уже есть, продолжаем проверку
            if (haveTagger) continue;

            // Если новый тагер
            AddTagger(newTag);
        }

        
    }

    /// <summary>
    /// Проверить тагеры, если connection тагера = 0, то удалить его
    /// </summary>
    public void CheckForConnectionTaggers()
    {
        if (taggers == null) return;
        for (int i = 0; i < taggers.Count; i++)
        {
            if(taggers[i].connection == 0)
            {
                DeleteTager(taggers[i]);
                i--;
            }
        }
    }

    /// <summary>
    /// Просто добавляет тагер в массив к повязкам тагера
    /// и обновляет UI
    /// </summary>
    /// <param name="tag"></param>
    public void AddTagger(Tagger tag)
    {
        int index = HaveThisTagger(tag.uid);
        // Если тагер с таким UID уже есть
        if (index != -1)
        {
            taggers[index].config = tag.config;
            taggers[index].UpdateConfig();
            tag = taggers[index];
            return;
        }

        // Если этого тагера еще нет
        tag.onUpdate += () => updateTaggers?.Invoke();
        tag.UpdateConfig();
        tag.currentBand = this;
        taggers.Add(tag);
        updateTaggers?.Invoke();

        TaggerAdder.instance.AddAllTaggers(tag);

    }

    public UpdatePlayer updateTaggers;

    
    public UpdatePlayer OnHeadbandUpdate;

    public delegate void SelectConfig(bool flag);
    public SelectConfig selectConfig;

    /// <summary>
    /// Вызывается когда не пришел конфиг с повязки
    /// </summary>
    public SelectConfig setError;

    

    /// <summary>
    /// Возвращает -1 если такого тагера нет или индекс, по которому он лежит
    /// </summary>
    /// <param name="tagUID"></param>
    /// <returns></returns>
    public int HaveThisTagger(uint tagUID)
    {
        for (int i = 0; i < taggers.Count; i++)
        {
            if (taggers[i].uid == tagUID) return i;
        }
        return -1;
    }

    public Tagger GetTagger(uint tagUID)
    {
        for (int i = 0; i < taggers.Count; i++)
        {
            if (taggers[i].uid == tagUID) return taggers[i];
        }
        return null;
    }

    /// <summary>
    /// Дополнительные параметры взаимодействия повязки с ПО
    /// </summary>
    public AdditionalParameters additionalParameters = new AdditionalParameters();


    public class AdditionalParameters
    {

        private int m_configurationFails = 0;

        /// <summary>
        /// Кол-во раз, когда конфигурация не пришла на повязку
        /// используется в конфигураторе, для удаления повязки
        /// </summary>
        public int configurationFails
        {
            get => m_configurationFails;

            set
            {
                m_configurationFails = value;
            }
        }

    }


    public void DeleteTager(Tagger tag)
    {
        int index = HaveThisTagger(tag.uid);
        if (index == -1) return;

        tag.onUpdate -= () => updateTaggers?.Invoke();
        taggers[index].onDelete?.Invoke();
        taggers[index].currentBand = null;
        taggers.RemoveAt(index);
        updateTaggers?.Invoke();
        TaggerConfiguration.instance.DeleteSelected(tag);
        TaggerAdder.instance.UpdateTaggers();
        TaggerAdder.instance.DeleteAllTagger(tag);



    }

    public Action onDelete;

    public void Delete()
    {
        onDelete?.Invoke();
        HeadbandsAdder.instance.DeleteHeadband(this);
        Gameplay.instance.DeletePlayerFromGame(this);
        TaggerAdder.instance.UpdateAllTaggers();
    }


    /// <summary>
    /// Выключить повязку 
    /// callback возвращает выключилась она или нет
    /// </summary>
    /// <param name="callback"></param>
    public void Off(Action<bool> callback, bool withTaggers = true)
    {
        HeadbandHandler.instance.DeleteHeadband(this, withTaggers, callback, true);
    }



    public HeadbandUI bandUI;


    public Action onIndicate;

}




/// <summary>
/// Статусы, которые могут быть у повязки
/// </summary>
public enum Status
{
    /// <summary>
    /// Потерял связь
    /// </summary>
    CONNECTION_LOST = -2,

    /// <summary>
    /// Неизвестный статус
    /// </summary>
    NULL = -1,

    Setting = 0,
    Game = 1,
    Pause = 2,
    Dead = 3,
    UnPause = 4,
    Stop = 5,
    End = 6,

}

