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
    public partial class ItemUpdate : Form
    {
        public ItemUpdate()
        {
            InitializeComponent();
            btnSave.Click += btnSave_Click;
        }
        public delegate void UpdateSuccessHandler();
        public event UpdateSuccessHandler OnUpdateSuccess;
        private string itemId = null;

        public void SetItemData(string id, string code, string name, string cost, string retail)
        {
            itemId = id;
            txtItemcode.Text = code;
            txtItemname.Text = name;
            txtItemCostprice.Text = cost.ToString();
            txtItemRetailprice.Text = retail.ToString();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DataProvider provider = new DataProvider();
            int rows = 0;
            if (string.IsNullOrEmpty(itemId)) // Thêm mới
            {
                string query = "INSERT INTO item (item_code, item_name, item_retail, item_cost_price) VALUES (@code, @name, @retail, @cost)";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtItemcode.Text, txtItemname.Text, txtItemRetailprice, txtItemCostprice
        });
            }
            else // Sửa
            {
                string query = "UPDATE item SET item_code = @code, item_name = @name WHERE item_id = @id";
                rows = provider.ExcuteNonQuery(query, new object[] {
            txtItemcode.Text, txtItemname.Text, txtItemRetailprice, txtItemCostprice, itemId
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
