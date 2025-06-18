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
    public partial class VoucherUpdate : Form
    {
        public VoucherUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string voucherId = null;

        public void SetVoucherData(string id, string name, string value)
        {
            voucherId = id;
            txtVoucher_name.Text = name;
            txtVoucher_values.Text = value;

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(voucherId)) // Thêm mới
            {
                string query = "INSERT INTO voucher (voucher_name, voucher_value) VALUES (@name, @value)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtVoucher_name.Text, txtVoucher_values.Text
        });
            }
            else // Sửa
            {
                string query = "UPDATE voucher SET voucher_name = @name, voucher_value = @value WHERE voucher_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtVoucher_name.Text, txtVoucher_values.Text, voucherId
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
