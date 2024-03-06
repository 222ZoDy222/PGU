using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
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

        /// <summary>
        /// 1 МБ
        /// </summary>
        public const int MAX_FILE_SIZE = 1000000;

        private void InitForm()
        {
            panel2.Visible = false;
            error = new ErrorUI();
            this.AllowDrop = true;
            this.DragEnter += new DragEventHandler(Form1_DragEnter);
            this.DragDrop += new DragEventHandler(Form1_DragDrop);
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
                    error.SetError("Введено значение меньше 15, оно было изменено");
                    m_arraySize = minSizeArray;
                }
                else if (value > maxSizeArray)
                {
                    // TODO: Введено значение больше 15
                    error.SetError("Введено значение больше 15, оно было изменено");
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
                panel2.Visible = true;
            }
        }


        
        public string ArrayInput
        {
            get => ArrayInputField.Text;

            set
            {
                ArrayInputField.Text = value;
                if(value == "")
                {
                    button2.Visible = false;
                }
                else
                {
                    button2.Visible = true;
                }
            }


        }

        private bool inputArraySize_OnChanged()
        {
            ArrayInput = "";
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
                return false;
            }
            return true;
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
            shift(array);


        }



        private void shift(List<double> array) 
        {
            List<double> newArray = new List<double>();
            newArray.Add(0);
            newArray.AddRange(array);
            newArray.RemoveAt(newArray.Count - 1);


            string stringArray = "";
            foreach(var val in newArray)
            {
                stringArray += val + " ";
            }



            ResultForm resultForm = new ResultForm();
            resultForm.SetResult(stringArray);
            resultForm.ShowDialog();

        }

        public void TextArraySizeChanged(object sender, EventArgs e)
        {

            panel2.Visible = false;            
            error.SetError(null);
            
        }



        private bool CheckArrayField()
        {
            var value = ArrayInput;

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
                    int number = 0;
                    try
                    {
                        number = int.Parse(elSide[0]);
                    }
                    catch
                    {
                        error.SetError($"Неверный символ {elSide[0]}");
                        return null;
                    }
                    
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

        private void button1_Click_1(object sender, EventArgs e)
        {
            Open_File();
        }


        private void Open_File()
        {
            var fileContent = string.Empty;
            var filePath = string.Empty;

            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "c:\\";
                openFileDialog.Filter = "txt files (*.txt)|*.txt";
                openFileDialog.FilterIndex = 2;
                openFileDialog.RestoreDirectory = true;

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    //Get the path of specified file
                    filePath = openFileDialog.FileName;

                    //Read the contents of the file into a stream
                    var fileStream = openFileDialog.OpenFile();

                    using (StreamReader reader = new StreamReader(fileStream))
                    {
                        try
                        {
                            fileContent = reader.ReadToEnd();
                            CheckFromFile(fileContent);
                        } 
                        catch(Exception ex) when (ex is OutOfMemoryException)
                        {
                            error.SetError("Слишком большой файл");
                        }
                        catch
                        {
                            error.SetError("ошибка чтения файла");
                        }
                        
                    }
                }
            }

        }


        private void CheckFromFile(string fileValue)
        {
            fileValue.Replace("\r", string.Empty);
            var fileSplitter = fileValue.Split('\n');
            if (fileSplitter.Length == 1)
            {
                error.SetError("Не хватает строк в файле");
            } 
            else if(fileSplitter.Length > 2)
            {
                error.SetError("Слишком много строк в файле");
            }
            else if(fileSplitter.Length == 2)
            {
                inputArraySize.Text = fileSplitter[0];
                if (inputArraySize_OnChanged())
                {
                    ArrayInput = fileSplitter[1];
                    ShiftArray();
                }
                
            }
            else
            {
                error.SetError("Ошибка кол-ва строк в файле");
            }
            
        }

        private void OnArrayFieldChanged(object sender, EventArgs e)
        {
            var textBox = sender as TextBox;
            if(textBox != null)
            {
                ArrayInput = textBox.Text;
            }
        }



        void Form1_DragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop)) e.Effect = DragDropEffects.Copy;
        }

        void Form1_DragDrop(object sender, DragEventArgs e)
        {
            string[] files = (string[])e.Data.GetData(DataFormats.FileDrop);
            if(files.Length == 1)
            {
                if (File.Exists(files[0]))
                {
                    System.IO.FileInfo file = new System.IO.FileInfo(files[0]);
                    if (file.Length <= MAX_FILE_SIZE)
                    {
                        if(file.Extension == ".txt")
                        {
                            var fileResult = File.ReadAllText(files[0]);
                            CheckFromFile(fileResult);
                        }
                        else
                        {
                            error.SetError("не верный тип файла");
                        }
                        
                    }
                    else
                    {
                        error.SetError("Файл слишком большой");
                    }
                    
                }
                else if (Directory.Exists(files[0]))
                {
                    error.SetError("ЭТО ПАПКА!");
                }
                else
                {
                    error.SetError("Ошибка чтения");
                    
                }
                
                
                
            }
            else 
            {
                error.SetError("Неверное кол-во файлов");
            }
            
        }


        private void Random()
        {
            //Создание объекта для генерации чисел
            Random rnd = new Random();

            //Получить случайное число (в диапазоне от 0 до 10)
            int SizeArray = rnd.Next(minSizeArray, maxSizeArray);

            string stringArray = "";
            List<double> array = new List<double>();
            for (int i = 0; i < SizeArray; i++)
            {
                var val = GetRandomDouble(rnd, minElementSize, maxElementSize);
                array.Add(val);
                stringArray += val.ToString(System.Globalization.CultureInfo.InvariantCulture) + " ";
            }

            inputArraySize.Text = SizeArray.ToString();
            stringArray = stringArray.Remove(stringArray.Length - 1);


            if (inputArraySize_OnChanged())
            {
                ArrayInput = stringArray;
                ShiftArray();
            }

        }


        double GetRandomDouble(Random random, double min, double max)
        {
            return Math.Round(min + (random.NextDouble() * (max - min)),3);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Random();
        }
    }
}
