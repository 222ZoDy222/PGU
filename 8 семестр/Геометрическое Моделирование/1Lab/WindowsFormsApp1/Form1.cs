using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
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

            graphics.DrawCurve(greenPen, userPoints.ToArray());
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
            DrawCurvePoint();
        }


        private void ResetPoints()
        {
            userPoints.Clear();
            pictureBox1.Image = null;
        }

    }
}
