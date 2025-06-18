using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quan_Ly_Cua_Hang_Do_An_Vat.update
{
    public partial class DepartmentUpdate : Form
    {
        public DepartmentUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string departmenId = null;

        public void SetDepartmentData(string id, string code, string name)
        {
            departmenId = id;
            txtDepartment_code.Text = code;
            txtDepartment_name.Text = name;
            
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(departmenId)) // Thêm mới
            {
                string query = "INSERT INTO department (department_code, department_name) VALUES (@code, @name)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtDepartment_code.Text, txtDepartment_name.Text
        });
            }
            else // Sửa
            {
                string query = "UPDATE department SET department_code = @code, department_name = @name WHERE department_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtDepartment_code.Text, txtDepartment_name.Text, departmenId
        });
            }
            if (rows > 0)
            {
                MessageBox.Show("Lưu thành công!");
                OnUpdateSuccess?.Invoke();
                this.Close();
            }
            else
            {
                MessageBox.Show("Lưu thất bại!");
            }
        }
    }
}
