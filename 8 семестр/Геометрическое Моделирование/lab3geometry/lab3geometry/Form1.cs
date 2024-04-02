using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System;
using System.Drawing;
using System.Windows.Forms;



namespace lab3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            drawer_ = new Drawer(this);
        }


        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            if(e.Button == MouseButtons.Left)
            {
                drawer_.DrawPoint(new Point(e.X, e.Y));
            }
            else if(e.Button == MouseButtons.Right)
            {
                drawer_.Reset();
            }

        }        
        private Drawer drawer_;

    }
}