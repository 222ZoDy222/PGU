using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab1.Menues
{
    public class MenuUI
    {

        public GroupBox currentGroup { get; protected set; }

        



        public void Hide()
        {
            currentGroup.Visible = false;
        }

        public void Show()
        {
            currentGroup.Visible = true;
        }



    }
}
