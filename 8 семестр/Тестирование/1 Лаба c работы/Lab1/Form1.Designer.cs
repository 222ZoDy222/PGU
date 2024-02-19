
namespace Lab1
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.inputArraySize = new System.Windows.Forms.TextBox();
            this.InputGroup = new System.Windows.Forms.GroupBox();
            this.InputGroup.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(17, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(87, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Длина массива";
            // 
            // inputArraySize
            // 
            this.inputArraySize.Location = new System.Drawing.Point(20, 52);
            this.inputArraySize.Name = "inputArraySize";
            this.inputArraySize.Size = new System.Drawing.Size(48, 20);
            this.inputArraySize.TabIndex = 1;
            this.inputArraySize.TextChanged += new System.EventHandler(this.inputArraySize_TextChanged);
            this.inputArraySize.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.inputArraySize_KeyPress);
            // 
            // InputGroup
            // 
            this.InputGroup.Controls.Add(this.label1);
            this.InputGroup.Controls.Add(this.inputArraySize);
            this.InputGroup.Location = new System.Drawing.Point(12, 12);
            this.InputGroup.Name = "InputGroup";
            this.InputGroup.Size = new System.Drawing.Size(739, 414);
            this.InputGroup.TabIndex = 3;
            this.InputGroup.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.InputGroup);
            this.Name = "Form1";
            this.Text = "Form1";
            this.InputGroup.ResumeLayout(false);
            this.InputGroup.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox inputArraySize;
        private System.Windows.Forms.GroupBox InputGroup;
    }
}

