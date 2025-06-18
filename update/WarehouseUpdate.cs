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
    public partial class WarehouseUpdate : Form
    {
        public WarehouseUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string warehouseId = null;

        public void SetWarehouseData(string id, string code, string name)
        {
            warehouseId = id;
            txtWarehouse_code.Text = code;
            txtWarehouse_name.Text = name;

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(warehouseId)) // Thêm mới
            {
                string query = "INSERT INTO warehouse (warehouse_code, note) VALUES (@code, @name)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtWarehouse_code.Text, txtWarehouse_name.Text
        });
            }
            else // Sửa
            {
                string query = "UPDATE warehouse SET warehouse_code = @code, note = @name WHERE warehouse_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtWarehouse_code.Text, txtWarehouse_name.Text, warehouseId
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
