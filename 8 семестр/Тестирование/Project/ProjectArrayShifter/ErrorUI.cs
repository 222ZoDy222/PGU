using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjectArrayShifter
{
    public class ErrorUI
    {

        private Label currentTextBox;

        


        public void SetError(string msg)
        {
            
            if (msg != null)
            {
                ErrorForm form = new ErrorForm();
                form.SetError(msg);
                form.ShowDialog();
            }
            
            
        }

        


    }
}
