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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        

        private const int minSizeArray = 2;
        private const int maxSizeArray = 15;


        private int m_arraySize = 2;
        public int ArraySize
        {
            get => m_arraySize;

            private set
            {
                if (value < minSizeArray)
                {
                    // TODO: Введено значение меньше 15
                    m_arraySize = minSizeArray;
                }
                else if (value > maxSizeArray)
                {
                    // TODO: Введено значение больше 15
                    m_arraySize = maxSizeArray;
                }
                else
                {
                    
                    m_arraySize = value;
                }

                inputArraySize.Text = m_arraySize.ToString();
            }
        }


        private void inputArraySize_OnChanged()
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

        
        

        private void button1_Click(object sender, EventArgs e)
        {
            inputArraySize_OnChanged();
        }

        /// <summary>
        /// Кнопка Сдвинуть
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button2_Click(object sender, EventArgs e)
        {
            ShiftArray();
        }


        private void ShiftArray()
        {
            // проверить верные ли значения в InputField
        }






        private bool CheckArrayField()
        {
            var value = ArrayInputField.Text;


        }

    }
}
