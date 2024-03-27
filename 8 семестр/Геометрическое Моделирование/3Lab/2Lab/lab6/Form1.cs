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

        private void DrawCurvePoint()
        {

            graphics.Clear(BackColor);

            if (userPoints.Count < 2) return;
            // Create pens.
            //Pen redPen = new Pen(Color.Red, 3);
            Pen greenPen = new Pen(Color.Green, 3);

            // Create points that define curve.
            //Point point1 = new Point(50, 50);
            //Point point2 = new Point(100, 25);
            //Point point3 = new Point(200, 5);
            //Point point4 = new Point(250, 50);
            //Point point5 = new Point(300, 100);
            //Point point6 = new Point(350, 200);
            //Point point7 = new Point(250, 250);
            //Point[] curvePoints = { point1, point2, point3, point4, point5, point6, point7 };

            //// Draw lines between original points to screen.
            //e.Graphics.DrawLines(redPen, curvePoints);

            //// Draw curve to screen.
            //e.Graphics.DrawCurve(greenPen, curvePoints);
            Brush aBrush = (Brush)Brushes.Red;
            foreach (var p in userPoints)
            {
                graphics.FillRectangle(aBrush, p.X, p.Y, 10, 10);
            }

            DrawCurve(userPoints);
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
            Draw6Lab();
        }

        private void Draw6Lab()
        {
            graphics.Clear(BackColor);

            if (userPoints.Count < 3) return;
            pointCurves.Clear();
            Brush aBrush = (Brush)Brushes.Red;
            foreach (var p in userPoints)
            {
                graphics.FillRectangle(aBrush, p.X, p.Y, 10, 10);
            }


            // Лагранж
            Lagrange(userPoints);

            // Ньютон
            Newton(userPoints);
        }

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

        private void DrawCurve(List<Point> points)
        {
            if (points.Count < 3) return;
            pointCurves.Clear();
            Brush bBrush = (Brush)Brushes.Blue;
            Brush yBrush = (Brush)Brushes.Yellow;
            Pen redPen = new Pen(Color.Red, 3);
            // Init List
            int pointCount = 0;
            for (int i = 0; i < points.Count; i++)
            {

                PointCurve p = new PointCurve(points[i], pointCount);
                p.dontTOCH = true;
                pointCurves.Add(p);
                pointCount++;

                
            }

            graphics.DrawCurve(redPen, points.ToArray());

            // Цикл по сплайнам
            for (int i = 0; i < pointCount-1; i++)
            {

                List<Point> splinePoints = new List<Point>();
                double w = 0;

                for (int j = 0; j < pointBetween; j++)
                {

                    var resultX = SplineHermite(true, pointCurves[i], w);
                    var resultY = SplineHermite(false, pointCurves[i], w);

                    var newPoint = new Point((int)resultX, (int)resultY);
                    splinePoints.Add(newPoint);
                    graphics.FillRectangle(yBrush, newPoint.X, newPoint.Y, 5, 5);
                    w += (double)(1d / ((double)pointBetween));
                }


                
            }
            


            
        }


        private void Lagrange(List<Point> points)
        {

            
            List<PointCurve> pointsCurve = new List<PointCurve>();

            for (int i = 0; i < points.Count; i++)
            {
                pointsCurve.Add(new PointCurve(points[i],i));
            }

            var result = Calc_Lagrange(pointsCurve);

            Pen greenPen = new Pen(Color.Green, 6);
            graphics.DrawLines(greenPen, result.ToArray());
            
        }



        private const double STEP = 10;
        private const double BLOCK = 1;

        private void Newton(List<Point> points)
        {
            List<Point> newtonPoints = new List<Point>();

            points.Clear();
            points.Add(new Point(1, 2));
            points.Add(new Point(2, 3));
            points.Add(new Point(4, 1));
            points.Add(new Point(7, 4));

            float max_x = points.Max(p => p.X);
            float min_x = points.Min(x => x.X);

            List<double> xval = new List<double>();
            List<double> yval = new List<double>();

            for (int i = 0; i < points.Count; i++)
            {
                xval.Add(points[i].X);
                yval.Add(points[i].Y);
            }
            double[] prev_point = new double[2];

            for (double t = 0; t <= xval.Count - 1; t += 0.01)
            {
                var r = NewtonPolynomial(xval.ToArray(), yval.ToArray(), t);
                //g.DrawLine(bp, new PointF((float)prev_point[0] + 5F, (float)prev_point[1] + 5F), new PointF((float)r[0] + 5F, (float)r[1] + 5F));
                prev_point[0] = r[0];
                prev_point[1] = r[1];
                var point = new Point((int)r[0], (int)r[1]);
                newtonPoints.Add(point);
                //g.DrawEllipse(bp, (int)r[0], (int)r[1] + 5, 1, 1);
            }


            Pen greenPen = new Pen(Color.Blue, 3);

            graphics.DrawLines(greenPen, newtonPoints.ToArray());

        }

        public double[] NewtonPolynomial(double[] xValues, double[] yValues, double t)
        {
            double[] result = new double[2];

            for (int i = 0; i < xValues.Length; i++)
            {
                double[] a = F(xValues, yValues, 0, i);
                for (int j = 0; j < i; j++)
                {
                    a[0] *= (t - j);
                    a[1] *= (t - j);
                }
                result[0] += a[0];
                result[1] += a[1];
            }
            return result;
        }

        private double[] ConvF(double[] p1, double[] p2, int i, int j)
        {
            double[] result = new double[2];
            
            result[0] = (p1[0] - p2[0]) / (i + j - i);
            result[1] = (p1[1] - p2[1]) / (i + j - i);
            return result;

        }
        public double[] F(double[] xValues, double[] yValues, int i, int j)
        {
            if (j == 0)
            {
                return new double[] { xValues[i], yValues[i] };
            }
            else
            {
                //return (F(xValues, yValues, i + 1, j - 1) - F(xValues, yValues, i, j - 1)) / (xValues[i + j] - xValues[i]);
                return ConvF(F(xValues, yValues, i + 1, j - 1), F(xValues, yValues, i, j - 1), i, j);
            }
        }


        private void Newton1()
        {
            if (userPoints.Count < 3) return;
            List<double> a = new List<double>();

            


            #region Comments
            
            a.Add(userPoints[0].Y);



            for (int i = 1; i < userPoints.Count; i++)
            {
                //3
                double temp = userPoints[i].Y;
                for (int j = 0; j < i; j++)
                {
                    double temphuy = a[j];
                    for (int k = 0; k < j; k++)
                    {
                        temphuy *= userPoints[i].X - userPoints[k].X;
                    }
                    temp -= temphuy;
                }

                double summDel = 1;
                for (int j = 0; j < i; j++)
                {
                    summDel *= userPoints[i].X - userPoints[j].X;
                }

                if (summDel != 0)
                    temp /= summDel;

                a.Add(temp);
            }

            List<Point> newPoints = new List<Point>();


            for (int i = 0; i < userPoints.Count - 1; i++)
            {
                newPoints.Add(new Point(userPoints[i].X, userPoints[i].Y));
                double stepX = userPoints[i].X;
                while(stepX + STEP <= userPoints[i + 1].X)
                {
                    stepX += STEP;

                    double summ = a[0];
                    for (int j = 1; j < a.Count; j++)
                    {
                        //a[j] * ()
                        double mult = 1;
                        for (int k = 0; k < j; k++)
                        {
                            var tmp = stepX - userPoints[k].X;
                            mult *= tmp;
                        }

                        mult *= a[j];

                        summ += mult;
                    }

                    newPoints.Add(new Point((int)(stepX), (int)(summ)));
                }

                

            }

            Brush aBrush = (Brush)Brushes.Blue;
            foreach (var p in newPoints)
            {
                graphics.FillRectangle(aBrush, p.X, p.Y, 5, 5);
            }
            #endregion

        }




        public double SplineHermite(bool isX, PointCurve point, double w)
        {
            if (isX)
            {
                var res1 = point.X * (1 - 3 * Math.Pow(w, 2) + 2 * Math.Pow(w, 3));
                var res2 = point.post.X * (3 * Math.Pow(w, 2) - 2 * Math.Pow(w, 3));
                var res3 = point.q(true) * (w - 2 * Math.Pow(w, 2) + Math.Pow(w, 3));
                var res4 = point.post.q(true) * (-(Math.Pow(w, 2)) + Math.Pow(w, 3));
                return res1 + res2 + res3 + res4;
            }
            else
            {
                var res1 = point.Y * (1 - 3 * Math.Pow(w, 2) + 2 * Math.Pow(w, 3));
                var res2 = point.post.Y * (3 * Math.Pow(w, 2) - 2 * Math.Pow(w, 3));
                var res3 = point.q(false) * (w - 2 * Math.Pow(w, 2) + Math.Pow(w, 3));
                var res4 = point.post.q(false) * (-(Math.Pow(w, 2)) + Math.Pow(w, 3));
                return res1 + res2 + res3 + res4;
            }
            
        }



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




        const int border = 1000000; //Максимальный Х, с которым может работать программа
        private List<Point> Calc_Lagrange1(List<PointCurve> points)//Вычисление функции Лагранжа
        {
            #region SHIT
            //List<Point> lagrange = new List<Point>();

            ////Установим максимум/минимум для X
            //double minX = border;
            //double maxX = -border;

            ////Вычисляем область определения, на которой будем строить график:
            //for (int i = 0; i < point.Count; i++)
            //{
            //    if (point[i].X > maxX) maxX = point[i].X;
            //    if (point[i].X < minX) minX = point[i].X;
            //}

            ////Работа с БАЗИСНЫМ полиномом:
            //for (int X = Convert.ToInt32(minX); X <= Convert.ToInt32(maxX); X++)
            //{
            //    double Y = 0.0;
            //    for (int i = 0; i < point.Count; i++)
            //    {
            //        //Вычисляем х для базисного полинома
            //        double basis = 1.0;
            //        for (int j = 0; j < point.Count; j++)
            //            if (j != i)
            //                basis *= (X - point[j].X) / (point[i].X - point[j].X);
            //        //Вычисляем y
            //        Y += basis * point[i].Y;
            //    }

            //    //Записываем координаты полученной точки в массив
            //    Point newPoint = new Point(X, (int)Y);                
            //    lagrange.Add(newPoint);
            //}
            //return lagrange;
            #endregion

            return null;
           

        }

        public double[] LagrangePolynomialNew(float t, List<PointCurve> points)
        {
            double[] r = new double[2];
            for (int i = 0; i < points.Count; i++)
            {
                float basicsPol = 1;
                for (int j = 0; j < points.Count; j++)
                {
                    if (i != j)
                    {
                        basicsPol *= (t - j) / (i - j);
                    }
                }
                r[0] += basicsPol * points[i].X;
                r[1] += basicsPol * points[i].Y;
            }

            return r;
        }

        private double t_STEP = 0.1;
        private List<Point> Calc_Lagrange(List<PointCurve> points)
        {
            List<Point> lagrangePoints = new List<Point>();

            List<double> xval = new List<double>();
            List<double> yval = new List<double>();
            for (int i = 0; i < points.Count; i++)
            {
                xval.Add(points[i].X);
                yval.Add(points[i].Y);
            }

            double[] prev_point = new double[2];
            for (float t = 0; t <= xval.Count-1; t += (float)0.01)
            {

                double[] r = LagrangePolynomialNew(t, points);
                
                prev_point[0] = r[0];
                prev_point[1] = r[1];
                var newPoint = new Point((int)r[0], (int)r[1]);
                lagrangePoints.Add(newPoint);
                //g.DrawEllipse(rp, r[0], r[1], 1, 1);
            }

            return lagrangePoints;
        }


    }
}


