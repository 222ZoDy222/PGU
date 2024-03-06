using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project1_Lagrange_Naydanov_I
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        //Структура для хранения координат одной точки
        public struct Point
        {
            public double x;
            public double y;

            //Конструктор:
            public Point(double xIn, double yIn)
            {
                x = xIn;
                y = yIn;
            }
        }

        const int border = 1000000; //Максимальный Х, с которым может работать программа
        const double low = 1E-5;   //Минимальный Х, с которым может работать программа (для сравнения вещественных чисел)

        private List<Point> Calc_Lagrange(List<Point> point)//Вычисление функции Лагранжа
        {
            List<Point> lagrange = new List<Point>();

            //Установим максимум/минимум для X
            double minX = border;
            double maxX = -border;

            //Вычисляем область определения, на которой будем строить график:
            for (int i = 0; i < point.Count; i++)
            {
                if (point[i].x > maxX) maxX = point[i].x;
                if (point[i].x < minX) minX = point[i].x;
            }

            //Работа с БАЗИСНЫМ полиномом:
            for (int X = Convert.ToInt32(minX); X <= Convert.ToInt32(maxX); X++)
            {
                double Y = 0.0;
                for (int i = 0; i < point.Count; i++)
                {
                    //Вычисляем х для базисного полинома
                    double basis = 1.0;
                    for (int j = 0; j < point.Count; j++)
                        if (j != i)
                            basis *= (X - point[j].x) / (point[i].x - point[j].x);
                    //Вычисляем y
                    Y += basis * point[i].y;
                }

                //Записываем координаты полученной точки в массив
                Point current = new Point(X, Y);
                lagrange.Add(current);
            }
            return lagrange;
        }

        private List<Point> DgvIntoList(DataGridView dgv) //Превращает таблицу dgv в список точек
        {
            List<double> X = new List<double>();
            for (int k = 0; k < dgv.Rows.Count - 1; k++)
            {
                double current = Convert.ToDouble(dgv[0, k].Value.ToString());
                if (X.Contains(current)) { MessageBox.Show("Абсциссы не должны повторяться! Исправьте строку номер " + (k + 1)); return new List<Point>(); }
                X.Add(current);
            }


            //Вычисляем количество точек и выделяем под них память в массиве:
            int pointsNumber = dgv.Rows.Count - 1;
            List<Point> point = new List<Point>();


            int i = 0;
            //Проходим по таблице, заполняя массив точек:
            try
            {
                for (i = 0; i < pointsNumber; i++)
                {
                    double x = Convert.ToDouble(dgv[0, i].Value.ToString());
                    double y = Convert.ToDouble(dgv[1, i].Value.ToString());
                    Point temp = new Point(x, y);
                    point.Add(temp);
                }
            }
            catch { MessageBox.Show("В строке номер " + (i + 1) + " данные введены неправильно"); }

            return point; //Возвращаем массив
        }

        //Кнопки:
        #region
        private void buttonFuncPrint_Click(object sender, EventArgs e) //"В полном размере"
        {
            ClearBox();

            List<Point> point = DgvIntoList(dgvCoords);    //Создаём массив точек на основе таблицы

            List<Point> address = new List<Point>();
            for (int i = 0; i < point.Count; i++)
                address.Add(point[i]);

            double koeff = countResizeKoeff(point);
            Resize(ref point, koeff); //Меняем их размер в соответствии с экраном 
            ReverseY(ref point);

            List<Point> lagrange = Calc_Lagrange(point);    //Создаём массив точек полинома Лагранжа
            
            //Смещаем массив lagrange к началу координат относительно собственных min/max и рисуем график:
            MoveToBegin(lagrange, point); PlusXY(lagrange, 0, 80);

            //Смещаем массив point к началу координат относительно min/max:
            MoveToBegin(point, point); PlusXY(point,0,80);
            Draw_Points(point, address);

            Draw_Poly(lagrange); //Рисуем график
        }

        private void buttonFuncInCoord_Click(object sender, EventArgs e) //"В системе координат"
        {
            ClearBox();

            List<Point> point = DgvIntoList(dgvCoords);    //Создаём массив точек на основе таблицы

            List<Point> address = new List<Point>();
            for (int i = 0; i < point.Count; i++)
                address.Add(point[i]);

            double koeff = countResizeKoeffWithZero(point);
            koeff *= 0.55;
            Resize(ref point, koeff); //Меняем их размер в соответствии с экраном 
            ReverseY(ref point);


            // Определяем длину и ширину холста
            double w = funcPrinterBox.Size.Width, h = funcPrinterBox.Size.Height;
            PlusXY(point, w / 2, h / 2);

            List<Point> lagrange = Calc_Lagrange(point);    //Создаём массив точек полинома Лагранжа (столько же)

            DrawXY();

            //Смещаем массив point относительно min/max в lagrange и рисуем точки:

            Draw_Points(point, address);

            //Смещаем массив lagrange относительно собственных min/max и рисуем график:
            Draw_Poly(lagrange); //Строим точки полинома Лагранжа
        }

        private void buttonClear_Click(object sender, EventArgs e) //Очистить таблицу
        {
            dgvCoords.Rows.Clear();
        }
        #endregion

        //Коэффициенты:
        #region
        private double countResizeKoeff(List<Point> point)
        {
            double minX, minY, maxX, maxY;
            FindMaxMin(point, out minX, out minY, out maxX, out maxY);
            // Определяем длину и ширину холста
            double w = funcPrinterBox.Size.Width, h = funcPrinterBox.Size.Height;

            // Вычисляем коэффициент масштабирования
            double Sx = w / (maxX - minX), Sy = h / (maxY - minY);

            double S = Sx; if (Sy < S) S = Sy;
            if (S > 99999999) S = 0;

            S *= 0.8;

            return S;
        }

        private double countResizeKoeffWithZero(List<Point> point)
        {
            double minX, minY, maxX, maxY;
            FindMaxMin(point, out minX, out minY, out maxX, out maxY);
            // Определяем длину и ширину холста
            double w = funcPrinterBox.Size.Width, h = funcPrinterBox.Size.Height;

            if (minY > 0) minY = 0;
            if (minX > 0) minX = 0;


            // Вычисляем коэффициент масштабирования
            double Sx = w / (maxX - minX), Sy = h / (maxY - minY);

            double S = Sx; if (Sy < S) S = Sy;
            if (S > 99999999) S = 0;

            S *= 0.8;

            return S;
        }
        #endregion

        //Координаты:
        #region
        private void FindMaxMin(List<Point> point, out double minX, out double minY, out double maxX, out double maxY)
        {
            //Вычисляем область определения и область значений полинома Лангранжа
            minX = border;
            maxX = -border;
            minY = border;
            maxY = -border;

            for (int i = 0; i < point.Count; i++)
            {
                if (point[i].x + low < minX) minX = point[i].x;
                if (point[i].y + low < minY) minY = point[i].y;
                if (point[i].x > maxX + low) maxX = point[i].x;
                if (point[i].y > maxY + low) maxY = point[i].y;
            }
        }

        private void ReverseY(ref List<Point> point) //Делаем Y отрицательным (нужно для корректного построения графика)
        {
            for (int i = 0; i < point.Count; i++)
            {
                Point tmp;
                tmp.x = point[i].x;
                tmp.y = -point[i].y;
                point[i] = tmp;
            }
        }

        private void PlusXY(List<Point> point, double X, double Y) //Прибавляет заданную величину к координатам X и Y
        {
            for (int i = 0; i < point.Count; i++)
            {
                Point tmp;
                tmp.x = point[i].x+X;
                tmp.y = point[i].y+Y;
                point[i] = tmp;
            }
        }
        
        private void MoveToBegin(List<Point> point, List<Point> point2) //Сместить координаты точек так, чтобы они влезали в picturebox
        {
            double minX, minY, maxX, maxY;
            FindMaxMin(point2, out minX, out minY, out maxX, out maxY);

            //Смещаем начало системы координат к самой левой верхней точке
            for (int i = 0; i < point.Count; i++)
            {
                Point tmp;
                tmp.x = point[i].x - minX;
                tmp.y = point[i].y - minY;
                point[i] = tmp;
            }
        }

        private new void Resize(ref List<Point> a, double koeff) //Умножение всех координат на коэффициент
        {
            for (int i = 0; i < a.Count; i++)
            {
                Point tmp;
                tmp.x = a[i].x * koeff;
                tmp.y = a[i].y * koeff;
                a[i] = tmp;
            }
        }
        #endregion

        //Рисование:
        #region
        private void Draw_Points(List<Point> point, List<Point> address) //Функция рисования ключевых точек
        {
            Graphics g = Graphics.FromHwnd(funcPrinterBox.Handle);
            for (int i = 0; i < point.Count; i++) // Проходим по массиву ключевых точек
            {
                String drawString = "[" + Convert.ToString(address[i].x) + ";" + Convert.ToString(address[i].y) + "]"; // Составляем строку для отображения координат ключевой точки рядом с ней на плоскости

                g.FillEllipse(Brushes.Black, Convert.ToInt32(point[i].x - 3), Convert.ToInt32(point[i].y - 3), 5, 5); // Рисуем точку

                int size = 10; // Инициализируем размер текста
                Font drawFont = new Font("Arial", size); // Определяем шрифт
                SolidBrush drawBrush = new SolidBrush(Color.Brown); // Инициализируем кисть для рисования

                PointF drawPoint = new PointF(Convert.ToInt32(point[i].x), Convert.ToInt32(point[i].y + 5)); // Определяем координаты левой верхней точки, откуда будем отображать надпись

                //Устанавливаем формат вывода строки:
                StringFormat drawFormat = new StringFormat();

                g.DrawString(drawString, drawFont, drawBrush, drawPoint, drawFormat); // Отображаем координаты
            }
        }

        private void Draw_Poly(List<Point> lagrange) //Рисование графика функции
        {
            Pen myPen = new Pen(Color.Black, 1); //Создаём карандаш
            Graphics g = Graphics.FromHwnd(funcPrinterBox.Handle); //Инициализируем графику
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias; //Устанавливаем сглаживание

            System.Drawing.Point 
                from = new System.Drawing.Point(0, 0),
                to = new System.Drawing.Point(0, 0); //Инициализируем начальную и конечную точку для отрисовки отрезка

            for (int i = 1; i < lagrange.Count; i++)
            {
                // Преобразуем типы данных
                from.X = (int)lagrange[i - 1].x;
                from.Y = (int)lagrange[i - 1].y;
                to.X = (int)lagrange[i].x;
                to.Y = (int)lagrange[i].y;
                // Рисуем отрезок
                g.DrawLine(myPen, from, to);
            }
        }

        private void DrawXY() //Рисование осей
        {
            // Определяем длину и ширину холста
            int w = funcPrinterBox.Size.Width, h = funcPrinterBox.Size.Height;

            Pen myPen = new Pen(Color.Black, 1); //Создаём карандаш
            Graphics g = Graphics.FromHwnd(funcPrinterBox.Handle); //Инициализируем графику
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias; //Устанавливаем сглаживание

            System.Drawing.Point
            //Ось X
            from = new System.Drawing.Point(0, h / 2),
            to = new System.Drawing.Point(w, h / 2);
            g.DrawLine(myPen, from, to);

            //Стрелочка:
            g.DrawLine(myPen, to, new System.Drawing.Point(w - 20, h / 2 + 5));
            g.DrawLine(myPen, to, new System.Drawing.Point(w - 20, h / 2 - 5));

            //Ось Y
            from = new System.Drawing.Point(w / 2, h);
            to = new System.Drawing.Point(w / 2, 0);
            g.DrawLine(myPen, from, to);

            //Стрелочка:
            g.DrawLine(myPen, to, new System.Drawing.Point(w / 2 - 5, 20));
            g.DrawLine(myPen, to, new System.Drawing.Point(w / 2 + 5, 20));
        }

        private void ClearBox() //Стираем график
        {
            Graphics g = Graphics.FromHwnd(funcPrinterBox.Handle);
            g.Clear(funcPrinterBox.BackColor); // Очищаем графику
        }
        #endregion

        //Таблица:
        #region
        private void dgvCoords_CellEndEdit(object sender, DataGridViewCellEventArgs e) //Проверка на введённое значение в клетку
        {
            try
            {
                dgvCoords[e.ColumnIndex, e.RowIndex].Value = dgvCoords[e.ColumnIndex, e.RowIndex].Value.ToString().Replace('.', ',');
                Convert.ToDouble(dgvCoords[e.ColumnIndex, e.RowIndex].Value);
            }
            catch
            {   //Если возникает ошибка:
                MessageBox.Show("Введите координату верно!");
                dgvCoords.CurrentCell = dgvCoords[e.ColumnIndex, e.RowIndex];
                dgvCoords[e.ColumnIndex, e.RowIndex].Value = "";
            }
        }

        private void dgvCoords_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e) //Удаление строки из таблицы
        {
            for (int i = 0; i < dgvCoords.Rows.Count-1; i++)
                if (dgvCoords.Rows[i].Cells[2] == dgvCoords.CurrentCell)
                {
                    dgvCoords.Rows.RemoveAt(i);
                    dgvCoords.CurrentCell = null;
                    return;
                }
        }
        #endregion
    }
}
