using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab5
{
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
        }

        private Graphics m_graphics;
        public Graphics graphics
        {
            get
            {
                if (m_graphics == null) m_graphics = pictureBox1.CreateGraphics();
                return m_graphics;
            }
        }

        
        private void pictureBox1_Click(object sender, EventArgs e)
        {
            MouseEventArgs me = (MouseEventArgs)e;
            Point coordinates = me.Location;
            AddUserPoint(coordinates);
        }



        private void button1_Click(object sender, EventArgs e)
        {
            ResetPoints();
        }


        List<Point> userPoints = new List<Point>();


        private void AddUserPoint(Point p)
        {
            userPoints.Add(p);
            Draw7Lab();
        }

        private void Draw7Lab()
        {
            graphics.Clear(BackColor);

            if (userPoints.Count < 3) return;
            pointCurves.Clear();
            Brush aBrush = (Brush)Brushes.Red;
            foreach (var p in userPoints)
            {
                graphics.FillRectangle(aBrush, p.X, p.Y, 10, 10);
            }

            DrawBezierCurve(graphics, userPoints.ToArray());
            Recurentnaya(graphics, userPoints.ToArray());

        }

        #region BEzie

        // Метод для рисования кривой Безье
        public void DrawBezierCurve(Graphics g, Point[] controlPoints)
        {
            List<Point> resultPoints = new List<Point>();
            // Предыдущая точка на кривой
            Point previousPoint = CalculateBezierPoint(0, controlPoints);
            resultPoints.Add(previousPoint);
            Pen curvePen = new Pen(Color.Blue, 2);
            // Рисование кривой по точкам
            for (float t = 0; t <= 1; t += (float)0.01)
            {
                // Вычисление текущей точки на кривой
                Point currentPoint = CalculateBezierPoint(t, controlPoints);
                resultPoints.Add(currentPoint);

                // Обновление предыдущей точки
                previousPoint = currentPoint;
            }

            g.DrawLines(curvePen, resultPoints.ToArray());
        }

        // Метод для вычисления точки на кривой Безье
        public Point CalculateBezierPoint(float t, Point[] controlPoints)
        {
            float x = 0;
            float y = 0;
            int n = controlPoints.Length - 1;

            for (int i = 0; i <= n; i++)
            {
                float bernstein = Bernstein(n, i, t);
                x += bernstein * controlPoints[i].X;
                y += bernstein * controlPoints[i].Y;
            }
            return new Point((int)x, (int)y);
        }

        // Функция Бернштейна
        private float Bernstein(int n, int i, double t)
        {
            return (float)((Factorial(n) / (Factorial(i) * Factorial(n - i))) * Math.Pow(t, i) * Math.Pow(1 - t, n - i));
        }

        public static float Factorial(long n)
        {
            if (n == 0) return 1;
            else return n * Factorial(n - 1);
        }


        #endregion


        #region Recurentnaya formula

        public void Recurentnaya(Graphics g, Point[] controlPoints)
        {
            List<Point> resultPoints = new List<Point>();
            
            
            for (float t = 0; t <= 1; t += (float)0.01)
            {
                
                // Вычисление текущей точки на кривой
                Point currentPoint = DeCasteljau(controlPoints.Length - 1, 0, t, controlPoints);
                resultPoints.Add(currentPoint);

                // Рисование линии между предыдущей и текущей точками
                currentPoint.Y += 3;

            }
            Pen curvePen = new Pen(Color.Red, 2);
            g.DrawLines(curvePen, resultPoints.ToArray());
        }
        public Point Cast2(Point p1, Point p2, float t)
        {
            return new Point((int)(p1.X * (1 - t) + p2.X * t),(int)(p1.Y * (1 - t) + p2.Y * t));
        }
        public Point DeCasteljau(int k, int i, float t, Point[] controlPoints)
        {
            if (k == 0) return controlPoints[i];


            return Cast2(DeCasteljau((k - 1), i, t, controlPoints), DeCasteljau(k - 1, i + 1, t, controlPoints), t);
        }
        #endregion

        private void ResetPoints()
        {
            userPoints.Clear();
            pictureBox1.Image = null;
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            ResetPoints();
        }

        
        private const int pointBetween = 100;

        private static List<PointCurve> pointCurves = new List<PointCurve>();

        


        public class PointCurve
        {
            public int index;
            public double X;
            public double Y;
            
            public bool dontTOCH;

            public PointCurve(Point p, int index)
            {
                X = p.X;
                Y = p.Y;
                this.index = index;
            }

            public PointCurve prev
            {
                get
                {
                    if (index == 0) return null;
                    return pointCurves[index - 1];
                }
            }

            public PointCurve post
            {
                get
                {
                    if (index == pointCurves.Count - 1) return null;
                    return pointCurves[index + 1];
                }
            }


            public double q(bool isX)
            {
                // Q i
                if (prev != null && post != null)
                {
                    if (isX)
                    {
                        return 0.5 * (post.X - prev.X);
                    }
                    else
                    {
                        return 0.5 * (post.Y - prev.Y);
                    }
                }
                // Q 0
                else if (prev == null)
                {
                    if (isX)
                    {
                        return 2 * (post.X - X) - post.q(isX);
                    }
                    else
                    {
                        return 2 * (post.Y - Y) - post.q(isX);
                    }
                }
                // Q n
                else
                {
                    if (isX)
                    {
                        return 2 * (X - prev.X) - prev.q(isX);
                    }
                    else
                    {
                        return 2 * (Y - prev.Y) - prev.q(isX);
                    }
                }
            }

        }




        

    }
}


