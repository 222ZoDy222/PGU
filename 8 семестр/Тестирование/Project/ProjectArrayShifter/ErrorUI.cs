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

        public ErrorUI(Label textBox)
        {
            currentTextBox = textBox;
            currentTextBox.Text = "";
        }


        public void SetError(string msg)
        {
            currentTextBox.Visible = (msg != null);
            if (msg != null)
            {
                currentTextBox.ForeColor = System.Drawing.Color.Red;
                currentTextBox.Text = msg;
            }
            
            
        }

        


    }
}
