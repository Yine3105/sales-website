using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quan_Ly_Cua_Hang_Do_An_Vat.company
{
    public partial class CompanyUpdate : Form
    {
        public CompanyUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string companyId = null;

        public void SetCompanyData(string id, string code, string name, string address, string phone, string email)
        {
            companyId = id;
            txtCompany_code.Text = code;
            txtCompany_name.Text = name;
            txtCompany_address.Text = address;
            txtCompany_phone.Text = phone;
            txtCompany_email.Text = email;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(companyId)) // Thêm mới
            {
                string query = "INSERT INTO company (company_code, company_name, company_address, company_phone, company_email, company_fax) VALUES (@code, @name, @address, @phone, @email, @fax)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtCompany_code.Text, txtCompany_name.Text, txtCompany_address.Text, txtCompany_phone.Text, txtCompany_email.Text, txtCompany_fax.Text
        });
            }
            else // Sửa
            {
                string query = "UPDATE company SET company_code = @code, company_name = @name, company_address = @address, company_phone = @phone, company_email = @email, company_fax = @fax WHERE company_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtCompany_code.Text, txtCompany_name.Text, txtCompany_address.Text, txtCompany_phone.Text, txtCompany_email.Text, txtCompany_fax.Text, companyId
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
