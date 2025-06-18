using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace Quan_Ly_Cua_Hang_Do_An_Vat
{
    public partial class Staff : Form
    {
        private int userId;
        private decimal totalAmount = 0;

        // Lớp sản phẩm để lưu thông tin cho từng PictureBox
        private class Product
        {
            public string Id;
            public string Name;
            public decimal Price;
            public string Category;
            public Panel PanelContainer;
            public PictureBox pictureBox;
        }

        private List<Product> products = new List<Product>();

        public Staff(int userId)
        {
            InitializeComponent();
            this.userId = userId;

            InitializeListView();
            InitProducts();
            RegisterPictureBoxEvents();
            RegisterButtonEvents();

            cbItem.SelectedIndexChanged += CbItem_SelectedIndexChanged;

            UpdateTotalAmount();
            UpdateChangeMoney();
        }

        private void InitializeListView()
        {
            lvInvoice.View = View.Details;
            lvInvoice.FullRowSelect = true;
            lvInvoice.GridLines = true;
            lvInvoice.Columns.Clear();
            lvInvoice.Columns.Add("Mã SP", 100);
            lvInvoice.Columns.Add("Tên SP", 200);
            lvInvoice.Columns.Add("Giá bán", 100);
            lvInvoice.Columns.Add("Số lượng", 100);
        }

        // Khai báo sản phẩm kèm PictureBox, loại và giá
        private void InitProducts()
        {
            // Đồ ăn vặt
            products.Add(new Product { Id = "SP001", Name = "Bánh tráng trộn", Price = 20000, Category = "Đồ ăn", PanelContainer = panelDoAnVat1, pictureBox = picDoAnVat1 });
            products.Add(new Product { Id = "SP002", Name = "Bánh tráng cuốn me", Price = 22000, Category = "Đồ ăn", PanelContainer = panelDoAnVat2, pictureBox = picDoAnVat2 });
            products.Add(new Product { Id = "SP003", Name = "Chân gà sốt thái", Price = 54000, Category = "Đồ ăn", PanelContainer = panelDoAnVat3, pictureBox = picDoAnVat3 });
            products.Add(new Product { Id = "SP004", Name = "Trái cây dầm", Price = 18000, Category = "Đồ ăn", PanelContainer = panelDoAnVat4, pictureBox = picDoAnVat4 });
            products.Add(new Product { Id = "SP005", Name = "Khoai tây chiên", Price = 30000, Category = "Đồ ăn", PanelContainer = panelDoAnVat5, pictureBox = picDoAnVat5 });
            products.Add(new Product { Id = "SP006", Name = "Gà rán", Price = 38000, Category = "Đồ ăn", PanelContainer = panelDoAnVat6, pictureBox = picDoAnVat6 });

            // Đồ uống
            products.Add(new Product { Id = "D001", Name = "Trà thái chanh xanh", Price = 24000, Category = "Đồ uống", PanelContainer = panelDoUong1, pictureBox = picDouong1 });
            products.Add(new Product { Id = "D002", Name = "Nước chanh dây", Price = 26000, Category = "Đồ uống", PanelContainer = panelDoUong2, pictureBox = picDouong2 });

            // Combo
            products.Add(new Product { Id = "C001", Name = "Combo bánh tráng", Price = 38000, Category = "Combo", PanelContainer = panelCombo1, pictureBox = picCombo1 });
            products.Add(new Product { Id = "C002", Name = "Combo trái cây", Price = 40000, Category = "Combo", PanelContainer = panelCombo2, pictureBox = picCombo2 });
            products.Add(new Product { Id = "C003", Name = "Combo gà", Price = 92000, Category = "Combo", PanelContainer = panelCombo3, pictureBox = picCombo3 });
            products.Add(new Product { Id = "C004", Name = "Combo khoai", Price = 55000, Category = "Combo", PanelContainer = panelCombo4, pictureBox = picCombo4 });
            products.Add(new Product { Id = "C005", Name = "Combo đồ uống", Price = 45000, Category = "Combo", PanelContainer = panelCombo5, pictureBox = picCombo5 });
        }

        // Đăng ký sự kiện click cho từng PictureBox chứa sản phẩm (đầy đủ sản phẩm)
        private void RegisterPictureBoxEvents()
        {
            foreach (var p in products)
            {
                if (p.pictureBox != null)
                {
                    p.pictureBox.Click += (s, e) => AddProductToInvoice(p.Id, p.Name, p.Price);
                }
            }
        }

        // Đăng ký sự kiện các nút thao tác
        private void RegisterButtonEvents()
        {
            btnAdd.Click += BtnAdd_Click;
            btnDecrease.Click += BtnDecrease_Click;
            btnDelete.Click += BtnDelete_Click;
            btnDeleteAll.Click += BtnDeleteAll_Click;
            btnPay.Click += BtnPay_Click;
            nmDiscount.ValueChanged += NmDiscount_ValueChanged;
            txtPayment.TextChanged += TxtPayment_TextChanged;
        }

        // Xử lý chọn ComboBox loại sản phẩm để ẩn/hiện group PictureBox tương ứng
        private void CbItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategory = cbItem.SelectedItem?.ToString();
            if (string.IsNullOrEmpty(selectedCategory)) return;

            // Ẩn tất cả panel của sản phẩm
            foreach (var p in products)
            {
                if (p.PanelContainer != null)
                    p.PanelContainer.Visible = false;
            }
            // Hiện các panel của sản phẩm trong category và dồn sát trên cùng
            int yPos = 0;
            int spacing = 10; // khoảng cách giữa các panel
            var categoryProducts = products.Where(p => p.Category == selectedCategory).ToList();
            foreach (var p in categoryProducts)
            {
                if (p.PanelContainer != null)
                {
                    p.PanelContainer.Visible = true;
                    p.PanelContainer.Top = yPos;
                    yPos += p.PanelContainer.Height + spacing;
                }
            }
        }

        // Thêm sản phẩm vào hóa đơn ListView
        private void AddProductToInvoice(string productId, string productName, decimal price)
        {
            var existingItem = lvInvoice.Items.Cast<ListViewItem>().FirstOrDefault(i => i.SubItems[0].Text == productId);
            if (existingItem != null)
            {
                int quantity = int.Parse(existingItem.SubItems[3].Text);
                quantity++;
                existingItem.SubItems[3].Text = quantity.ToString();
            }
            else
            {
                var item = new ListViewItem(productId);
                item.SubItems.Add(productName);
                item.SubItems.Add(price.ToString("N0"));
                item.SubItems.Add("1");
                lvInvoice.Items.Add(item);
            }
            UpdateTotalAmount();
        }

        // Nút thêm số lượng sản phẩm được chọn
        private void BtnAdd_Click(object sender, EventArgs e)
        {
            if (lvInvoice.SelectedItems.Count == 0)
            {
                MessageBox.Show("Vui lòng chọn sản phẩm để thêm số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            var item = lvInvoice.SelectedItems[0];
            int quantity = int.Parse(item.SubItems[3].Text);
            quantity++;
            item.SubItems[3].Text = quantity.ToString();
            UpdateTotalAmount();
        }

        // Nút giảm số lượng sản phẩm được chọn
        private void BtnDecrease_Click(object sender, EventArgs e)
        {
            if (lvInvoice.SelectedItems.Count == 0)
            {
                MessageBox.Show("Vui lòng chọn sản phẩm để giảm số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            var item = lvInvoice.SelectedItems[0];
            int quantity = int.Parse(item.SubItems[3].Text);
            if (quantity > 1)
            {
                quantity--;
                item.SubItems[3].Text = quantity.ToString();
                UpdateTotalAmount();
            }
            else
            {
                MessageBox.Show("Số lượng không thể nhỏ hơn 1", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // Nút xóa sản phẩm được chọn
        private void BtnDelete_Click(object sender, EventArgs e)
        {
            if (lvInvoice.SelectedItems.Count == 0)
            {
                MessageBox.Show("Vui lòng chọn sản phẩm để xóa", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            lvInvoice.Items.Remove(lvInvoice.SelectedItems[0]);
            UpdateTotalAmount();
        }

        // Nút xóa toàn bộ sản phẩm
        private void BtnDeleteAll_Click(object sender, EventArgs e)
        {
            lvInvoice.Items.Clear();
            UpdateTotalAmount();
        }

        // Cập nhật tổng tiền, thành tiền theo sản phẩm và chiết khấu
        private void UpdateTotalAmount()
        {
            decimal total = 0;
            foreach (ListViewItem item in lvInvoice.Items)
            {
                decimal price = decimal.Parse(item.SubItems[2].Text, System.Globalization.NumberStyles.Number);
                int quantity = int.Parse(item.SubItems[3].Text);
                total += price * quantity;
            }
            totalAmount = total;
            txtInto_Money.Text = totalAmount.ToString("N0");

            decimal discount = nmDiscount.Value;
            decimal afterDiscount = totalAmount - (totalAmount * discount / 100);
            if (afterDiscount < 0) afterDiscount = 0;

            txtTotoal_Amount.Text = afterDiscount.ToString("N0");
            UpdateChangeMoney();
        }

        // Khi thay đổi giá trị chiết khấu
        private void NmDiscount_ValueChanged(object sender, EventArgs e)
        {
            UpdateTotalAmount();
        }

        // Khi thay đổi số tiền khách trả
        private void TxtPayment_TextChanged(object sender, EventArgs e)
        {
            UpdateChangeMoney();
        }

        // Cập nhật tiền thối
        private void UpdateChangeMoney()
        {
            decimal payment = 0;
            decimal.TryParse(txtPayment.Text, System.Globalization.NumberStyles.Number, null, out payment);

            decimal totalPayable = 0;
            decimal.TryParse(txtTotoal_Amount.Text, System.Globalization.NumberStyles.Number, null, out totalPayable);

            decimal change = payment - totalPayable;
            txtChange.Text = change >= 0 ? change.ToString("N0") : "0";
        }

        // Xử lý nút thanh toán
        private void BtnPay_Click(object sender, EventArgs e)
        {
            if (lvInvoice.Items.Count == 0)
            {
                MessageBox.Show("Chưa có sản phẩm trong hóa đơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            decimal payment;
            if (!decimal.TryParse(txtPayment.Text, out payment))
            {
                MessageBox.Show("Vui lòng nhập số tiền thanh toán hợp lệ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            decimal totalPayable;
            decimal.TryParse(txtTotoal_Amount.Text, out totalPayable);

            if (payment < totalPayable)
            {
                MessageBox.Show("Số tiền thanh toán không đủ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            MessageBox.Show($"Thanh toán thành công!\nThành tiền: {totalPayable.ToString("N0")}\nTiền trả: {payment.ToString("N0")}\nTiền thối: {(payment - totalPayable).ToString("N0")}",
                "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

            // Reset hóa đơn và các trường
            lvInvoice.Items.Clear();
            nmDiscount.Value = 0;
            txtPayment.Text = "";
            txtChange.Text = "0";
            txtInto_Money.Text = "0";
            txtTotoal_Amount.Text = "0";

            // Đặt comboBox về đồ uống mặc định và ẩn hiện sản phẩm tương ứng
            cbItem.SelectedItem = "Đồ uống";
        }

        // Xử lý menu thông tin tài khoản
        private void thôngTinTàiKhoảnToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AccountInformation accountInformation = new AccountInformation(userId);
            accountInformation.Show();
        }

        // Xử lý menu đăng xuất
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Bạn có muốn thoát không?", "Thông báo", MessageBoxButtons.OKCancel);
            if (result == DialogResult.OK)
            {
                this.Hide();
                login loginForm = new login();
                loginForm.Show();
            }
        }

        private void Staff_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có muốn thoát không?", "Thông báo", MessageBoxButtons.OKCancel) == DialogResult.Cancel)
            {
                e.Cancel = true;
            }
            else
            {
                login login = new login();
                login.Show();
            }
        }
    }
}