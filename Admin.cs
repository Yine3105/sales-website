using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace Quan_Ly_Cua_Hang_Do_An_Vat
{
    public partial class Admin : Form
    {
        public Admin()
        {
            InitializeComponent();
            LoadCompanyList();
            LoadDepartmentList();
            LoadEmployeeList();
            LoadCustomerList();
            LoadItemList();
            LoadVoucherList();
            LoadWarehouseList();
            LoadInvoiceList();
            btnThongKe_Ngay.Click += btnThongKe_Ngay_Click;
            btnThongketheoThang.Click += btnThongketheoThang_Click;

        }
        private int userId;

        public Admin(int userId)
        {
            InitializeComponent();
            this.userId = userId;
            this.dtgvCompany.SelectionChanged += new System.EventHandler(this.dtgvCompany_SelectionChanged);
            this.txtCompany_search.TextChanged += new System.EventHandler(this.txtCompany_search_TextChanged);
            this.dtgvDepartment.SelectionChanged += new System.EventHandler(this.dtgvDepartment_SelectionChanged);
            this.txtDepartment_search.TextChanged += new System.EventHandler(this.txtDepartment_search_TextChanged);
            this.dtgvEmployee.SelectionChanged += new System.EventHandler(this.dtgvEmployee_SelectionChanged);
            this.txtEmployee_search.TextChanged += new System.EventHandler(this.txtEmployee_search_TextChanged);
            this.dtgvCustomer.SelectionChanged += new System.EventHandler(this.dtgvCustomer_SelectionChanged);
            this.txtCustomer_search.TextChanged += new System.EventHandler(this.txtEmployee_search_TextChanged);
            this.dtgvItem.SelectionChanged += new System.EventHandler(this.dtgvItem_SelectionChanged);
            this.txtItem_search.TextChanged += new System.EventHandler(this.txtItem_search_TextChanged);
            this.dtgvVoucher.SelectionChanged += new System.EventHandler(this.dtgvVoucher_SelectionChanged);
            this.txtVoucher_search.TextChanged += new System.EventHandler(this.txtVoucher_search_TextChanged);
            this.dtgvWarehouse.SelectionChanged += new System.EventHandler(this.dtgvWarehouse_SelectionChanged);
            this.txtWarehouse_search.TextChanged += new System.EventHandler(this.txtWarehouse_search_TextChanged);
            LoadUserInfo(userId);
            LoadCompanyList();
            LoadDepartmentList();
            LoadEmployeeList();
            LoadCustomerList();
            LoadItemList();
            LoadVoucherList();
            LoadWarehouseList();
            LoadInvoiceList();
            btnThongKe_Ngay.Click += btnThongKe_Ngay_Click;
            btnThongketheoThang.Click += btnThongketheoThang_Click;
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
        void LoadCompanyList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT company_id, company_code, company_name, company_address, company_phone, company_email FROM company WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvCompany.DataSource = data;
        }
        private void dtgvCompany_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvCompany.CurrentRow != null)
            {
                txtCompany_id.Text = dtgvCompany.CurrentRow.Cells["company_id"].Value?.ToString();
                txtCompany_code.Text = dtgvCompany.CurrentRow.Cells["company_code"].Value?.ToString();
                txtCompany_name.Text = dtgvCompany.CurrentRow.Cells["company_name"].Value?.ToString();
            }
        }
        private void txtCompany_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtCompany_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT company_id, company_code, company_name, company_address, company_phone, company_email
                FROM company
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND company_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvCompany.DataSource = data;
        }

        void LoadDepartmentList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT department_id, department_code, department_name FROM department WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvDepartment.DataSource = data;
        }

        private void btnAdmin_Exit_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Bạn có muốn thoát không?", "Thông báo", MessageBoxButtons.OKCancel);
            if (result == DialogResult.OK)
            {
                this.Hide();
                login loginForm = new login();
                loginForm.Show();
            }
        }

        private void Admin_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có muốn thoát không?", "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.Cancel)
            {
                e.Cancel = true;
            }
            login login = new login();
            login.Show();
        }

        private void btnCompany_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.company.CompanyUpdate();
            updateForm.OnUpdateSuccess += LoadCompanyList;
            updateForm.ShowDialog();
        }

        private void btnCompany_update_Click(object sender, EventArgs e)
        {
            if (dtgvCompany.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn công ty cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvCompany.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.company.CompanyUpdate();
            updateForm.SetCompanyData(
                row.Cells["company_id"].Value.ToString(),
                row.Cells["company_code"].Value.ToString(),
                row.Cells["company_name"].Value.ToString(),
                row.Cells["company_address"].Value.ToString(),
                row.Cells["company_phone"].Value.ToString(),
                row.Cells["company_email"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadCompanyList;
            updateForm.ShowDialog();
        }

        private void btnCompany_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCompany_id.Text))
            {
                MessageBox.Show("Vui lòng chọn công ty cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa công ty này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE company SET is_delete = 1 WHERE company_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtCompany_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadCompanyList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }

        private void dtgvDepartment_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvDepartment.CurrentRow != null)
            {
                txtDepartment_id.Text = dtgvDepartment.CurrentRow.Cells["department_id"].Value?.ToString();
                txtDepartment_code.Text = dtgvDepartment.CurrentRow.Cells["department_code"].Value?.ToString();
                txtDepartment_name.Text = dtgvDepartment.CurrentRow.Cells["department_name"].Value?.ToString();
            }
        }

        private void txtDepartment_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtDepartment_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT department_id, department_code, department_name, department_address, department_phone, department_email
                FROM department
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND department_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvDepartment.DataSource = data;
        }
        private void btnDepartment_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.DepartmentUpdate();
            updateForm.OnUpdateSuccess += LoadDepartmentList;
            updateForm.ShowDialog();
        }

        private void btnDepartment_update_Click(object sender, EventArgs e)
        {
            if (dtgvDepartment.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn bộ phận cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvDepartment.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.DepartmentUpdate();
            updateForm.SetDepartmentData(
                row.Cells["department_id"].Value.ToString(),
                row.Cells["department_code"].Value.ToString(),
                row.Cells["department_name"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadDepartmentList;
            updateForm.ShowDialog();
        }

        private void btnDepartment_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtDepartment_id.Text))
            {
                MessageBox.Show("Vui lòng chọn bộ phận cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa bộ phận này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE department SET is_delete = 1 WHERE department_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtDepartment_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadDepartmentList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }
        void LoadEmployeeList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT employee_id, employee_code, employee_first_name, employee_last_name, employee_gender, employee_birth, department_id, note FROM employee WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvEmployee.DataSource = data;
        }
        private void dtgvEmployee_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvEmployee.CurrentRow != null)
            {
                txtEmployee_id.Text = dtgvEmployee.CurrentRow.Cells["employee_id"].Value?.ToString();
                txtEmployee_code1.Text = dtgvEmployee.CurrentRow.Cells["employee_code"].Value?.ToString();
                txtEmployee_name1.Text = dtgvEmployee.CurrentRow.Cells["employee_last_name"].Value?.ToString();
            }
        }
        
        private void btnEmployee_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.EmployeeUpdate();
            updateForm.OnUpdateSuccess += LoadEmployeeList;
            updateForm.ShowDialog();
        }

        private void btnEmployee_update_Click(object sender, EventArgs e)
        {
            if (dtgvEmployee.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn nhân viên cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvEmployee.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.EmployeeUpdate();
            updateForm.SetEmployeeData(
                row.Cells["employee_id"].Value.ToString(),
                row.Cells["employee_code"].Value.ToString(),
                row.Cells["employee_first_name"].Value.ToString(),
                row.Cells["employee_last_name"].Value.ToString(),
                row.Cells["employee_address"].Value.ToString(),
                row.Cells["employee_phone"].Value.ToString(),
                row.Cells["employee_email"].Value.ToString(),
                row.Cells["employee_birth"].Value.ToString(),
                row.Cells["employee_gender"].Value.ToString(),
                row.Cells["department_id"].Value.ToString(),
                row.Cells["note"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadEmployeeList;
            updateForm.ShowDialog();
        }

        private void btnEmployee_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtEmployee_id.Text))
            {
                MessageBox.Show("Vui lòng chọn nhân viên cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa nhân viên này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE employee SET is_delete = 1 WHERE employee_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtEmployee_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadEmployeeList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }

        private void txtEmployee_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtEmployee_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT employee_id, employee_code, employee_last_name, employee_address, employee_phone, employee_email
                FROM employee
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND employee_last_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvEmployee.DataSource = data;
        }
        void LoadCustomerList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT customer_id, customer_code, customer_first_name, customer_last_name FROM customer WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvCustomer.DataSource = data;
        }
        private void dtgvCustomer_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvCustomer.CurrentRow != null)
            {
                txtCustomer_id.Text = dtgvCustomer.CurrentRow.Cells["customer_id"].Value?.ToString();
                txtCustomer_code.Text = dtgvCustomer.CurrentRow.Cells["customer_code"].Value?.ToString();
                txtCustomer_name.Text = dtgvCustomer.CurrentRow.Cells["customer_last_name"].Value?.ToString();
            }
        }

        private void btnCustomer_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.EmployeeUpdate();
            updateForm.OnUpdateSuccess += LoadCustomerList;
            updateForm.ShowDialog();
        }

        private void btnCustomer_update_Click(object sender, EventArgs e)
        {
            if (dtgvCustomer.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn khách hàng cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvCustomer.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.CustomerUpdate();
            updateForm.SetCustomerData(
                row.Cells["employee_id"].Value.ToString(),
                row.Cells["employee_code"].Value.ToString(),
                row.Cells["employee_first_name"].Value.ToString(),
                row.Cells["employee_last_name"].Value.ToString(),
                row.Cells["employee_address"].Value.ToString(),
                row.Cells["employee_phone"].Value.ToString(),
                row.Cells["employee_email"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadCustomerList;
            updateForm.ShowDialog();
        }

        private void btnCustomer_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCustomer_id.Text))
            {
                MessageBox.Show("Vui lòng chọn khách hàng cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa nhân viên này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE customer SET is_delete = 1 WHERE customer_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtCustomer_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadEmployeeList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }

        private void txtCustomer_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtCustomer_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT customer_id, customer_code, customer_last_name, customer_address, customer_phone, customer_email
                FROM customer
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND customer_last_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvCustomer.DataSource = data;
        }
        void LoadItemList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT item_id, item_code, item_name FROM item WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvItem.DataSource = data;
        }
        private void dtgvItem_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvItem.CurrentRow != null)
            {
                txtItem_id.Text = dtgvItem.CurrentRow.Cells["item_id"].Value?.ToString();
                txtItem_code.Text = dtgvItem.CurrentRow.Cells["item_code"].Value?.ToString();
                txtItem_name.Text = dtgvItem.CurrentRow.Cells["item_name"].Value?.ToString();
            }
        }

        private void txtItem_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtItem_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT item_id, item_code, item_name, item_retail, item_cost_price
                FROM item
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND item_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvItem.DataSource = data;
        }
        private void btnItem_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.ItemUpdate();
            updateForm.OnUpdateSuccess += LoadItemList;
            updateForm.ShowDialog();
        }

        private void btnItem_update_Click(object sender, EventArgs e)
        {
            if (dtgvItem.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn sản phẩm cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvItem.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.ItemUpdate();
            updateForm.SetItemData(
                row.Cells["item_id"].Value.ToString(),
                row.Cells["item_code"].Value.ToString(),
                row.Cells["item_name"].Value.ToString(),
                row.Cells["item_retail"].Value.ToString(),
                row.Cells["item_cost_price"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadItemList;
            updateForm.ShowDialog();
        }

        private void btnItem_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtItem_id.Text))
            {
                MessageBox.Show("Vui lòng chọn sản phẩm cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa sản phẩm này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE item SET is_delete = 1 WHERE item_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtItem_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadItemList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }
        void LoadVoucherList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT voucher_id, voucher_name, voucher_value FROM voucher WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvVoucher.DataSource = data;
        }
        private void dtgvVoucher_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvVoucher.CurrentRow != null)
            {
                txtVoucher_id.Text = dtgvVoucher.CurrentRow.Cells["voucher_id"].Value?.ToString();
                txtVoucher_name.Text = dtgvVoucher.CurrentRow.Cells["voucher_name"].Value?.ToString();
            }
        }

        private void txtVoucher_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtVoucher_search.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT voucher_name, voucher_value
                FROM voucher
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND voucher_name LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvVoucher.DataSource = data;
        }
        private void btnVoucher_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.VoucherUpdate();
            updateForm.OnUpdateSuccess += LoadVoucherList;
            updateForm.ShowDialog();
        }

        private void btnVoucher_update_Click(object sender, EventArgs e)
        {
            if (dtgvVoucher.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn voucher cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvVoucher.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.VoucherUpdate();
            updateForm.SetVoucherData(
                row.Cells["voucher_id"].Value.ToString(),
                row.Cells["voucher_name"].Value.ToString(),
                row.Cells["voucher_value"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadVoucherList;
            updateForm.ShowDialog();
        }

        private void btnVoucher_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtVoucher_id.Text))
            {
                MessageBox.Show("Vui lòng chọn voucher cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa voucher này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE voucher SET is_delete = 1 WHERE voucher_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtVoucher_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadCompanyList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }
        void LoadWarehouseList()
        {
            DataProvider provider = new DataProvider();
            string query = "SELECT warehouse_id, warehouse_code, note, item_id, quantity FROM warehouse WHERE is_delete = 0 OR is_delete IS NULL";
            DataTable data = provider.ExcuteQuery(query);
            dtgvWarehouse.DataSource = data;
        }
        private void dtgvWarehouse_SelectionChanged(object sender, EventArgs e)
        {
            if (dtgvWarehouse.CurrentRow != null)
            {
                txtWarehouse_id.Text = dtgvWarehouse.CurrentRow.Cells["warehouse_id"].Value?.ToString();
                txtWarehouse_code.Text = dtgvWarehouse.CurrentRow.Cells["warehouse_code"].Value?.ToString();
                txtWarehouse_name.Text = dtgvWarehouse.CurrentRow.Cells["note"].Value?.ToString();
            }
        }

        private void txtWarehouse_search_TextChanged(object sender, EventArgs e)
        {
            string searchText = txtWarehouse_id.Text.Trim();
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT warehouse_code, note
                FROM warehouse
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND note LIKE @search";
            DataTable data = provider.ExcuteQuery(query, new object[] { "%" + searchText + "%" });
            dtgvWarehouse.DataSource = data;
        }
        private void btnWarehouse_add_Click(object sender, EventArgs e)
        {
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.WarehouseUpdate();
            updateForm.OnUpdateSuccess += LoadWarehouseList;
            updateForm.ShowDialog();
        }

        private void btnWarehouse_update_Click(object sender, EventArgs e)
        {
            if (dtgvWarehouse.CurrentRow == null)
            {
                MessageBox.Show("Vui lòng chọn kho cần sửa!");
                return;
            }
            DataGridViewRow row = dtgvWarehouse.CurrentRow;
            var updateForm = new Quan_Ly_Cua_Hang_Do_An_Vat.update.WarehouseUpdate();
            updateForm.SetWarehouseData(
                row.Cells["warehouse_id"].Value.ToString(),
                row.Cells["warehouse_code"].Value.ToString(),
                row.Cells["note"].Value.ToString()
            );
            updateForm.OnUpdateSuccess += LoadWarehouseList;
            updateForm.ShowDialog();
        }

        private void btnWarehouse_delete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtWarehouse_id.Text))
            {
                MessageBox.Show("Vui lòng chọn kho cần xóa!");
                return;
            }
            var result = MessageBox.Show("Bạn có chắc muốn xóa kho này?", "Xác nhận", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataProvider provider = new DataProvider();
                string query = "UPDATE warehouse SET is_delete = 1 WHERE warehouse_id = @id";
                int rows = provider.ExcuteNonQuery(query, new object[] { txtWarehouse_id.Text });
                if (rows > 0)
                {
                    MessageBox.Show("Xóa thành công!");
                    LoadCompanyList();
                }
                else
                {
                    MessageBox.Show("Xóa thất bại!");
                }
            }
        }
        // Phương thức load danh sách hóa đơn
        public void LoadInvoiceList()
        {
            DataProvider provider = new DataProvider();
            string query = @"
                SELECT invoice_id,
                       invoice_code,
                       create_date,
                       invoice_total,
                       create_by,
                       customer_id
                FROM invoice
                WHERE is_delete = 0 OR is_delete IS NULL
                ORDER BY create_date DESC";
            DataTable data = provider.ExcuteQuery(query);
            dtgvInvoice.DataSource = data;
        }
        private void btnThongKe_Ngay_Click(object sender, EventArgs e)
        {
            DateTime from = dtpFromDay.Value.Date; // Ngày bắt đầu
            DateTime to = dtpToTime.Value.Date; // Ngày kết thúc
            string query = @"
        SELECT 
            CAST(create_date AS DATE) AS [Ngày],
            SUM(invoice_total) AS [Tổng doanh thu]
        FROM invoice
        WHERE create_date BETWEEN @fromDate AND @toDate
        GROUP BY CAST(create_date AS DATE)
        ORDER BY [Ngày]";
            DataProvider provider = new DataProvider();
            // Đảm bảo cả hai tham số được truyền dưới dạng mảng đối tượng
            DataTable dt = provider.ExcuteQuery(query, new object[] { from, to });
            dtgvDoanhthutheongay.DataSource = dt;
        }

        private void btnThongketheoThang_Click(object sender, EventArgs e)
        {
            DateTime selected = dtpThangNam.Value;
            int month = selected.Month;
            int year = selected.Year;

            string query = @"
        SELECT 
            FORMAT(create_date, 'yyyy-MM') AS [Tháng],
            SUM(invoice_total) AS [Tổng doanh thu]
        FROM invoice
        WHERE YEAR(create_date) = @year AND MONTH(create_date) = @month
        GROUP BY FORMAT(create_date, 'yyyy-MM')
        ORDER BY [Tháng]";

            DataProvider provider = new DataProvider();
            DataTable dt = provider.ExcuteQuery(query, new object[] { year, month });
            dtgvThongKetheothang.DataSource = dt;
        }

    }
}