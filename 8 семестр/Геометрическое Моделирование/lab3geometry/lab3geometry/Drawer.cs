using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Numerics;
using System.Security.Cryptography;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab3
{
    internal class Drawer
    {
        public Drawer(Form1 workspace)
        {
            workspace_ = workspace;
            pen_ = Pens.Black;
            Clear();
        }

        public void Clear()
        {
            g_?.Clear(Color.White);
        }

        public void Reset()
        {
            Clear();
            points.Clear();
        }
        public void DrawPoint(Point p)
        {
            Clear();
            points.Add(p);
            g_ = workspace_.CreateGraphics();
            for (int i = 0; i < points.Count; i++)
                g_.DrawEllipse(pen_, (int)points[i].X, (int)points[i].Y, 5, 5);

            if (points.Count >= 2)
            {
                DrawBezierCurve(g_, points.ToArray());
                DrawDeCasteljau(g_, points.ToArray());
            }
        }

        // Метод для рисования кривой Безье
        public void DrawBezierCurve(Graphics g, PointF[] controlPoints)
        {
            // Создание пера для рисования кривой
            using (Pen curvePen = new Pen(Color.Blue, 2))
            {
                // Предыдущая точка на кривой
                PointF previousPoint = CalculateBezierPoint(0, controlPoints);

                // Рисование кривой по точкам
                for (float t = 0; t <= 1; t += (float)0.01)
                {
                    // Вычисление текущей точки на кривой
                    PointF currentPoint = CalculateBezierPoint(t, controlPoints);
                    // Рисование линии между предыдущей и текущей точками
                    g.DrawLine(curvePen, previousPoint, currentPoint);

                    // Обновление предыдущей точки
                    previousPoint = currentPoint;
                }
            }
        }

        // Метод для вычисления точки на кривой Безье
        public PointF CalculateBezierPoint(float t, PointF[] controlPoints)
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
            return new PointF((float)x, (float)y);
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

        public void DrawDeCasteljau(Graphics g, PointF[] controlPoints)
        {
            // Создание пера для рисования кривой
            using (Pen curvePen = new Pen(Color.Red, 2))
            {
                // Предыдущая точка на кривой
                PointF previousPoint = DeCasteljau(controlPoints.Length -1, 0, 0,controlPoints);

                // Рисование кривой по точкам
                for (float t = 0; t <= 1; t += (float)0.01)
                {
                    // Вычисление текущей точки на кривой
                    PointF currentPoint = DeCasteljau(controlPoints.Length-1, 0,t,controlPoints);
                    // Рисование линии между предыдущей и текущей точками
                    currentPoint.Y += 3;
                    g.DrawLine(curvePen, previousPoint, currentPoint);

                    // Обновление предыдущей точки
                    previousPoint = currentPoint;
                }
            }
        }

        // Рекурсивный метод алгоритма Де Кастельжо
        /*public PointF DeCasteljau(float t, PointF[] controlPoints)
         {
             int n = controlPoints.Length - 1;
             if (n == 0)
             {
                 return controlPoints[0];
             }

             PointF[] newPoints = new PointF[n];
             for (int i = 0; i < n; i++)
             {
                 newPoints[i] = new PointF(
                     (float)((1 - t) * controlPoints[i].X + t * controlPoints[i + 1].X),
                     (float)((1 - t) * controlPoints[i].Y + t * controlPoints[i + 1].Y)
                 );
             }

             return DeCasteljau(t, newPoints);
         }
        */

        public PointF Cast2(PointF p1, PointF p2, float t)
        {
            return new PointF(p1.X * (1 - t) + p2.X * t, p1.Y * (1 - t) + p2.Y * t);
        }
        public PointF DeCasteljau(int k, int i, float t, PointF[] controlPoints)
        {
            if (k==0)
            {
                return controlPoints[i];
            }

            return Cast2(DeCasteljau((k - 1), i, t, controlPoints), DeCasteljau(k - 1, i + 1, t, controlPoints), t);
            //sreturn (1-t)*DeCasteljau((k - 1), i, t, controlPoints)+t*DeCasteljau(k - 1, i + 1, t, controlPoints);
        }

        List<PointF> points = new List<PointF>();
        Graphics g_;
        private Form1 workspace_;
        Pen pen_;

    }
}


