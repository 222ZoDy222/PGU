using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Lab1.ParametersUI;
using Lab1.Menues;
namespace Lab1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            InitMenues();
        }


        private InputMenu inputMenu;

        private void InitMenues()
        {
            inputMenu = new InputMenu(InputGroup);
            inputMenu.Show();
        }


        private const int minSizeArray = 2;
        private const int maxSizeArray = 15;


        private int m_arraySize = 2;
        public int ArraySize
        {
            get => m_arraySize;

            private set
            {
                if (value < minSizeArray) m_arraySize = minSizeArray;
                else if (value > maxSizeArray) m_arraySize = maxSizeArray;
                else
                {
                    m_arraySize = value;
                }

                inputArraySize.Text = m_arraySize.ToString();
            }
        }


        private void inputArraySize_OnChanged(object sender, EventArgs e)
        {
            
            if (int.TryParse(inputArraySize.Text, out int sizeArray))
            {

                ArraySize = sizeArray;


            }
            else
            {
                // TODO: Введено неверное значение
                inputArraySize.Text = "";
            }
        }

        private void inputArraySize_TextChanged(object sender, EventArgs e)
        {



            

        }


        private void inputArraySize_KeyPress(object sender, KeyPressEventArgs e)
        {
            
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }

        }


    }
}
