using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab2
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
            for(int i = 0; i < points.Count; i++)
            g_.DrawEllipse(pen_, (int)points[i].X, (int)points[i].Y, 5, 5);

            if (points.Count >= 2)
            {
                DrawLangrage();
                DrawNewton();
            }

        }  
        
        
        void DrawLangrage()
        {
            Graphics g = workspace_.CreateGraphics();
            float max_x = points.Max(p => p.X);
            float min_x = points.Min(x => x.X);
            Pen rp = Pens.Red;

            List<double> xval = new List<double>();
            List<double> yval = new List<double>();
            for(int i = 0;i<points.Count-1; i++)
            {
                xval.Add(points[i].X);
                yval.Add(points[i].Y);
            }

            float[] prev_point = LagrangePolynomialNew(0);
            for (float t = 0; t <= xval.Count; t += (float)0.01)
            {
                //float y = LagrangePolynomial(t);
                //g.DrawEllipse(rp, t,y, 1, 1);

                float[] r = LagrangePolynomialNew(t);
                g.DrawLine(rp, new PointF(prev_point[0], prev_point[1]), new PointF(r[0],r[1]));
                prev_point[0] = r[0];
                prev_point[1] = r[1];
                //g.DrawEllipse(rp, r[0], r[1], 1, 1);
            }
        } 
        
        public float LagrangePolynomial(float t)
        {
            float result = 0;

            for (int i = 0; i < points.Count; i++)
            {
                float basicsPol = 1;
                for (int j = 0; j < points.Count; j++)
                {
                    if (i != j)
                    {
                        basicsPol *= (t - points[j].X) / (points[i].X - points[j].X);
                    }
                }
                result += basicsPol * points[i].Y;
            }

            return result;
        }


        public float[] LagrangePolynomialNew(float t)
        {
            float[] r = new float[2];
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

        void DrawNewton()
        {
            Graphics g = workspace_.CreateGraphics();
            float max_x = points.Max(p => p.X);
            float min_x = points.Min(x => x.X);
            Pen bp = Pens.Blue;
            List<double> xval = new List<double>();
            List<double> yval = new List<double>();

            for (int i = 0; i < points.Count; i++)
            {
                xval.Add(points[i].X);
                yval.Add(points[i].Y);
            }
            double[] prev_point = NewtonPolynomial(xval.ToArray(), yval.ToArray(), 0);

            for (double t = 0; t <= xval.Count - 1; t += 0.01)
            {
               var r = NewtonPolynomial(xval.ToArray(), yval.ToArray(), t);
                g.DrawLine(bp, new PointF((float)prev_point[0] + 5F, (float)prev_point[1] + 5F), new PointF((float)r[0] + 5F, (float)r[1] + 5F));
                prev_point[0] = r[0];
                prev_point[1] = r[1];
                //g.DrawEllipse(bp, (int)r[0], (int)r[1] + 5, 1, 1);
            }
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

       private double[] ConvF(double[] p1, double[] p2, double[] xValues, double[] yValues, int i, int j)
        {
            double[] result = new double[2];
            //result[0] = (p1[0] - p2[0]) / (xValues[i+j] - xValues[i]);
            // result[1] = (p1[1] - p2[1]) / (yValues[i + j] - yValues[i]);
            result[0] = (p1[0] - p2[0]) / (i + j - i);
            result[1] = (p1[1] - p2[1]) / (i + j - i);
            return result;

        }
        public double[] F(double[] xValues, double[] yValues, int i, int j)
        {
            if (j == 0)
            {
                return new double[] {xValues[i],yValues[i] };
            }
            else
            {
                //return (F(xValues, yValues, i + 1, j - 1) - F(xValues, yValues, i, j - 1)) / (xValues[i + j] - xValues[i]);
                return ConvF(F(xValues, yValues, i + 1, j - 1), F(xValues, yValues, i, j - 1), xValues, yValues, i, j);
            }
        }
            /* public double NewtonPolynomial(double[] xValues, double[] yValues, double x)
             {
                 double result = yValues[0];
                 for (int i = 1; i < xValues.Length; i++)
                 {
                     double term = F(xValues, yValues, 0, i);
                     for (int j = 0; j < i; j++)
                     {
                         term *= (x - xValues[j]);
                     }
                     result += term;
                 }
                 return result;
             }

             public  double F(double[] xValues, double[] yValues, int i, int j)
             {
                 if (j == 0)
                 {
                     return yValues[i];
                 }
                 else
                 {

                     return (F(xValues, yValues, i + 1, j - 1) - F(xValues, yValues, i, j - 1)) / (xValues[i + j] - xValues[i]);
                 }
             }*/


            List<PointF> points = new List<PointF>();
        Graphics g_;
        private Form1 workspace_;
        Pen pen_;

    }
}
