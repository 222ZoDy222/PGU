using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectArrayShifter
{
    class Logger
    {


        private static Logger m_instance;
        public static Logger instance
        {
            get
            {
                if (m_instance == null) m_instance = new Logger();
                return m_instance;
            }
        }

        public static void Log(string log)
        {
            instance.Log_(log);
        }

        public void Log_(string log)
        {
            var baseDir = AppDomain.CurrentDomain.BaseDirectory;
            var todayFolder = DateTime.Now.ToString("d").Replace(".", "-");
            var folderDir = Path.Combine(baseDir, "Logs", todayFolder);
            if (!Directory.Exists(folderDir))
            {
                Directory.CreateDirectory(folderDir);
            }
            string fileName = DateTime.Now.ToString("T").Replace(":", "-") + ".txt";
            string filePath = Path.Combine(folderDir, fileName);

            if (File.Exists(filePath))
            {
                var fileData = File.ReadAllText(filePath);
                fileData += "\n" + log;
                log = fileData;
            }

            File.WriteAllText(filePath, log);

        }

        private void CheckDir()
        {

        }





    }
}
