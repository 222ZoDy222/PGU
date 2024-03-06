namespace Project1_Lagrange_Naydanov_I
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            this.funcPrinterBox = new System.Windows.Forms.PictureBox();
            this.dgvCoords = new System.Windows.Forms.DataGridView();
            this.Column1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.buttonFuncPrint = new System.Windows.Forms.Button();
            this.buttonClear = new System.Windows.Forms.Button();
            this.buttonFuncInCoord = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            ((System.ComponentModel.ISupportInitialize)(this.funcPrinterBox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCoords)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // funcPrinterBox
            // 
            this.funcPrinterBox.BackColor = System.Drawing.Color.LightSteelBlue;
            this.funcPrinterBox.Location = new System.Drawing.Point(12, 12);
            this.funcPrinterBox.Name = "funcPrinterBox";
            this.funcPrinterBox.Size = new System.Drawing.Size(712, 572);
            this.funcPrinterBox.TabIndex = 0;
            this.funcPrinterBox.TabStop = false;
            // 
            // dgvCoords
            // 
            this.dgvCoords.AllowUserToResizeColumns = false;
            this.dgvCoords.AllowUserToResizeRows = false;
            this.dgvCoords.BackgroundColor = System.Drawing.Color.LightSlateGray;
            this.dgvCoords.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvCoords.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column1,
            this.Column2,
            this.Column3});
            this.dgvCoords.Location = new System.Drawing.Point(734, 12);
            this.dgvCoords.Name = "dgvCoords";
            this.dgvCoords.RowHeadersVisible = false;
            this.dgvCoords.Size = new System.Drawing.Size(159, 572);
            this.dgvCoords.TabIndex = 1;
            this.dgvCoords.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvCoords_CellEndEdit);
            this.dgvCoords.CellMouseClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dgvCoords_CellMouseClick);
            // 
            // Column1
            // 
            this.Column1.HeaderText = "     X";
            this.Column1.MaxInputLength = 8;
            this.Column1.Name = "Column1";
            this.Column1.Width = 60;
            // 
            // Column2
            // 
            this.Column2.HeaderText = "     Y";
            this.Column2.MaxInputLength = 8;
            this.Column2.Name = "Column2";
            this.Column2.Width = 60;
            // 
            // Column3
            // 
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.Gray;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle5.NullValue = " X";
            this.Column3.DefaultCellStyle = dataGridViewCellStyle5;
            this.Column3.HeaderText = "";
            this.Column3.Name = "Column3";
            this.Column3.ReadOnly = true;
            this.Column3.Width = 20;
            // 
            // buttonFuncPrint
            // 
            this.buttonFuncPrint.BackColor = System.Drawing.Color.SteelBlue;
            this.buttonFuncPrint.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.buttonFuncPrint.ForeColor = System.Drawing.Color.White;
            this.buttonFuncPrint.Location = new System.Drawing.Point(452, 12);
            this.buttonFuncPrint.Name = "buttonFuncPrint";
            this.buttonFuncPrint.Size = new System.Drawing.Size(254, 61);
            this.buttonFuncPrint.TabIndex = 2;
            this.buttonFuncPrint.Text = "В полном размере";
            this.buttonFuncPrint.UseVisualStyleBackColor = false;
            this.buttonFuncPrint.Click += new System.EventHandler(this.buttonFuncPrint_Click);
            // 
            // buttonClear
            // 
            this.buttonClear.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.buttonClear.Location = new System.Drawing.Point(10, 12);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(153, 59);
            this.buttonClear.TabIndex = 3;
            this.buttonClear.Text = "Очистить таблицу";
            this.buttonClear.UseVisualStyleBackColor = true;
            this.buttonClear.Click += new System.EventHandler(this.buttonClear_Click);
            // 
            // buttonFuncInCoord
            // 
            this.buttonFuncInCoord.BackColor = System.Drawing.Color.SteelBlue;
            this.buttonFuncInCoord.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.buttonFuncInCoord.ForeColor = System.Drawing.Color.White;
            this.buttonFuncInCoord.Location = new System.Drawing.Point(216, 12);
            this.buttonFuncInCoord.Name = "buttonFuncInCoord";
            this.buttonFuncInCoord.Size = new System.Drawing.Size(230, 61);
            this.buttonFuncInCoord.TabIndex = 4;
            this.buttonFuncInCoord.Text = " В системе координат";
            this.buttonFuncInCoord.UseVisualStyleBackColor = false;
            this.buttonFuncInCoord.Click += new System.EventHandler(this.buttonFuncInCoord_Click);
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(6, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(198, 49);
            this.label1.TabIndex = 5;
            this.label1.Text = "Выберите способ построения функции:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.buttonFuncInCoord);
            this.groupBox1.Controls.Add(this.buttonFuncPrint);
            this.groupBox1.Location = new System.Drawing.Point(12, 590);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(715, 80);
            this.groupBox1.TabIndex = 6;
            this.groupBox1.TabStop = false;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(12, 590);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(210, 80);
            this.groupBox2.TabIndex = 6;
            this.groupBox2.TabStop = false;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.buttonClear);
            this.groupBox3.Location = new System.Drawing.Point(724, 590);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(169, 80);
            this.groupBox3.TabIndex = 7;
            this.groupBox3.TabStop = false;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.SlateGray;
            this.ClientSize = new System.Drawing.Size(904, 681);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.dgvCoords);
            this.Controls.Add(this.funcPrinterBox);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.groupBox3);
            this.MaximumSize = new System.Drawing.Size(920, 720);
            this.MinimumSize = new System.Drawing.Size(920, 720);
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Интерполяция с помощью полиномов Лагранжа";
            ((System.ComponentModel.ISupportInitialize)(this.funcPrinterBox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCoords)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button buttonFuncPrint;
        private System.Windows.Forms.PictureBox funcPrinterBox;
        private System.Windows.Forms.DataGridView dgvCoords;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.Button buttonFuncInCoord;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column1;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column2;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column3;
    }
}