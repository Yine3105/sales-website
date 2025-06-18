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
    public partial class EmployeeUpdate : Form
    {
        public EmployeeUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string employeeId = null;

        public void SetEmployeeData(string id, string code, string first_name, string last_name, string address, string phone, string email, string gender, string birth, string deparment, string role)
        {
            employeeId = id;
            txtEmployee_code.Text = code;
            txtEmployee_name.Text = first_name + " " + last_name;
            txtEmployee_address.Text = address;
            txtEmployee_phone.Text = phone;
            txtEmployee_email.Text = email;
            txtEmployee_birth.Text = birth;
            txtEmployee_gender.Text = gender;
            txtEmployee_department.Text = deparment;
            txtEmployee_role.Text = role;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(employeeId)) // Thêm mới
            {
                string query = "INSERT INTO employee (employeev_code, employee_first_name, employee_last_name, employee_address, employee_phone, employee_email, employee_gender, employee_birth, department_id, note) VALUES (@code, @first_name, @last_name, @address, @phone, @email, @gender, @birth, @department, @role)";
                rows = provider.ExcuteNonQuery(query, new object[] {
                txtEmployee_code.Text, txtEmployee_name.Text, txtEmployee_address.Text, txtEmployee_phone.Text, txtEmployee_email.Text, txtEmployee_birth.Text, txtEmployee_gender.Text, txtEmployee_role.Text  
        });
            }
            else // Sửa
            {
                string query = "UPDATE employee SET employeev_code = @code, employee_first_name = @first_name, employee_last_name = @last_name, employee_address = @address, employee_phone = @phone, employee_email = @email, employee_gender = @gender, employee_birth = @birth, department_id =  @department, note = @role WHERE employee_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
                txtEmployee_code.Text, txtEmployee_name.Text, txtEmployee_address.Text, txtEmployee_phone.Text, txtEmployee_email.Text, txtEmployee_birth.Text, txtEmployee_gender.Text, txtEmployee_role.Text , employeeId
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
