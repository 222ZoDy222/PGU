using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
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
            InitForm();
        }

        private ErrorUI error;

        private void InitForm()
        {
            panel2.Visible = false;
            error = new ErrorUI(ErrorLabel);
        }
        

        private const int minSizeArray = 2;
        private const int maxSizeArray = 15;

        private const int minElementSize = -127000;
        private const int maxElementSize = 127000;


        private int m_arraySize = -1;
        public int ArraySize
        {
            get => m_arraySize;

            private set
            {
                panel2.Visible = true;
                if (value < minSizeArray)
                {
                    // TODO: Введено значение меньше 15
                    error.SetError("Введено значение меньше 15");
                    m_arraySize = minSizeArray;
                }
                else if (value > maxSizeArray)
                {
                    // TODO: Введено значение больше 15
                    error.SetError("Введено значение больше 15");
                    m_arraySize = maxSizeArray;
                }
                else
                {
                    
                    m_arraySize = value;
                }

                if(m_arraySize <= 4)
                {
                    label3.Text = "элемента через пробел";
                }
                else
                {
                    label3.Text = "элементов через пробел";
                }
                label2.Text = m_arraySize.ToString();
                inputArraySize.Text = m_arraySize.ToString();
            }
        }


        private void inputArraySize_OnChanged()
        {
            ArrayInputField.Text = "";
            error.SetError(null);
            if (int.TryParse(inputArraySize.Text, out int sizeArray))
            {

                ArraySize = sizeArray;


            }
            else
            {
                panel2.Visible = false;
                // TODO: Введено неверное значение
                error.SetError("Введено неверное значение");
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
            if (!CheckArrayField())
            {
                return;
            }
            
            var array = GetArrayFromField();
            if (array == null) return;
            if(array.Count > ArraySize)
            {
                // Значений в массиве больше чем указано
                error.SetError("Значений в массиве больше чем указано");
                return;
            } else if(array.Count < ArraySize)
            {
                error.SetError("Значений в массиве меньше чем указано");
                return;
            }



        }






        private bool CheckArrayField()
        {
            var value = ArrayInputField.Text;

            // проверка на буквы
            for (int i = 0; i < value.Length; i++)
            {
                if (!char.IsDigit(value[i]) 
                    && value[i] != '.'
                     && value[i] != ' '
                     && value[i] != '-')
                {
                    if (char.IsLetter(value[i]))
                    {
                        // В массиве присутствуют буквы
                        error.SetError("В массиве присутствуют буквы");
                        return false;
                    }
                    else
                    {
                        // В массиве не верные элементы - value[i]
                        error.SetError($"В массиве не верные элементы - \"{value[i]}\"");
                        return false;
                    }
                        
                }
            }

            return true;
        }

        private List<double> GetArrayFromField()
        {
            var value = ArrayInputField.Text;

            var array = value.Split(' ');

            List<double> result = new List<double>();
            foreach(var el in array)
            {
                // проверка на длину элементов
                var elSide = el.Split('.');
                
                if(elSide.Length > 2)
                {
                    // почему-то 2 запятые
                    error.SetError("2 точки подряд");
                    return null;
                } 
                else
                {
                    if(elSide.Length == 1 && elSide[0] == "")
                    {
                        error.SetError("Лишний пробел");
                        return null;
                    }
                    if(elSide[0] == "")
                    {
                        // элемент баз числа (сразу с точки начинается)
                        error.SetError("элемент баз числа (сразу с точки начинается)");
                        return null;
                    }
                    for (int i = 0; i < elSide.Length; i++)
                    {
                        int countMinus = elSide[i].Split('-').Length - 1;
                        if(countMinus > 1)
                        {
                            error.SetError("Несколько минусов подряд");
                            return null;
                        }
                    }
                    int number = int.Parse(elSide[0]);
                    if (number > maxElementSize)
                    {
                        // Длина элемента больше максимальной
                        error.SetError("Длина элемента больше максимальной");
                        return null;
                    }
                    else if (number < minElementSize)
                    {
                        // Длина элемента меньше минимальной
                        error.SetError("Длина элемента меньше минимальной");
                        return null;
                    }
                    else
                    {
                        if (elSide.Length == 2)
                        {
                            if (elSide[1].Length >= 5)
                            {
                                error.SetError("Число после запятой слишком длинное");
                                return null;
                                // Число после запятой слишком длинное
                            } 
                        }


                        error.SetError(null);
                        // Всё хорошо
                    }
                }

                var element = double.Parse(el, System.Globalization.CultureInfo.InvariantCulture);
                result.Add(element);
            }

            return result;
        }

    }
}
