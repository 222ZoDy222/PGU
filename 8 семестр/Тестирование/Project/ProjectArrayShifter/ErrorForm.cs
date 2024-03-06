using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjectArrayShifter
{
    public partial class ErrorForm : Form
    {
        public ErrorForm()
        {
            InitializeComponent();
        }


        public void SetError(string msg)
        {            
            ErrorLabel.ForeColor = System.Drawing.Color.Red;
            ErrorLabel.Text = msg;
            Logger.Log(msg);
        }

    }
}
