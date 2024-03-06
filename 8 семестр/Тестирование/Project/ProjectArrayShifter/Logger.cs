using System;
using System.Collections.Generic;
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



        public void Log(string log)
        {

        }







    }
}
