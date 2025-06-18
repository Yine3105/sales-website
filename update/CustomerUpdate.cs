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
    public partial class CustomerUpdate : Form
    {
        public CustomerUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string customerId = null;

        public void SetCustomerData(string id, string code, string first_name, string last_name, string address, string phone, string email)
        {
            customerId = id;
            txtCustomer_code.Text = code;
            txtCustomer_name.Text = first_name + " " + last_name;
            txtCustomer_address.Text = address;
            txtCustomer_phone.Text = phone;
            txtCustomer_email.Text = email;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(customerId)) // Thêm mới
            {
                string query = "INSERT INTO customer (customer_code, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email) VALUES (@code, @first_name, @last_name, @address, @phone, @email)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtCustomer_code.Text, txtCustomer_name.Text, txtCustomer_address.Text, txtCustomer_phone.Text, txtCustomer_email.Text
        });
            }
            else // Sửa
            {
                string query = "UPDATE customer SET customer_code = @code, customer_first_name = @first_name, customer_last_name = @last_name, customer_address = @address, customer_phone = @phone, customer_email = @email WHERE customer_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtCustomer_code.Text, txtCustomer_name.Text, txtCustomer_address.Text, txtCustomer_phone.Text, txtCustomer_email.Text, customerId
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
