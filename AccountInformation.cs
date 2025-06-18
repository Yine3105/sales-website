using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quan_Ly_Cua_Hang_Do_An_Vat
{
    public partial class AccountInformation : Form
    {
        public AccountInformation(int userId)
        {
            InitializeComponent();
            LoadUserInfo(userId);
        }

        private void LoadUserInfo(int userId)
        {
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT e.*, d.department_name
                FROM employee e
                JOIN department d ON e.department_id = d.department_id
                WHERE e.employee_id = @id";
            DataTable dt = provider.ExcuteQuery(query, new object[] { userId });
            if (dt.Rows.Count > 0)
            {
                txtEmployee_code.Text = dt.Rows[0]["employee_code"].ToString();
                txtEmployee_name.Text = dt.Rows[0]["employee_first_name"].ToString() + " " + dt.Rows[0]["employee_last_name"].ToString();
                txtEmployee_address.Text = dt.Rows[0]["employee_address"].ToString();
                txtEmployee_email.Text = dt.Rows[0]["employee_email"].ToString();
                txtEmployee_phonenumber.Text = dt.Rows[0]["employee_phone"].ToString();
                txtEmployee_birth.Text = Convert.ToDateTime(dt.Rows[0]["employee_birth"]).ToString("dd/MM/yyyy");
                txtEmployee_role.Text = dt.Rows[0]["note"].ToString();
                txtDepartment.Text = dt.Rows[0]["department_name"].ToString();
            }
        }
    }
}
