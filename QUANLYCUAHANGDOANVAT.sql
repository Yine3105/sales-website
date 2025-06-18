create database QLCHAV
use QLCHAV

create table company(
company_id int identity(1,1) primary key,
company_code nvarchar(50) not null,
company_name nvarchar(max) not null,
company_address nvarchar(max) not null,
company_phone nvarchar(13) not null,
company_email nvarchar(max) not null,
company_fax nvarchar(100) not null,
company_hotline nvarchar(13),
note nvarchar(max),
is_delete bit,
create_by int not null,
create_date datetime not null,
update_by int,
update_date datetime,
)
create table shop(
shop_id int identity(1, 1) primary key,
shop_name nvarchar(max) not null,
shop_email nvarchar(100) ,
shop_fax nvarchar(100),
shop_hotline nvarchar(13),
shop_phone_number nvarchar(13),
company_id int not null foreign key references company(company_id),
note nvarchar(max),
is_delete bit,
create_by int not null,
create_date datetime not null,
update_by int,
update_date datetime,
)
create table department(
department_id int identity(1,1) primary key,
department_name nvarchar(max) not null,
department_code nvarchar(50),
shop_id int not null foreign key references shop(shop_id),
company_id int not null foreign key references company(company_id), 
note nvarchar(max),
is_delete bit,
create_by int not null,
create_date datetime not null,
update_by int,
update_date datetime,
)
create table employee(
employee_id int identity(1,1) primary key,
employee_code nvarchar(50) not null,
employee_first_name nvarchar(max) not null,
employee_last_name nvarchar(max) not null,
employee_address nvarchar(max),
employee_birth datetime not null,
employee_phone nvarchar(13) not null,
employee_email nvarchar(max) not null,
employee_gender bit,
department_id int not null foreign key references department(department_id),
note nvarchar(max),
is_delete bit,
create_by int not null,
create_date datetime not null,
update_by int,
update_date datetime,
)
create table customer(
customer_id int identity(1,1) primary key,
customer_code nvarchar(50),
customer_first_name nvarchar(max) not null,
customer_last_name nvarchar(max) not null,
customer_address nvarchar(max),
customer_birth datetime,
customer_phone nvarchar(13),
customer_email nvarchar(max),
customer_gender bit,
customer_type bit,
customer_debts money,
customer_point int,
note nvarchar(max),
is_delete bit,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
)
create table system_log(
id int identity(1,1) primary key,
date datetime not null,
is_select bit,
is_add bit,
is_update bit,
is_delete bit,
is_accept bit,
note nvarchar(max),
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int not null foreign key references employee(employee_id),
update_date datetime,
)
create table unit(
unit_id int identity(1, 1) primary key,
unit_name nvarchar(50) not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)
create table item(
item_id int identity(1, 1) primary key,
item_code nvarchar(100) not null,
item_name nvarchar(max) not null,
item_image nvarchar(max) not null,
item_retail money not null,
item_cost_price money not null,
combo_price money null,
unit_id int foreign key references unit(unit_id) not null,
item_wholesale money not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)

create table category_item(
category_item_id int identity(1, 1) primary key,
category_item_code nvarchar(50) not null,
category_item_name nvarchar(max) not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)
create table component_item(
component_item_id int identity(1, 1) primary key,
item_product_id int foreign key references item(item_id) not null,
item_component_id int not null,
item_component_name nvarchar(max) not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)
create table combo(
combo_id int identity(1, 1) primary key,
combo_name nvarchar(max) not null,
combo_sell_price money not null,
combo_code nvarchar(50) not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)
create table combo_detail(
id int identity(1, 1) primary key,
combo_id int foreign key references combo(combo_id) not null,
item_id int foreign key references item(item_id) not null,
quantity float not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)

create table vendor(
vendor_id int identity(1, 1) primary key,
vendor_code nvarchar(50) null,
vendor_name nvarchar(max) not null,
vendor_phone nvarchar(50) not null,
vendor_address nvarchar(max) null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
note nvarchar(max) null,
is_delete bit null,
update_date datetime null
)
create table warehouse(
warehouse_id int identity(1, 1) primary key,
warehouse_code nvarchar(100) not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
update_date datetime null,
shop_id int foreign key references shop(shop_id) null,
note nvarchar(max) null,
is_delete bit,
company_id int foreign key references company(company_id) null,
item_id int not null,
quantity float not null
)
select warehouse_id from warehouse;

create table warehouse_item(
warehouse_item_id int identity(1, 1) primary key,
warehouse_id int foreign key references warehouse(warehouse_id) not null,
price money not null,
is_delete bit not null,
create_by int foreign key references employee(employee_id) not null,
create_date datetime not null,
update_by int foreign key references employee(employee_id) null,
update_date datetime null,
note nvarchar(max) null
)
create table stock_receipt_note(
stock_receipt_note_id int identity(1,1) primary key,
stock_receipt_note_code nvarchar(100) not null,
stock_total money not null,
vendor_id int not null foreign key references vendor(vendor_id),
date datetime not null,
stock_amount_paid money not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
warehouse_id int not null foreign key references warehouse(warehouse_id),
note nvarchar(max),
is_delete bit
)
create table stock_receipt_note_detail(
id int identity(1,1) primary key,
stock_receipt_note_id int not null foreign key references stock_receipt_note(stock_receipt_note_id),
item_id int not null foreign key references item(item_id),
quantity float not null,
price money not null,
total money not null,
note nvarchar(max),
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
is_delete bit,
update_date datetime
)

create table voucher(
voucher_id int identity(1, 1) primary key,
voucher_name nvarchar(max) not null,
voucher_value money not null,
voucher_expire datetime not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
is_using bit not null,
customer_id int not null foreign key references customer(customer_id),
is_delete bit,
voucher_discount_percents int,
note nvarchar(max) 
)
create table invoice(
invoice_id int identity(1, 1) primary key,
invoice_code nvarchar(100) not null,
invoice_discount_percent int,
invoice_total money not null,
invoice_discount_total money,
invoice_VAT_percent int,
invoice_voucher_total money,
invoice_VAT_total money,
invoice_other_total money,
invoice_final_amount money not null,
is_print bit,
date datetime not null,
customer_id int not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
is_delete bit,
note nvarchar(max),
shop_id int not null foreign key references shop(shop_id)
)
create table invoice_detail (
invoice_detail_id int identity(1, 1) primary key,
invoice_id int not null foreign key references invoice(invoice_id),
item_id int not null foreign key references item(item_id),
quantity float not null,
total money not null,
discount_percent int,
discount_total money,
final_amount money not null,
is_delete bit not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
note nvarchar(max)
)
create table invoice_voucher(
id int identity(1, 1) primary key,
voucher_id int not null foreign key references voucher(voucher_id),
invoice_id int not null foreign key references invoice(invoice_id),
is_delete bit,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
note nvarchar(max) 
)

create table category_receipt(
category_receipt_id int identity(1, 1) primary key,
category_receipt_name nvarchar(max) not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
note nvarchar(max),
is_delete bit
)
create table receipt(
receipt_id int identity(1, 1) primary key,
receipt_code nvarchar(100) not null,
invoice_id int not null foreign key references invoice(invoice_id),
receipt_total money not null,
receipt_amount_paid money not null,
date datetime not null,
receipt_change money,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
update_date datetime,
category_receipt_id int not null foreign key references category_receipt(category_receipt_id),
note nvarchar(max),
customer_id int not null foreign key references customer(customer_id),
is_delete bit
)
create table payment(
payment_id int identity(1,1) primary key,
payment_code nvarchar(50) not null,
payment_total money not null,
date datetime not null,
payment_object int not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime
)
create table category_payment(
category_payment_id int identity(1,1) primary key,
category_payment_name nvarchar(max) not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime
)
create table customer_return(
customer_return_id int identity(1,1) primary key,
customer_return_code nvarchar(50) not null,
customer_id int not null foreign key references customer(customer_id),
invoice_id int not null foreign key references invoice(invoice_id),
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
date datetime not null
)
create table vendor_return(
vendor_return_id int identity(1, 1) primary key,
vendor_return_code nvarchar(50) not null,
vendor_id int not null foreign key references vendor(vendor_id),
stock_receipt_note_id int foreign key references stock_receipt_note(stock_receipt_note_id),
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
date datetime not null
)
create table vendor_return_detail(
id int identity(1, 1) primary key,
item_id int not null foreign key references item(item_id),
quantity float not null,
price money,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
)
create table inventory_ledger(
id int identity(1, 1) primary key,
code nvarchar(50) not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
date datetime not null,
item_id int not null foreign key references item(item_id),
shop_id int not null foreign key references shop(shop_id),
cost_price money not null,
sell_price money
)
create table stock_transfer_note(
stock_transfer_note_id int identity(1, 1) primary key,
stock_transfer_note_code nvarchar(50),
date datetime not null,
from_ int not null foreign key references warehouse(warehouse_id),
to_ int not null foreign key references warehouse(warehouse_id),
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
)
create table stock_transfer_note_detail(
id int identity(1, 1) primary key,
stock_transfer_note_id int not null foreign key references stock_transfer_note(stock_transfer_note_id),
item_id int not null foreign key references item(item_id),
quantity float not null,
create_by int not null foreign key references employee(employee_id),
create_date datetime not null,
update_by int foreign key references employee(employee_id),
note nvarchar(max),
is_delete bit,
update_date datetime,
)
-- Thêm dữ liệu

-- Thêm dữ liệu vào bảng company
INSERT INTO company (company_code, company_name, company_address, company_phone, company_email, company_fax, company_hotline, note, is_delete, create_by, create_date, update_by, update_date)
VALUES
('CT01', N'Công ty TNHH Đồ ăn vặt Khánh Hòa', N'10 Nguyễn Trãi, TP. Nha Trang, Khánh Hòa', '02583812345', 'info@doanvatkhanhhoa.com', '02583812346', '18001234', N'Công ty chuyên cung cấp đồ ăn vặt', 0, 1, '2024-10-20 00:00:00', 1, '2024-10-25 00:00:00');
-- Thêm dữ liệu vào bảng shop
INSERT INTO shop (shop_name, shop_email, shop_fax, shop_hotline, shop_phone_number, company_id, note, is_delete, create_by, create_date, update_by, update_date)
VALUES
(N'Cửa hàng Bánh Tráng Trộn', 'btt@doanvatkhanhhoa.com', '02583812348', '18001235', '0912345679', 1, N'Chi nhánh chính', 0, 1, '2024-11-01 00:00:00', 1, '2024-11-05 00:00:00'),
(N'Cửa hàng Ăn vặt', 'avnt@doanvatkhanhhoa.com', '02583812349', '18001236', '0987654321', 1, N'Chi nhánh 2', 0, 2, '2024-11-10 00:00:00', 2, '2024-11-15 00:00:00');
-- Thêm dữ liệu vào bảng department
INSERT INTO department (department_name, department_code, shop_id, company_id, note, is_delete, create_by, create_date, update_by, update_date)
VALUES
(N'Quản lý', 'QL', 1, 1, N'Bộ phận quản lý cửa hàng', 0, 1, '2024-11-22 00:00:00', 1, '2024-11-28 00:00:00'),
(N'Bán hàng', 'BH', 1, 1, N'Bộ phận bán hàng', 0, 1, '2024-12-03 00:00:00', 1, '2024-12-08 00:00:00'),
(N'Thu ngân', 'TN', 1, 1, N'Bộ phận thu ngân', 0, 2, '2024-12-12 00:00:00', 2, '2024-12-17 00:00:00'),
(N'Pha chế', 'PC', 2, 1, N'Bộ phận pha chế đồ uống', 0, 2, '2025-01-03 00:00:00', 2, '2025-01-08 00:00:00'),
(N'Marketing', 'MK', 1, 1, N'Bộ phận marketing', 0, 3, '2025-01-12 00:00:00', 3, '2025-01-17 00:00:00');
-- Thêm dữ liệu vào bảng employee
INSERT INTO employee (employee_code, employee_first_name, employee_last_name, employee_address, employee_birth, employee_phone, employee_email, employee_gender, department_id, note, is_delete, create_by, create_date, update_by, update_date)
VALUES
('NV001', N'Nguyễn', N'Thị A', N'77 Lê Thánh Tôn, Nha Trang', '1998-02-12 00:00:00', '0931234567', 'thia@gmail.com', 0, 1, N'Quản lý cửa hàng', 0, 1, '2024-11-25 00:00:00', 1, '2024-12-01 00:00:00'),
('NV002', N'Trần', N'Văn B', N'88 Hoàng Văn Thụ, Nha Trang', '1995-07-28 00:00:00', '0932345678', 'vanb@gmail.com', 1, 2, N'Nhân viên bán hàng', 0, 1, '2024-12-05 00:00:00', 1, '2024-12-10 00:00:00'),
('NV003', N'Lê', N'Thị C', N'99 Thống Nhất, Nha Trang', '2000-11-05 00:00:00', '0933456789', 'thic@gmail.com', 0, 3, N'Nhân viên thu ngân', 0, 2, '2024-12-15 00:00:00', 2, '2024-12-20 00:00:00'),
('NV004', N'Phạm', N'Văn D', N'100 Nguyễn Thị Minh Khai, Nha Trang', '1993-09-20 00:00:00', '0934567890', 'vand@gmail.com', 1, 4, N'Nhân viên pha chế', 0, 2, '2025-01-05 00:00:00', 2, '2025-01-10 00:00:00'),
('NV005', N'Võ', N'Thị E', N'101 Hùng Vương, Nha Trang', '1999-04-08 00:00:00', '0935678901', 'thie@gmail.com', 0, 5, N'Nhân viên marketing', 0, 3, '2025-01-15 00:00:00', 3, '2025-01-20 00:00:00');
UPDATE employee
SET note = N'Quản lý kho hàng'
WHERE employee_code = 'NV005';
-- Thêm dữ liệu vào bảng customer
INSERT INTO customer (customer_code, customer_first_name, customer_last_name, customer_address, customer_birth, customer_phone, customer_email, customer_gender, customer_type, customer_debts, customer_point, note, is_delete, create_by, create_date, update_by, update_date)
VALUES
('KH001', N'Nguyễn', N'Văn A', N'11 Nguyễn Du, Nha Trang', '1990-05-15 00:00:00', '0901234567', 'vana@gmail.com', 1, 1, 0, 100, N'Khách hàng thân thiết', 0, 1, '2024-11-20 00:00:00', 1, '2024-11-25 00:00:00'),
('KH002', N'Trần', N'Thị B', N'22 Lê Lợi, Nha Trang', '1995-08-20 00:00:00', '0902345678', 'thib@gmail.com', 0, 0, 0, 50, N'Khách hàng mới', 0, 1, '2024-12-01 00:00:00', 1, '2024-12-05 00:00:00'),
('KH003', N'Lê', N'Hoàng C', N'44 Trần Phú, Nha Trang', '1988-10-01 00:00:00', '0903456789', 'hoangc@gmail.com', 1, 1, 0, 200, N'Khách hàng VIP', 0, 2, '2024-12-10 00:00:00', 2, '2024-12-15 00:00:00'),
('KH004', N'Phạm', N'Thu D', N'55 Quang Trung, Nha Trang', '1992-03-10 00:00:00', '0904567890', 'thud@gmail.com', 0, 0, 0, 80, N'Khách hàng online', 0, 2, '2025-01-01 00:00:00', 2, '2025-01-05 00:00:00'),
('KH005', N'Võ', N'Đức E', N'66 Yersin, Nha Trang', '1997-12-25 00:00:00', '0905678901', 'duce@gmail.com', 1, 0, 0, 30, N'Khách hàng mới', 0, 3, '2025-01-10 00:00:00', 3, '2025-01-15 00:00:00');
-- Thêm dữ liệu vào bảng system_log
INSERT INTO system_log (date, is_select, is_add, is_update, is_delete, is_accept, note, create_by, create_date, update_by, update_date)
VALUES
('2025-02-01 00:00:00', 1, 0, 0, 0, 0, N'Truy vấn dữ liệu khách hàng', 1, '2025-02-01 00:00:00', 1, '2025-02-01 00:00:00'),
('2025-02-05 00:00:00', 0, 1, 0, 0, 0, N'Thêm sản phẩm mới', 2, '2025-02-05 00:00:00', 2, '2025-02-05 00:00:00'),
('2025-02-10 00:00:00', 0, 0, 1, 0, 0, N'Cập nhật thông tin nhân viên', 3, '2025-02-10 00:00:00', 3, '2025-02-10 00:00:00'),
('2025-02-15 00:00:00', 0, 0, 0, 1, 0, N'Xóa sản phẩm khỏi kho', 1, '2025-02-15 00:00:00', 1, '2025-02-15 00:00:00'),
('2025-02-20 00:00:00', 0, 0, 0, 0, 1, N'Duyệt đơn hàng', 4, '2025-02-20 00:00:00', 4, '2025-02-20 00:00:00');

-- Thêm dữ liệu vào bảng unit
INSERT INTO unit (unit_name, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
(N'Đĩa', 1, '2025-05-04 09:00:00', 1, N'Đơn vị tính cho các món ăn vặt', 0, '2025-05-04 10:00:00'),
(N'Ly', 1, '2025-05-04 09:30:00', 1, N'Đơn vị tính cho các loại đồ uống', 0, '2025-05-04 10:30:00'),
(N'Kg', 2, '2025-05-04 10:00:00', 2, N'Đơn vị tính cho nguyên liệu nặng', 0, '2025-05-04 11:00:00'),
(N'Phần', 2, '2025-05-04 10:30:00', 2, N'Đơn vị tính cho các món ăn theo phần', 0, '2025-05-04 11:30:00'),
(N'Gói', 3, '2025-05-04 11:00:00', 3, N'Đơn vị tính cho các nguyên liệu đóng gói', 0, '2025-05-04 12:00:00'),
(N'Chai', 3, '2025-05-04 11:30:00', 3, N'Đơn vị tính cho các loại nước đóng chai', 0, '2025-05-04 12:30:00'),
(N'Tô', 4, '2025-05-04 12:45:00', 1, N'Đơn vị tính cho đồ uống', 0, '2025-05-04 13:15:00');
-- Thêm dữ liệu vào bảng item
INSERT INTO item (item_code, item_name, item_image, item_retail, item_cost_price, combo_price, unit_id, item_wholesale, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
('SP01', N'Bánh tráng trộn', 'https://tse1.mm.bing.net/th?id=OIP.L1U3naexppe_qee1wu7YigHaEw&pid=Api&P=0&h=180', 20000, 14000, 18000, 1, 19000, 1, '2025-05-04 09:00:00', 1, N'Món ăn vặt của giới trẻ', 0, '2025-05-04 10:00:00'),
('SP02', N'Bánh tráng cuốn me', 'https://tse4.mm.bing.net/th?id=OIP.9jsY0F8ej63FkF-6fS4tWAHaD8&pid=Api&P=0&h=180', 22000, 15000, 20000, 1, 21000, 1, '2025-05-04 12:00:00', 2, N'BEST SELLER 1 của quán', 0, '2025-05-04 12:45:00'),
('SP03', N'Trái cây dầm', 'https://tse2.mm.bing.net/th?id=OIP.0hZ1EdkVzYu9kzx1WZAjZAHaFk&pid=Api&P=0&h=180', 18000, 12000, 16000, 2, 17000, 1, '2025-05-04 09:30:00', 1, N'Món tráng miệng mát lạnh', 0, '2025-05-04 10:30:00'),
('SP04', N'Chân gà sốt thái', 'https://tse3.mm.bing.net/th?id=OIP.914zFQVwAElGSNMGLCiMVAHaHa&pid=Api&P=0&h=180', 54000, 40000, 50000, 3, 52000, 2, '2025-05-04 10:00:00', 2, N'BEST SELLER 2 của quán', 0, '2025-05-04 11:00:00'),
('SP05', N'Gà rán', 'https://tse4.mm.bing.net/th?id=OIP.PDxkbcGJl3od12XpPBHj3gHaEK&pid=Api&P=0&h=180', 38000, 28000, 35000, 4, 37000, 2, '2025-05-04 10:30:00', 3, NULL, 0, '2025-05-04 11:30:00'),
('SP06', N'Khoai tây chiên', 'https://tse2.mm.bing.net/th?id=OIP.a8CyqODMMLYQt1tppGQ2OQHaFj&pid=Api&P=0&h=180', 30000, 20000, 27000, 5, 29000, 3, '2025-05-04 11:00:00', 3, N'Món bán nhanh vào tối', 0, '2025-05-04 12:00:00'),
('SP07', N'Nước chanh dây', 'https://tse4.mm.bing.net/th?id=OIP.7HmXB8r3Be6LJUIEUV3TOwHaE8&pid=Api&P=0&h=180', 26000, 18000, 22000, 6, 25000, 4, '2025-05-04 11:30:00', 4, N'Món nước bán không được chạy', 0, '2025-05-04 12:30:00'),
('SP08', N'Trà Thái Chanh Xanh', 'https://tse4.mm.bing.net/th?id=OIP.eiPlQIJNhOY53iC24FeIBgHaHa&pid=Api&P=0&h=180', 24000, 14000, 21000, 7, 23000, 4, '2025-05-04 12:45:00', 1, N'Đồ uống bán chạy mùa hè', 0, '2025-05-04 13:15:00');
-- Thêm dữ liệu vào bảng category_item
INSERT INTO category_item (category_item_code, category_item_name, create_by, create_date, note, is_delete, update_date, update_by)
VALUES
('C01', N'Đồ ăn vặt', 1, '2025-05-04 09:00:00', N'Nhóm các món ăn vặt phổ biến', 0, '2025-05-04 10:00:00', 1),
('C02', N'Đồ uống', 1, '2025-05-04 09:30:00', N'Nhóm các loại đồ uống giải khát', 0, '2025-05-04 10:30:00', 1),
('C03', N'Combo', 2, '2025-05-04 10:00:00', N'Nhóm các combo ưu đãi', 0, '2025-05-04 11:00:00', 2),
('C04', N'Nguyên liệu', 2, '2025-05-04 10:30:00', N'Nhóm các nguyên liệu chế biến', 0, '2025-05-04 11:30:00', 2);
-- Thêm dữ liệu vào bảng component_item
INSERT INTO component_item (item_product_id, item_component_id, item_component_name, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
(1, 101, N'Bánh tráng', 1, '2025-05-04 09:00:00', 1, N'Nguyên liệu chính cho món bánh tráng trộn', 0, '2025-05-04 10:00:00'),
(2, 102, N'Khô bò', 1, '2025-05-04 09:15:00', 1, N'Nguyên liệu phụ cho món bánh tráng trộn', 0, '2025-05-04 10:15:00'),
(3, 101, N'Bánh tráng', 2, '2025-05-04 12:00:00', 2, N'Nguyên liệu chính cho món bánh tráng cuốn me', 0, '2025-05-04 12:45:00'),
(3, 104, N'Sốt me', 2, '2025-05-04 12:10:00', 2, N'Nguyên liệu phụ cho món bánh tráng cuốn me', 0, '2025-05-04 12:50:00'),
(4, 105, N'Trái cây tươi', 1, '2025-05-04 09:30:00', 1, N'Nguyên liệu chính cho món trái cây dầm', 0, '2025-05-04 10:30:00'),
(5, 106, N'Chân gà', 2, '2025-05-04 10:00:00', 2, N'Nguyên liệu chính cho món chân gà sốt thái', 0, '2025-05-04 11:00:00'),
(5, 107, N'Sốt thái', 2, '2025-05-04 10:15:00', 2, N'Nguyên liệu phụ cho món chân gà sốt thái', 0, '2025-05-04 11:15:00'),
(6, 108, N'Khoai tây', 3, '2025-05-04 12:00:00', 3, N'Nguyên liệu chính cho món khoai tây chiên', 0, '2025-05-04 12:30:00'),
(7, 109, N'Chanh dây', 4, '2025-05-04 12:15:00', 4, N'Nguyên liệu chính cho món nước chanh dây', 0, '2025-05-04 12:45:00'),
(8, 110, N'Chanh', 4, '2025-05-04 12:50:00', 1, N'Nguyên liệu phụ cho món Trà Thái Chanh Xanh', 0, '2025-05-04 13:20:00'),
(8, 111, N'Trà Thái', 4, '2025-05-04 12:45:00', 1, N'Nguyên liệu chính cho món Trà Thái Chanh Xanh', 0, '2025-05-04 13:15:00'),
(8, 110, N'Chanh', 4, '2025-05-04 12:50:00', 1, N'Nguyên liệu phụ cho món Trà Thái Chanh Xanh', 0, '2025-05-04 13:20:00');
-- Thêm dữ liệu vào bảng combo
INSERT INTO combo (combo_name, combo_sell_price, combo_code, create_by, create_date, note, is_delete, update_date, update_by)
VALUES
(N'Combo Bánh Tráng', 38000, 'CB01', 1, '2025-05-04 09:00:00', N'Combo gồm Bánh tráng trộn và Bánh tráng cuốn me', 0, '2025-05-04 10:00:00', 1),
(N'Combo Trái Cây', 40000, 'CB02', 1, '2025-05-04 09:30:00', N'Combo gồm Trái cây dầm và Nước chanh dây', 0, '2025-05-04 10:30:00', 1),
(N'Combo Gà', 92000, 'CB03', 2, '2025-05-04 10:00:00', N'Combo gồm Chân gà sốt thái và Gà rán', 0, '2025-05-04 11:00:00', 2),
(N'Combo Chiều', 55000, 'CB04', 2, '2025-05-04 10:30:00', N'Combo gồm Khoai tây chiên và Trà Thái Chanh Xanh', 0, '2025-05-04 11:30:00', 3),
(N'Combo Đồ Uống', 45000, 'CB05', 3, '2025-05-04 11:00:00', N'Combo gồm Nước chanh dây và Trà Thái Chanh Xanh', 0, '2025-05-04 12:00:00', 3);
UPDATE combo
SET combo_name = N'Combo Khoai'
WHERE combo_code = 'CB04';
-- Thêm dữ liệu vào bảng combo_detail
INSERT INTO combo_detail (combo_id, item_id, quantity, create_by, create_date, note, is_delete, update_date, update_by)
VALUES
(1, 1, 1, 1, '2025-05-04 09:00:00', N'Bánh tráng trộn trong Combo Bánh Tráng', 0, '2025-05-04 10:00:00', 1),
(1, 2, 1, 1, '2025-05-04 09:00:00', N'Bánh tráng cuốn me trong Combo Bánh Tráng', 0, '2025-05-04 10:00:00', 1),
(2, 3, 1, 1, '2025-05-04 09:30:00', N'Trái cây dầm trong Combo Trái Cây', 0, '2025-05-04 10:30:00', 1),
(2, 5, 1, 1, '2025-05-04 09:30:00', N'Nước chanh dây trong Combo Trái Cây', 0, '2025-05-04 10:30:00', 1),
(3, 7, 1, 2, '2025-05-04 10:00:00', N'Chân gà sốt thái trong Combo Gà', 0, '2025-05-04 11:00:00', 2),
(3, 8, 1, 2, '2025-05-04 10:00:00', N'Gà rán trong Combo Gà', 0, '2025-05-04 11:00:00', 2),
(4, 6, 1, 2, '2025-05-04 10:30:00', N'Khoai tây chiên trong Combo Chiều', 0, '2025-05-04 11:30:00', 3),
(4, 5, 1, 2, '2025-05-04 10:30:00', N'Trà Thái Chanh Xanh trongCombo Chiều', 0, '2025-05-04 11:30:00', 3),
(5, 4, 1, 3, '2025-05-04 11:00:00', N'Nước chanh dây trong Combo Đồ Uống', 0, '2025-05-04 12:00:00', 3),
(5, 8, 1, 3, '2025-05-04 11:00:00', N'Trà Thái Chanh Xanh trong Combo Đồ Uống', 0, '2025-05-04 12:00:00', 3);

-- Thêm dữ liệu vào bảng vendor
INSERT INTO vendor (vendor_code, vendor_name, vendor_phone, vendor_address, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
('NCC01', N'Công ty TNHH Bánh Tráng Á Châu', '0912345678', N'123 Nguyễn Lương Bằng, TP.Nha Trang', 1, '2025-05-04 09:00:00', 1, N'Nhà cung cấp bánh tráng', 0, '2025-05-04 10:00:00'),
('NCC02', N'Công ty Rau Sạch Khánh Hòa', '0987654321', N'456 Lê Hồng Phong, TP.Nha Trang', 1, '2025-05-04 09:30:00', 2, N'Nhà cung cấp rau', 0, '2025-05-04 10:30:00'),
('NCC03', N'Công ty Gia Vị Thực Phẩm Nha Trang', '0934567890', N'789 Đường 2 Tháng 4, TP.Nha Trang', 2, '2025-05-04 10:00:00', 2, N'Nhà cung cấp gia vị', 0, '2025-05-04 11:00:00'),
('NCC04', N'Công ty Bao Bì Khánh Hòa', '0976543210', N'101 Trần Phú, TP.Nha Trang', 2, '2025-05-04 10:30:00', 3, N'Nhà cung cấp vật dụng', 0, '2025-05-04 11:30:00'),
('NCC05', N'Công ty Marketing Du Lịch', '0965432109', N'22 Nguyễn Văn Cừ, TP.Nha Trang', 3, '2025-05-04 11:00:00', 3, N'Công ty quảng cáo/pr', 0, '2025-05-04 12:00:00'),
('NCC06', N'Cơ sở Bánh ngọt Phương Anh', '0954321098', N'33 Trịnh Phong, TP. Nha Trang', 3, '2025-05-04 11:30:00', 4, N'Nhà cung cấp bánh', 0, '2025-05-04 12:30:00'),
('NCC07', N'Công ty TNHH Trà và Cà phê', '0945678901', N'568 Lê Hồng Phong, TP. Nha Trang', 4, '2025-05-04 12:00:00', 4, N'Nhà cung cấp trà và đồ uống', 0, '2025-05-04 12:45:00'),
('NCC08', N'Vựa trái cây tươi', '0932123456', N'90 Tôn Đức Thắng, TP. Nha Trang', 4, '2025-05-04 12:30:00', 1, N'Nhà cung cấp trái cây tươi', 0, '2025-05-04 13:00:00');
UPDATE vendor
SET vendor_name = N'Công ty Koyu & Unitek'
WHERE vendor_code = 'NCC06';
-- Thêm dữ liệu vào bảng warehouse
INSERT INTO warehouse (warehouse_code, create_by, create_date, update_by, update_date, shop_id, note, is_delete, company_id, item_id, quantity)
VALUES
('KH1', 1, '2025-05-04 10:00:00', 1, '2025-05-04 10:30:00', 1, N'Kho chính', 0, 1, 1, 100),
('NT2', 1, '2025-05-04 11:15:00', 2, '2025-05-04 11:55:00', 1, N'Kho nguyên liệu', 0, 1, 3, 50),
('HT3', 2, '2025-05-04 12:30:00', 2, '2025-05-04 13:00:00', 2, N'Kho tạm thời', 0, 1, 5, 20),
('HS4', 2, '2025-05-04 14:00:00', 3, '2025-05-04 15:00:00', 2, N'Kho hàng hỏng', 1, 1, 6, 5),
('TT5', 3, '2025-05-04 15:45:00', 3, '2025-05-04 16:10:00', 1, N'Kho chờ vận chuyển', 0, 1, 2, 30),
('MK6', 3, '2025-05-04 17:00:00', 4, '2025-05-04 17:30:00', 2, N'Kho hàng mới', 0, 1, 4, 60);
-- Thêm dữ liệu vào bảng warehouse_item
INSERT INTO warehouse_item (warehouse_id, price, is_delete, create_by, create_date, update_by, update_date, note)
VALUES
(1, 20000, 0, 1, '2025-05-04 10:00:00', 1, '2025-05-04 10:30:00', N'Bánh tráng trộn'),
(2, 15000, 0, 1, '2025-05-04 11:15:00', 2, '2025-05-04 11:45:00', N'Trái cây dầm'),
(3, 30000, 0, 2, '2025-05-04 12:30:00', 2, '2025-05-04 13:00:00', N'Gà rán'),
(4, 10000, 1, 2, '2025-05-04 14:00:00', 3, '2025-05-04 14:30:00', N'Hàng hỏng'),
(5, 25000, 0, 3, '2025-05-04 15:45:00', 3, '2025-05-04 16:15:00', N'Bánh tráng cuốn'),
(6, 12000, 0, 3, '2025-05-04 17:00:00', 4, '2025-05-04 17:30:00', N'Khoai tây chiên');
-- Thêm dữ liệu vào bảng stock_receipt_note
INSERT INTO stock_receipt_note (stock_receipt_note_code, stock_total, vendor_id, date, stock_amount_paid, create_by, create_date, update_by, update_date, warehouse_id, note, is_delete)
 VALUES
 (N'PNK001', 1000000, 1, '2025-05-04 10:00:00', 800000, 1, '2025-05-04 10:00:00', 1, '2025-05-04 10:30:00', 1, N'Nhập hàng tháng 1', 0),
 (N'PNK002', 2000000, 2, '2025-05-04 10:00:00', 1500000, 2, '2025-05-04 10:30:00', 2, '2025-05-04 11:00:00', 2, N'Nhập hàng khuyến mãi', 0),
 (N'PNK003', 1500000, 3, '2025-05-04 10:00:00', 1500000, 3, '2025-05-04 11:00:00', 3, '2025-05-04 11:30:00', 3, N'Nhập định kỳ', 0),
 (N'PNK004', 3000000, 4, '2025-05-04 10:30:00', 2000000, 4, '2025-05-04 11:30:00', 4, '2025-05-04 12:00:00', 4, N'Bổ sung kho', 0),
 (N'PNK005', 2500000, 5, '2025-05-04 11:00:00', 2000000, 5, '2025-05-04 12:00:00', 5, '2025-05-04 12:30:00', 5, N'Nhập hàng gấp', 0);
 -- Thêm dữ liệu vào bảng stock_receipt_note_detail
 INSERT INTO stock_receipt_note_detail (stock_receipt_note_id, item_id, quantity, price, total, note, create_by, create_date, update_by, update_date, is_delete)
 VALUES
 (1, 2, 10, 100000, 1000000, N'Sản phẩm chất lượng', 1, '2025-05-04 10:00:00', 1, '2025-05-04 10:30:00', 0),
 (2, 3, 20, 100000, 2000000, N'Hàng khuyến mãi', 2, '2025-05-04 10:30:00', 2, '2025-05-04 11:00:00', 0),
 (3, 4, 15, 100000, 1500000, N'Đợt nhập định kỳ', 3, '2025-05-04 11:00:00', 3, '2025-05-04 11:30:00', 0),
 (4, 5, 30, 100000, 3000000, N'Thêm vào kho chính', 4, '2025-05-04 11:30:00', 4, '2025-05-04 12:00:00', 0),
 (5, 6, 25, 100000, 2500000, N'Hàng nhập nhanh', 5, '2025-05-04 12:00:00', 5, '2025-05-04 12:30:00', 0);

-- Thêm dữ liệu vào bảng voucher
INSERT INTO voucher (voucher_name, voucher_value, voucher_expire, create_by, create_date, update_by, update_date, is_using, customer_id, is_delete, voucher_discount_percents, note)
VALUES
(N'Giảm 10K', 10000, '2025-12-31 00:00:00', 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', 0, 1, 0, 10, N'Cho đơn từ 100K'),
(N'Giảm 20K', 20000, '2025-12-31 00:00:00', 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', 0, 2, 0, 20, N'Chỉ áp dụng online'),
(N'Voucher VIP', 50000, '2025-11-30 00:00:00', 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', 1, 3, 0, 30, N'Dành cho khách VIP'),
(N'Flash Sale', 15000, '2025-06-30 00:00:00', 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', 0, 4, 0, 15, N'Áp dụng từ 1-5/6'),
(N'Mã mới', 25000, '2025-08-31 00:00:00', 5, '2024-12-28 10:00:00', 5, '2024-12-28 10:00:00', 0, 5, 0, 25, N'Khách mới đăng ký');
-- Thêm dữ liệu vào bảng invoice
INSERT INTO invoice (invoice_code, invoice_discount_percent, invoice_total, invoice_discount_total, invoice_VAT_percent, invoice_voucher_total, invoice_VAT_total, invoice_other_total, invoice_final_amount, is_print, date, customer_id, create_by, create_date, update_by, update_date, is_detele, note, shop_id)
VALUES
(N'HD001', 5, 200000, 10000, 10, 20000, 18000, 5000, 183000, 1, '2024-12-28 10:00:00', 1, 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', 0, N'Thanh toán tại quầy', 1),
(N'HD002', 10, 300000, 30000, 8, 15000, 21600, 3000, 256400, 1, '2024-12-28 10:00:00', 2, 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', 0, N'Khuyến mãi cuối tuần', 2),
(N'HD003', 2, 120000, 2400, 5, 6000, 5880, 1000, 119480, 1, '2024-12-28 10:00:00', 3, 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', 0, N'Đã điều chỉnh giá', 1),
(N'HD004', 15, 250000, 37500, 10, 10000, 21250, 0, 221250, 1, '2024-12-28 10:00:00', 4, 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', 0, N'Khách thân thiết', 2),
(N'HD005', 20, 400000, 80000, 10, 30000, 32000, 10000, 302000, 0, '2024-12-28 10:00:00', 5, 5, '2024-12-28 10:00:00', 5, '2024-12-28 10:00:00', 0, N'Voucher mạnh tay', 1);
-- Thêm dữ liệu vào bảng invoice_detail
INSERT INTO invoice_detail (invoice_id, item_id, quantity, total, discount_percent, discount_total, final_amount, is_delete, create_by, create_date, update_by, update_date, note)
VALUES
(1, 2, 2, 50000, 5, 2500, 47500, 0, 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', N'Mua 2 gói'),
(1, 3, 1, 30000, 10, 3000, 27000, 0, 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', N'Trưa nóng'),
(2, 4, 1, 40000, 15, 6000, 34000, 0, 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', N'Món khoái khẩu'),
(3, 5, 0.5, 25000, 0, 0, 25000, 0, 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', N'Bán theo lạng'),
(4, 6, 3, 90000, 20, 18000, 72000, 0, 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', N'Mua combo');
-- Thêm dữ liệu vào bảng invoice_voucher
INSERT INTO invoice_voucher (voucher_id, invoice_id, is_delete, create_by, create_date, update_by, update_date, note)
VALUES
(1, 1, 0, 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', N'Sử dụng voucher 10K'),
(2, 2, 0, 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', N'Voucher 20K giảm giá'),
(3, 3, 0, 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', N'Dùng VIP'),
(4, 4, 0, 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', N'Sale nhanh'),
(5, 5, 0, 5, '2024-12-28 10:00:00', 5, '2024-12-28 10:00:00', N'Mã mới đăng ký');

-- Thêm dữ liệu vào bảng category_receipt
INSERT INTO category_receipt (category_receipt_name, create_by, create_date, update_by, update_date, note, is_delete)
VALUES
(N'Tiền mặt', 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', N'Thanh toán tại quầy', 0),
(N'Chuyển khoản', 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', N'Ngân hàng', 0),
(N'MOMO', 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', N'Ví điện tử', 0),
(N'ZaloPay', 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', N'Thanh toán QR', 0),
(N'Trả sau', 5, '2024-12-28 10:00:00', 5, '2024-12-28 10:00:00', N'Khách nợ', 0);
-- Thêm dữ liệu vào bảng receipt
INSERT INTO receipt (receipt_code, invoice_id, receipt_total, receipt_amount_paid, date, receipt_change, create_by, create_date, update_by, update_date, category_receipt_id, note, customer_id, is_delete)
VALUES
(N'PT001', 1, 183000, 200000, '2024-12-28 10:00:00', 17000, 1, '2024-12-28 10:00:00', 1, '2024-12-28 10:00:00', 1, N'Thanh toán tiền mặt', 1, 0),
(N'PT002', 2, 256400, 256400, '2024-12-28 10:00:00', 0, 2, '2024-12-28 10:00:00', 2, '2024-12-28 10:00:00', 2, N'Chuyển khoản đủ', 2, 0),
(N'PT003', 3, 105000, 110000, '2024-12-28 10:00:00', 5000, 3, '2024-12-28 10:00:00', 3, '2024-12-28 10:00:00', 3, N'Trả dư', 3, 0),
(N'PT004', 4, 221250, 221250, '2024-12-28 10:00:00', 0, 4, '2024-12-28 10:00:00', 4, '2024-12-28 10:00:00', 4, N'Thanh toán ZaloPay', 4, 0),
(N'PT005', 5, 302000, 0, '2024-12-28 10:00:00', NULL, 5, '2024-12-28 10:00:00', 5, '2024-12-28 10:00:00', 5, N'Khách trả sau', 5, 0);

 -- Thêm dữ liệu vào bảng payment
 INSERT INTO payment (payment_code, payment_total, date, payment_object, create_by, create_date,
 update_by, note, is_delete, update_date)
 VALUES
 (N'TT001', 500000, '2025-05-04 10:00:00', 1, 1, '2025-05-04 10:00:00', 1, N'Thanh toán lần 1', 0, '2025-05-04 10:30:00'),
 (N'TT002', 1000000, '2025-05-04 10:30:00', 2, 2, '2025-05-04 10:30:00', 2, N'Thanh toán đặt hàng', 0, '2025-05-04 11:00:00'),
 (N'TT003', 1500000, '2025-05-04 11:00:00', 3, 3, '2025-05-04 11:00:00', 3, N'Thanh toán đầy đủ', 0, '2025-05-04 11:30:00'),
 (N'TT004', 750000, '2025-05-04 11:30:00', 4, 4, '2025-05-04 11:30:00', 4, N'Tạm ứng', 0, '2025-05-04 12:00:00'),
 (N'TT005', 1250000, '2025-05-04 12:00:00', 5, 5, '2025-05-04 12:00:00', 5, N'Thanh toán đợt 2', 0, '2025-05-04 12:30:00');
 -- Thêm dữ liệu vào bảng category_payment
 INSERT INTO category_payment (category_payment_name, create_by, create_date, update_by, note, is_delete, update_date)
 VALUES
 (N'Thanh toán tiền mặt', 1, '2025-05-04 10:00:00', 1, N'Loại tiền mặt', 0, '2025-05-04 10:30:00'),
 (N'Chuyển khoản ngân hàng', 2, '2025-05-04 10:30:00', 2, N'Thanh toán qua ngân hàng', 0, '2025-05-04 11:00:00'),
 (N'Thanh toán ví điện tử', 3, '2025-05-04 11:00:00', 3, N'Thanh toán qua momo, zalopay...', 0, '2025-05-04 11:30:00'),
 (N'Tạm ứng', 4, '2025-05-04 11:30:00', 4, N'Tạm ứng nội bộ', 0, '2025-05-04 12:00:00'),
 (N'Thanh toán hoàn tất', 5, '2025-05-04 12:00:00', 5, N'Thanh toán xong', 0, '2025-05-04 12:30:00');

 -- Thêm dữ liệu vào bảng customer_return
 INSERT INTO customer_return (customer_return_code, customer_id, invoice_id, create_by, create_date,
 update_by, note, is_delete, update_date, date)
 VALUES
 (N'HT001', 1, 1, 1, '2025-05-04 10:00:00', 1, N'Lỗi sản phẩm', 0, '2025-05-04 10:30:00', '2025-05-04 10:00:00'),
 (N'HT002', 2, 2, 2, '2025-05-04 10:30:00', 2, N'Khách trả lại hàng', 0, '2025-05-04 11:00:00', '2025-05-04 10:30:00'),
 (N'HT003', 3, 3, 3, '2025-05-04 11:00:00', 3, N'Không đúng mẫu', 0, '2025-05-04 11:30:00', '2025-05-04 11:00:00'),
 (N'HT004', 4, 4, 4, '2025-05-04 11:30:00', 4, N'Sản phẩm hỏng', 0, '2025-05-04 12:00:00', '2025-05-04 11:30:00'),
 (N'HT005', 5, 5, 5, '2025-05-04 12:00:00', 5, N'Không đúng đơn hàng', 0, '2025-05-04 12:30:00', '2025-05-04 12:00:00');
 -- Thêm dữ liệu vào bảng vendor_return
INSERT INTO vendor_return (vendor_return_code, vendor_id, stock_receipt_note_id, create_by, create_date, update_by, note, is_delete, update_date, date)
VALUES
    (N'TRV001', 1, 1, 1, '2025-05-04 13:00:00', 1, N'Hàng lỗi từ nhà cung cấp', 0, '2025-05-04 13:30:00', '2025-05-04 13:00:00'),
    (N'TRV002', 2, 2, 2, '2025-05-04 13:30:00', 2, N'Trả hàng không đúng yêu cầu', 0, '2025-05-04 14:00:00', '2025-05-04 13:30:00'),
    (N'TRV003', 3, 3, 3, '2025-05-04 14:00:00', 3, N'Hàng hỏng trong quá trình vận chuyển', 0, '2025-05-04 14:30:00', '2025-05-04 14:00:00'),
    (N'TRV004', 4, 4, 4, '2025-05-04 14:30:00', 4, N'Trả lại do dư số lượng', 0, '2025-05-04 15:00:00', '2025-05-04 14:30:00'),
    (N'TRV005', 5, 5, 5, '2025-05-04 15:00:00', 5, N'Hàng kém chất lượng', 0, '2025-05-04 15:30:00', '2025-05-04 15:00:00');
-- Thêm dữ liệu vào bảng vendor_return_detail
INSERT INTO vendor_return_detail (item_id, quantity, price, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
    (2, 2, 100000, 1, '2025-05-04 13:00:00', 1, N'Trả 2 sản phẩm lỗi', 0, '2025-05-04 13:30:00'),
    (3, 3, 100000, 2, '2025-05-04 13:30:00', 2, N'Trả 3 sản phẩm không đúng', 0, '2025-05-04 14:00:00'),
    (4, 1, 100000, 3, '2025-05-04 14:00:00', 3, N'Trả 1 sản phẩm hỏng', 0, '2025-05-04 14:30:00'),
    (5, 5, 100000, 4, '2025-05-04 14:30:00', 4, N'Trả 5 sản phẩm dư', 0, '2025-05-04 15:00:00'),
    (6, 4, 100000, 5, '2025-05-04 15:00:00', 5, N'Trả 4 sản phẩm kém chất lượng', 0, '2025-05-04 15:30:00');
-- Thêm dữ liệu vào bảng inventory_ledger
INSERT INTO inventory_ledger (code, create_by, create_date, update_by, note, is_delete, update_date, date, item_id, shop_id, cost_price, sell_price)
VALUES
    (N'NK001', 1, '2025-05-04 10:00:00', 1, N'Nhập kho ban đầu', 0, '2025-05-04 10:30:00', '2025-05-04 10:00:00', 2, 1, 80000, 120000),
    (N'NK002', 2, '2025-05-04 10:30:00', 2, N'Nhập hàng khuyến mãi', 0, '2025-05-04 11:00:00', '2025-05-04 10:30:00', 3, 2, 70000, 110000),
    (N'XK001', 3, '2025-05-04 11:00:00', 3, N'Xuất bán cho khách', 0, '2025-05-04 11:30:00', '2025-05-04 11:00:00', 4, 1, 90000, 140000),
    (N'TR001', 4, '2025-05-04 11:30:00', 4, N'Trả hàng NCC', 0, '2025-05-04 12:00:00', '2025-05-04 11:30:00', 5, 2, 60000, 90000),
    (N'CK001', 5, '2025-05-04 12:00:00', 5, N'Chuyển kho', 0, '2025-05-04 12:30:00', '2025-05-04 12:00:00', 6, 1, 100000, 150000);
-- Thêm dữ liệu vào bảng stock_transfer_note
INSERT INTO stock_transfer_note (stock_transfer_note_code, date, from_, to_, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
    (N'CK001', '2025-05-04 13:00:00', 1, 2, 1, '2025-05-04 13:00:00', 1, N'Chuyển hàng từ kho 1 sang kho 2', 0, '2025-05-04 13:30:00'),
    (N'CK002', '2025-05-04 13:30:00', 2, 3, 2, '2025-05-04 13:30:00', 2, N'Chuyển hàng từ kho 2 sang kho 3', 0, '2025-05-04 14:00:00'),
    (N'CK003', '2025-05-04 14:00:00', 3, 4, 3, '2025-05-04 14:00:00', 3, N'Chuyển hàng từ kho 3 sang kho 4', 0, '2025-05-04 14:30:00'),
    (N'CK004', '2025-05-04 14:30:00', 4, 5, 4, '2025-05-04 14:30:00', 4, N'Chuyển hàng từ kho 4 sang kho 5', 0, '2025-05-04 15:00:00'),
    (N'CK005', '2025-05-04 15:00:00', 5, 1, 5, '2025-05-04 15:00:00', 5, N'Chuyển hàng từ kho 5 sang kho 1', 0, '2025-05-04 15:30:00');
-- Thêm dữ liệu vào bảng stock_transfer_note_detail
INSERT INTO stock_transfer_note_detail (stock_transfer_note_id, item_id, quantity, create_by, create_date, update_by, note, is_delete, update_date)
VALUES
    (1, 2, 5, 1, '2025-05-04 13:00:00', 1, N'Chuyển 5 sản phẩm A', 0, '2025-05-04 13:30:00'),
    (2, 3, 10, 2, '2025-05-04 13:30:00', 2, N'Chuyển 10 sản phẩm B', 0, '2025-05-04 14:00:00'),
    (3, 4, 3, 3, '2025-05-04 14:00:00', 3, N'Chuyển 3 sản phẩm C', 0, '2025-05-04 14:30:00'),
    (4, 5, 7, 4, '2025-05-04 14:30:00', 4, N'Chuyển 7 sản phẩm D', 0, '2025-05-04 15:00:00'),
    (5, 6, 2, 5, '2025-05-04 15:00:00', 5, N'Chuyển 2 sản phẩm E', 0, '2025-05-04 15:30:00');

--thêm khóa ngoại 
ALTER TABLE company
ADD FOREIGN KEY (create_by) REFERENCES employee(employee_id),
    FOREIGN KEY (update_by) REFERENCES employee(employee_id);

ALTER TABLE shop
ADD FOREIGN KEY (create_by) REFERENCES employee(employee_id),
    FOREIGN KEY (update_by) REFERENCES employee(employee_id);

ALTER TABLE customer
ADD FOREIGN KEY (create_by) REFERENCES employee(employee_id),
    FOREIGN KEY (update_by) REFERENCES employee(employee_id);

ALTER TABLE department
ADD FOREIGN KEY (create_by) REFERENCES employee(employee_id),
    FOREIGN KEY (update_by) REFERENCES employee(employee_id);

ALTER TABLE employee
ADD FOREIGN KEY (create_by) REFERENCES employee(employee_id),
    FOREIGN KEY (update_by) REFERENCES employee(employee_id);

-- a Truy vấn đơn giản
--toàn bộ thông tin khách hàng
select * from customer
--id, tên, giá bán của sản phẩm
select item_id, item_name, item_retail from item
--lấy thông tin đầy đủ của tất cả nhân viên làm việc trong các phòng ban có liên quan đến "Bán hàng"
select * 
from employee
join department on employee.department_id = department.department_id
where department_name like '%Bán hàng%'

--b Truy vấn Aggregate Functions
--Tổng số khách hàng đến mua hàng trong tháng 12 năm 2024
select count(*) as TongSoKhachHang 
from invoice
where year(create_date) = 2024 and month(create_date) = 12
--Tính tổng tiền của tất cả các hóa đơn
select sum(invoice_total) as TongCacHoaDon
from invoice
--tổng số nhân viên có trong hệ thống
SELECT COUNT(*) AS total_employees
FROM employee
WHERE is_delete = 0 OR is_delete IS NULL;
--Tổng số hàng nhập vào kho trong 2025
select sum(quantity) as TongHangNhapVaoKho
from stock_receipt_note_detail
where year(create_date) = 2025
--Tìm hóa đơn có tổng tiền cao nhất
select *
from invoice
where invoice_total = (select MAX(invoice_total) from invoice)
--đếm tổng số nhân viên trong mỗi phòng ban
SELECT department_id, COUNT(*) AS SoLuongNhanVien
FROM employee
GROUP BY department_id;
--Tìm khách hàng có số điểm cao nhất và thấp nhất
SELECT MAX(customer_point) AS DiemCaoNhat,
       MIN(customer_point) AS DiemThapNhat
FROM customer;

--c.Truy vấn với mệnh đề having:
---Cảnh báo sản phẩm sắp hết hàng(các sản phẩm có số lượng tồn kho thấp (ví dụ dưới 10))
SELECT i.item_id, i.item_name, SUM(w.quantity) AS tong_ton_kho
FROM item i
JOIN warehouse w ON i.item_id = w.item_id
GROUP BY i.item_id, i.item_name
HAVING SUM(w.quantity) < 10;
--Theo dõi sản phẩm bán chạy
SELECT i.item_id, i.item_name, SUM(d.quantity) tong_ban
FROM invoice_detail d
JOIN item i ON i.item_id = d.item_id
GROUP BY i.item_id, i.item_name
HAVING SUM(d.quantity) > 2
ORDER BY tong_ban DESC;
--Theo dõi các sản phẩm bán chậm
SELECT i.item_id, i.item_name, SUM(idt.quantity) AS tong_ban
FROM item i
JOIN invoice_detail idt ON i.item_id = idt.item_id
GROUP BY i.item_id, i.item_name
HAVING SUM(idt.quantity) < 5 -- bán chậm nếu bán dưới 5 đơn vị
ORDER BY tong_ban ASC;
--Kiểm soát vốn lưu động
SELECT i.item_id, i.item_name, SUM(w.quantity * i.item_retail) AS tong_gia_tri
FROM warehouse w
JOIN item i ON i.item_id = w.item_id
GROUP BY i.item_id, i.item_name
HAVING SUM(w.quantity * i.item_retail) > 100000;
--Tìm sản phẩm không còn tồn kho
SELECT i.item_id, i.item_name
FROM item i
LEFT JOIN warehouse w ON i.item_id = w.item_id
GROUP BY i.item_id, i.item_name
HAVING SUM(ISNULL(w.quantity, 0)) = 0;

--d.Truy vấn lớn nhất, nhỏ nhất: 3 câu
--Tìm giá bán lẻ (item_retail) cao nhất của sản phẩm (item):
SELECT TOP 1 item_id, item_name, item_retail
FROM item
ORDER BY item_retail DESC;
--Kho có số lượng sản phẩm nhiều nhất (nếu có nhiều kho):
SELECT TOP 1 w.warehouse_id, COUNT(DISTINCT w.item_id) AS so_san_pham
FROM warehouse w
GROUP BY w.warehouse_id
ORDER BY so_san_pham DESC;
--5 sản phẩm bán chạy nhất (giả sử có bảng invoice_detail)
SELECT TOP 5 i.item_id, i.item_name, SUM(idt.quantity) AS tong_ban
FROM item i
JOIN invoice_detail idt ON i.item_id = idt.item_id
GROUP BY i.item_id, i.item_name
ORDER BY tong_ban DESC;

--e. Truy vấn không/chưa có (Not In và left/right join):
--NOT IN – Tìm khách hàng chưa từng mua hàng
SELECT *
FROM customer
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM invoice
);
--LEFT JOIN – Tất cả hóa đơn và thông tin phiếu thu nếu có
SELECT i.invoice_id, i.invoice_code, r.receipt_id, r.receipt_total
FROM invoice i
LEFT JOIN receipt r ON i.invoice_id = r.invoice_id;
--RIGHT JOIN – Tất cả chi tiết nhập kho kèm thông tin phiếu nhập (nếu có)
SELECT d.id, d.item_id, d.quantity, s.stock_receipt_note_code
FROM stock_receipt_note_detail d
RIGHT JOIN stock_receipt_note s ON d.stock_receipt_note_id = s.stock_receipt_note_id;
--LEFT JOIN – Tất cả sản phẩm trong bảng item, kèm thông tin xuất bán (nếu có)
SELECT i.item_id, i.item_name, d.quantity, d.total
FROM item i
LEFT JOIN invoice_detail d ON i.item_id = d.item_id;

--f. Truy vấn hợp/giao/trừ
--HỢP (UNION) – Lấy danh sách item_id đã từng xuất hiện trong cả hóa đơn hoặc phiếu nhập kho
SELECT item_id FROM invoice_detail
UNION
SELECT item_id FROM stock_receipt_note_detail;
--GIAO (INTERSECT) – Tìm các item_id xuất hiện trong cả invoice_detail và stock_receipt_note_detail (tức là những sản phẩm vừa bán ra vừa nhập kho)
SELECT item_id FROM invoice_detail
INTERSECT
SELECT item_id FROM stock_receipt_note_detail;
--TRỪ (EXCEPT) – Lấy danh sách item_id đang tồn tại trong kho (warehouse) nhưng chưa từng xuất hiện trong chi tiết hóa đơn (invoice_detail)
SELECT distinct item_id from warehouse
EXCEPT
SELECT distinct item_id FROM invoice_detail
--Truy vấn Update, Delete:  7 câu
--Cập nhật ghi chú cho voucher
UPDATE voucher
SET note = N'Voucher áp dụng toàn hệ thống',
    update_by = 1,
    update_date = GETDATE()
WHERE voucher_id = 10;
--Cập nhật trạng thái sử dụng voucher:
UPDATE voucher
SET is_using = 1, update_by = 2, update_date = GETDATE()
WHERE voucher_id = 4;
--Thêm voucher mới có mức giảm giá 50%
UPDATE voucher
SET voucher_discount_percents = 50, 
    update_by = 1, 
    update_date = GETDATE()
WHERE voucher_id = 5;
--Xóa voucher đã hết hạn:
DELETE FROM voucher
WHERE voucher_expire < GETDATE();
--Xóa voucher chưa bao giờ sử dụng
DELETE FROM voucher
WHERE voucher_id NOT IN (
    SELECT DISTINCT voucher_id FROM invoice
    WHERE voucher_id IS NOT NULL
);
--Gia hạn voucher đã sắp hết hạn
UPDATE voucher
SET voucher_expire = DATEADD(DAY, 30, voucher_expire),
    update_by = 4,
    update_date = GETDATE()
WHERE voucher_expire BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE());
-- Xóa tất cả voucher có mức giảm giá trên 80%:
DELETE FROM voucher
WHERE voucher_discount_percents > 80;

--h. Truy vấn sử dụng phép Chia: 2 câu
--1. Tìm toàn bộ voucher đang có sản phẩm áp dụng
SELECT
    i.item_name AS TenSanPham,
    v.voucher_name AS VoucherApDungChoHoaDon
FROM
    item AS i
INNER JOIN
    invoice_detail AS bd ON i.item_id = bd.item_id
INNER JOIN
    invoice AS b ON bd.invoice_id = b.invoice_id
INNER JOIN
    invoice_voucher AS iv ON b.invoice_id = iv.invoice_id 
INNER JOIN
    voucher AS v ON iv.voucher_id = v.voucher_id
WHERE
    i.is_delete = 0
    AND v.is_delete = 0
    AND bd.is_delete = 0
    AND iv.is_delete = 0
--Tìm voucher có giá trị cao nhất cùng với sản phẩm nó áp dụng
WITH voucher_item_info AS (
    SELECT 
        v.voucher_id, 
        v.voucher_name, 
        v.voucher_value, 
        i.item_name
    FROM 
        voucher v
    JOIN invoice_voucher iv ON v.voucher_id = iv.voucher_id
    JOIN invoice_detail id ON iv.invoice_id = id.invoice_id
    JOIN item i ON id.item_id = i.item_id
)

SELECT TOP 1 
    voucher_id, 
    voucher_name, 
    voucher_value, 
    item_name
FROM 
    voucher_item_info
ORDER BY 
    voucher_value DESC;

--Trigger
--Thêm khách hàng mới
create trigger TR_AddNewCustomers
on customer
after insert
as
begin
	insert into system_log(date, is_add, note, create_by, create_date, update_by, update_date)
	select getdate(), 1, N'Thêm khách hàng mới: ' + customer_first_name + ' ' + customer_last_name, create_by, GETDATE(), create_by, GETDATE()
	from inserted --bảng lưu trữ dữ liệu đã được thêm, cập nhật vào bảng
end;
--Thêm, cập nhật sản phẩm
create trigger TR_AddItems
on item
after insert, update
as
begin
	--kiểm tra xem có dữ liệu đc thêm hay cập nhật vào bảng không
	if exists (select * from inserted)
	begin
		--khai báo 1 biến action để lưu trữ 2 hành động insert và update
		declare @action nvarchar(10)
		--kiểm tra xem có dữ liệu nào bị xóa không
		if exists (select * from deleted) --deleted chứa các bản ghi trước khi cập nhật hoặc đã bị xóa
			--nếu trong bảng deleted có chứa bản ghi thì đây là thao tác cập nhật(update)
			set @action = 'update'
		else 
			--nếu trong bảng deleted không có bản ghi thì đây là thao tác thêm(insert)
			set @action = 'insert'
		--lấy thông tin từ bảng inserted
		declare @item_code nvarchar(max), @item_name nvarchar(max), @create_by int, @create_date datetime, @update_by int, @update_date datetime
		select 
			@item_code = item_code,
			@item_name = item_name,
			@create_by = create_by,
			@create_date = create_date,
			@update_by = update_by,
			@update_date = update_date
		from inserted
		--thêm bản ghi vào system_log
		insert into system_log(date, is_add, is_update, note, create_by, create_date, update_by, update_date)
		values (
			GETDATE(),
			case when @action = 'insert' then 1 else 0 end, --is_add
			case when @action = 'update' then 1 else 0 end, --is_update
			N'' + @action + N'mã sản phẩm: ' + @item_code + N'sản phẩm: ' + @item_name,
			@create_by,
			@create_date,
			@update_by,
			@update_date
		)
	end
end

--tính tổng hóa đơn
CREATE TRIGGER TR_InvoiceDetail_CalculateBill_INSERT
ON invoice_detail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        -- Cập nhật total_bill và final_bill cho các hóa đơn liên quan đến các chi tiết vừa được thêm.
        UPDATE inv
        SET
            inv.invoice_total = ISNULL(
                            (SELECT SUM(ind.quantity * ind.total)
                             FROM invoice_detail ind
                             WHERE ind.invoice_id = inv.invoice_id AND ind.is_delete = 0), 0),
            inv.invoice_final_amount = ISNULL(
                            (SELECT SUM(ind.quantity * ind.final_amount)
                             FROM invoice_detail ind
                             WHERE ind.invoice_id = inv.invoice_id AND ind.is_delete = 0), 0) - ISNULL(inv.invoice_discount_percent, 0),
            inv.update_date = GETDATE(),
            inv.update_by = (SELECT TOP 1 create_by FROM inserted) -- Lấy người tạo chi tiết hóa đơn làm người cập nhật hóa đơn
        FROM [invoice] inv
        JOIN inserted i ON inv.invoice_id = i.invoice_id
        WHERE inv.is_delete = 0; -- Chỉ cập nhật hóa đơn chưa bị xóa mềm
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
--cập nhật số lượng hàng còn lại trong kho
CREATE TRIGGER trg_UpdateWarehouseAfterSale
ON invoice_detail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật số lượng trong bảng warehouse tương ứng với item đã bán
    UPDATE w
    SET w.quantity = w.quantity - i.quantity
    FROM warehouse w
    JOIN inserted i ON w.item_id = i.item_id
    WHERE w.is_delete = 0; -- chỉ cập nhật với hàng tồn chưa bị đánh dấu xóa
END;


--cập nhật số lượng hàng sau khi nhập hàng vào trong kho
create trigger TR_UpdateQuantityInWarehouse
on stock_receipt_note_detail
after insert
as
begin
	update warehouse
	set quantity = warehouse.quantity + inserted.quantity
	from warehouse
	join inserted on warehouse.item_id = inserted.item_id 
	join stock_receipt_note on stock_receipt_note.stock_receipt_note_id = inserted.stock_receipt_note_id
	where warehouse.warehouse_id = stock_receipt_note.warehouse_id
end

--Thủ tục/Hàm/Trigger
-- Hàm:
--tính tổng tiền của hóa đơn (invoice)
CREATE FUNCTION GetTotalInvoiceAmount(@InvoiceID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10,2);
    
    SELECT @TotalAmount = SUM(final_amount)
    FROM invoice_detail
    WHERE invoice_id = @InvoiceID;

    RETURN @TotalAmount;
END;
GO
--kiểm tra kho còn hàng (trả về "Còn" hoặc "Không")
CREATE FUNCTION dbo.fn_KiemTraKho
(
    @warehouse_id INT
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @result NVARCHAR(10);

    IF EXISTS (
        SELECT warehouse_id FROM warehouse
        WHERE warehouse_id = @warehouse_id AND quantity > 0
    )
        SET @result = N'Còn';
    ELSE
        SET @result = N'Không';

    RETURN @result;
END;
--Tính tổng giá trị nhập hàng theo nhà cung cấp
CREATE FUNCTION fn_get_total_stock_receipt_by_vendor (
    @vendor_id INT
)
RETURNS MONEY
AS
BEGIN
    DECLARE @total MONEY;

    SELECT @total = SUM(stock_total)
    FROM stock_receipt_note
    WHERE vendor_id = @vendor_id AND is_delete = 0;

    RETURN ISNULL(@total, 0);
END;

-- Thủ tục:
--nhập sản phẩm vào kho (warehouse_item)
CREATE PROCEDURE AddNewWarehouseItem
    @WarehouseID INT,
    @Price DECIMAL(10,2),
    @IsDelete BIT,
    @CreateBy VARCHAR(50),
    @CreateDate DATETIME,
    @Note VARCHAR(255)
AS
BEGIN
    INSERT INTO warehouse_item (warehouse_id, price, is_delete, create_by, create_date, note)
    VALUES (@WarehouseID, @Price, @IsDelete, @CreateBy, @CreateDate, @Note);

    PRINT 'Sản phẩm đã được nhập vào kho thành công!';
END;
GO
--Lấy danh sách combo và sản phẩm trong combo
CREATE PROCEDURE SP_DANHSACH_COMBO
AS
BEGIN
    SELECT
        c.combo_name,
        c.combo_sell_price,
        i.item_name,
        cd.quantity
    FROM
        combo AS c
    INNER JOIN combo_detail AS cd ON c.combo_id = cd.combo_id
    INNER JOIN item AS i ON cd.item_id = i.item_id;
END;
GO
--Thêm mới phiếu thanh toán
CREATE PROCEDURE sp_create_payment
    @payment_code NVARCHAR(50),
    @payment_total MONEY,
    @date DATETIME,
    @payment_object INT,
    @create_by INT,
    @note NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO payment (
        payment_code,
        payment_total,
        date,
        payment_object,
        create_by,
        create_date,
        note,
        is_delete
    )
    VALUES (
        @payment_code,
        @payment_total,
        @date,
        @payment_object,
        @create_by,
        GETDATE(), -- create_date là thời điểm hiện tại
        @note,
        0 -- mặc định chưa bị xóa
    );
END;

CREATE PROCEDURE SP_ThemCongTy
    @company_code NVARCHAR(50),
    @company_name NVARCHAR(MAX),
    @company_address NVARCHAR(MAX),
    @company_phone NVARCHAR(13),
    @company_email NVARCHAR(MAX),
    @company_fax NVARCHAR(MAX),
    @company_hotline NVARCHAR(13) = NULL,
    @note NVARCHAR(MAX) = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM company WHERE company_code = @company_code AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã công ty đã tồn tại. Vui lòng chọn mã khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO company (
            company_code,
            company_name,
            company_address,
            company_phone,
            company_email,
            company_fax,
            company_hotline,
            note,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @company_code,
            @company_name,
            @company_address,
            @company_phone,
            @company_email,
            @company_fax,
            @company_hotline,
            @note,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL, -- update_by ban đầu là NULL
            NULL  -- update_date ban đầu là NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm công ty thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinCongTy
    @company_id INT,
    @company_code NVARCHAR(50),
    @company_name NVARCHAR(MAX),
    @company_address NVARCHAR(MAX),
    @company_phone NVARCHAR(13),
    @company_email NVARCHAR(MAX),
    @company_fax NVARCHAR(100),
    @company_hotline NVARCHAR(13) = NULL,
    @note NVARCHAR(MAX) = NULL,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM company WHERE company_id = @company_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID công ty không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM company WHERE company_code = @company_code AND company_id <> @company_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã công ty đã tồn tại cho một công ty khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE company
        SET
            company_code = @company_code,
            company_name = @company_name,
            company_address = @company_address,
            company_phone = @company_phone,
            company_email = @company_email,
            company_fax = @company_fax,
            company_hotline = @company_hotline,
            note = @note,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE company_id = @company_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin công ty thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemCongTy
    @company_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM company WHERE company_id = @company_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID công ty không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Kiểm tra xem có shop nào đang liên kết với công ty này không
        IF EXISTS (SELECT 1 FROM shop WHERE company_id = @company_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Không thể xóa công ty này vì có cửa hàng (shop) đang liên kết. Vui lòng xóa (mềm) các cửa hàng liên quan trước.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE company
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE company_id = @company_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm công ty thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemBoPhan
    @department_name NVARCHAR(MAX),
    @department_code NVARCHAR(50) = NULL,
    @shop_id INT,
    @note NVARCHAR(MAX) = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM shop WHERE shop_id = @shop_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID cửa hàng không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @department_code IS NOT NULL AND EXISTS (SELECT 1 FROM department WHERE department_code = @department_code AND shop_id = @shop_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã bộ phận đã tồn tại trong cửa hàng này. Vui lòng chọn mã khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO department (
            department_name,
            department_code,
            shop_id,
            note,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @department_name,
            @department_code,
            @shop_id,
            @note,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm bộ phận thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinBoPhan
    @department_id INT,
    @department_name NVARCHAR(MAX),
    @department_code NVARCHAR(50) = NULL,
    @shop_id INT,
    @note NVARCHAR(MAX) = NULL,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM department WHERE department_id = @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID bộ phận không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM shop WHERE shop_id = @shop_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID cửa hàng không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @department_code IS NOT NULL AND EXISTS (SELECT 1 FROM department WHERE department_code = @department_code AND shop_id = @shop_id AND department_id <> @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã bộ phận đã tồn tại trong cửa hàng này cho một bộ phận khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE department
        SET
            department_name = @department_name,
            department_code = @department_code,
            shop_id = @shop_id,
            note = @note,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE department_id = @department_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin bộ phận thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemBoPhan
    @department_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM department WHERE department_id = @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID bộ phận không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Kiểm tra xem có nhân viên nào đang liên kết với bộ phận này không
        IF EXISTS (SELECT 1 FROM employee WHERE department_id = @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Không thể xóa bộ phận này vì có nhân viên đang liên kết. Vui lòng chuyển hoặc xóa (mềm) các nhân viên liên quan trước.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE department
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE department_id = @department_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm bộ phận thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemNhanVien
    @employee_code NVARCHAR(50),
    @employee_first_name NVARCHAR(MAX),
    @employee_last_name NVARCHAR(MAX),
    @employee_address NVARCHAR(MAX),
    @employee_birth DATE,
    @employee_phone NVARCHAR(13),
    @employee_email NVARCHAR(MAX) = NULL,
    @employee_gender BIT, -- 0: Nữ, 1: Nam
    @shop_id INT,
    @department_id INT = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM shop WHERE shop_id = @shop_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID cửa hàng không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @department_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM department WHERE department_id = @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID bộ phận không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM employee WHERE employee_code = @employee_code AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã nhân viên đã tồn tại. Vui lòng chọn mã khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO employee (
            employee_code,
            employee_first_name,
            employee_last_name,
            employee_address,
            employee_birth,
            employee_phone,
            employee_email,
            employee_gender,
            department_id,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @employee_code,
            @employee_first_name,
            @employee_last_name,
            @employee_address,
            @employee_birth,
            @employee_phone,
            @employee_email,
            @employee_gender,
            @department_id,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm nhân viên thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinNhanVien
    @employee_id INT,
    @employee_code NVARCHAR(50),
    @employee_first_name NVARCHAR(MAX),
    @employee_last_name NVARCHAR(MAX),
    @employee_address NVARCHAR(MAX),
    @employee_birth DATE,
    @employee_phone NVARCHAR(13),
    @employee_email NVARCHAR(MAX) = NULL,
    @employee_gender BIT,
    @department_id INT = NULL,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM employee WHERE employee_id = @employee_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID nhân viên không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @department_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM department WHERE department_id = @department_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID bộ phận không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM employee WHERE employee_code = @employee_code AND employee_id <> @employee_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã nhân viên đã tồn tại cho một nhân viên khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE employee
        SET
            employee_code = @employee_code,
            employee_first_name = @employee_first_name,
            employee_last_name = @employee_last_name,
            employee_address = @employee_address,
            employee_birth = @employee_birth,
            employee_phone = @employee_phone,
            employee_email = @employee_email,
            employee_gender = @employee_gender,
            department_id = @department_id,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE employee_id = @employee_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin nhân viên thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemNhanVien
    @employee_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM employee WHERE employee_id = @employee_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID nhân viên không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        UPDATE employee
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE employee_id = @employee_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm nhân viên thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemSanPham
    @item_code NVARCHAR(50),
    @item_name NVARCHAR(MAX),
    @item_description NVARCHAR(MAX) = NULL,
    @unit_id INT, -- Foreign key tới unit
    @item_cost DECIMAL(18, 2),
    @item_retail DECIMAL(18, 2),
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM unit WHERE unit_id = @unit_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID đơn vị không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM item WHERE item_code = @item_code AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã sản phẩm đã tồn tại. Vui lòng chọn mã khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @item_retail < 0 OR @item_cost < 0
        BEGIN
            RAISERROR(N'Giá nhập và giá xuất không thể âm.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @item_retail < @item_cost
        BEGIN
            RAISERROR(N'Giá xuất không thể thấp hơn giá nhập.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO item (
            item_code,
            item_name,
            unit_id,
            item_cost_price,
            item_retail,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @item_code,
            @item_name,
            @unit_id,
			@item_cost,
			@item_retail,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm sản phẩm thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinSanPham
    @item_id INT,
    @item_code NVARCHAR(50),
    @item_name NVARCHAR(MAX),
    @unit_id INT,
    @import_price DECIMAL(18, 2),
    @export_price DECIMAL(18, 2),
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM item WHERE item_id = @item_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID sản phẩm không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM unit WHERE unit_id = @unit_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID đơn vị không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM item WHERE item_code = @item_code AND item_id <> @item_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã sản phẩm đã tồn tại cho một sản phẩm khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @import_price < 0 OR @export_price < 0
        BEGIN
            RAISERROR(N'Giá nhập và giá xuất không thể âm.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @export_price < @import_price
        BEGIN
            RAISERROR(N'Giá xuất không thể thấp hơn giá nhập.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE item
        SET
            item_code = @item_code,
            item_name = @item_name,
            unit_id = @unit_id,
            item_cost_price = @import_price,
            item_retail = @export_price,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE item_id = @item_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin sản phẩm thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemSanPham
    @item_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM item WHERE item_id = @item_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID sản phẩm không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Kiểm tra xem sản phẩm có đang trong kho với số lượng > 0 không
        IF EXISTS (SELECT 1 FROM warehouse WHERE item_id = @item_id AND quantity > 0 AND is_delete = 0)
        BEGIN
            RAISERROR(N'Không thể xóa sản phẩm này vì vẫn còn tồn kho. Vui lòng xuất hết hàng hoặc cập nhật tồn kho về 0 trước.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        UPDATE item
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE item_id = @item_id;

        -- Xóa mềm sản phẩm khỏi kho (nếu có)
        UPDATE warehouse
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE item_id = @item_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm sản phẩm thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemVoucher
    @voucher_name NVARCHAR(MAX),
	@voucher_value money,
	@voucher_expire datetime,
    @note NVARCHAR(MAX) = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO voucher (
            voucher_name,
			voucher_value,
			voucher_expire,
            note,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @voucher_name,
			@voucher_value,
			@voucher_expire,
            @note,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm voucher thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinVoucher
    @voucher_id INT,
    @voucher_name NVARCHAR(MAX),
	@voucher_value money,
	@voucher_expire datetime,
    @note NVARCHAR(MAX) = NULL,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM voucher WHERE voucher_id = @voucher_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID voucher không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE voucher
        SET
            voucher_name = @voucher_name,
			voucher_value = @voucher_value,
			voucher_expire = @voucher_expire,
            note = @note,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE voucher_id = @voucher_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin voucher thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemVoucher
    @voucher_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM voucher WHERE voucher_id = @voucher_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID voucher không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        UPDATE voucher
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE voucher_id = @voucher_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm voucher thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemMoiMatHangVaoKho
    @item_id INT,
    @quantity INT,
    @note NVARCHAR(MAX) = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM item WHERE item_id = @item_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID sản phẩm không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @quantity < 0
        BEGIN
            RAISERROR(N'Số lượng tồn kho ban đầu không thể âm.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM warehouse WHERE item_id = @item_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mặt hàng này đã có trong kho. Vui lòng sử dụng SP_CapNhatSoLuongKho để điều chỉnh.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO warehouse (
            item_id,
            quantity,
            note,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @item_id,
            @quantity,
            @note,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm mặt hàng vào kho thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemMucKho
    @warehouse_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM warehouse WHERE warehouse_id = @warehouse_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID kho không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @current_quantity INT;
        SELECT @current_quantity = quantity FROM warehouse WHERE warehouse_id = @warehouse_id;

        IF @current_quantity > 0
        BEGIN
            RAISERROR(N'Không thể xóa mục kho này vì vẫn còn số lượng tồn kho > 0. Vui lòng cập nhật số lượng về 0 trước.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE warehouse
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE warehouse_id = @warehouse_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm mục kho thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_ThemKhachHang
    @customer_code NVARCHAR(50),
    @customer_first_name NVARCHAR(MAX),
    @customer_last_name NVARCHAR(MAX),
    @customer_address NVARCHAR(MAX) = NULL,
    @customer_birth DATE = NULL,
    @customer_phone NVARCHAR(13),
    @customer_email NVARCHAR(MAX) = NULL,
    @customer_gender BIT = NULL, -- 0: Nữ, 1: Nam
    @customer_debts DECIMAL(18, 2) = 0,
    @customer_point INT = 0,
    @note NVARCHAR(MAX) = NULL,
    @create_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM customer WHERE customer_code = @customer_code AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã khách hàng đã tồn tại. Vui lòng chọn mã khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM customer WHERE customer_phone = @customer_phone AND is_delete = 0)
        BEGIN
            RAISERROR(N'Số điện thoại đã tồn tại cho một khách hàng khác. Vui lòng kiểm tra lại.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO customer (
            customer_code,
            customer_first_name,
            customer_last_name,
            customer_address,
            customer_birth,
            customer_phone,
            customer_email,
            customer_gender,
            customer_debts,
            customer_point,
            note,
            is_delete,
            create_by,
            create_date,
            update_by,
            update_date
        )
        VALUES (
            @customer_code,
            @customer_first_name,
            @customer_last_name,
            @customer_address,
            @customer_birth,
            @customer_phone,
            @customer_email,
            @customer_gender,
            @customer_debts,
            @customer_point,
            @note,
            0, -- Mặc định chưa xóa
            @create_by,
            GETDATE(),
            NULL,
            NULL
        );

        COMMIT TRANSACTION;
        SELECT N'Thêm khách hàng thành công.' AS Message, SCOPE_IDENTITY() AS NewID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_SuaThongTinKhachHang
    @customer_id INT,
    @customer_code NVARCHAR(50),
    @customer_first_name NVARCHAR(MAX),
    @customer_last_name NVARCHAR(MAX),
    @customer_address NVARCHAR(MAX) = NULL,
    @customer_birth DATE = NULL,
    @customer_phone NVARCHAR(13),
    @customer_email NVARCHAR(MAX) = NULL,
    @customer_gender BIT = NULL,
    @customer_debts DECIMAL(18, 2) = NULL, -- Cho phép không sửa nợ/điểm nếu NULL
    @customer_point INT = NULL,
    @note NVARCHAR(MAX) = NULL,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = @customer_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID khách hàng không tồn tại hoặc đã bị xóa.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM customer WHERE customer_code = @customer_code AND customer_id <> @customer_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Mã khách hàng đã tồn tại cho một khách hàng khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM customer WHERE customer_phone = @customer_phone AND customer_id <> @customer_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'Số điện thoại đã tồn tại cho một khách hàng khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE customer
        SET
            customer_code = @customer_code,
            customer_first_name = @customer_first_name,
            customer_last_name = @customer_last_name,
            customer_address = @customer_address,
            customer_birth = @customer_birth,
            customer_phone = @customer_phone,
            customer_email = @customer_email,
            customer_gender = @customer_gender,
            customer_debts = ISNULL(@customer_debts, customer_debts),
            customer_point = ISNULL(@customer_point, customer_point),
            note = @note,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE customer_id = @customer_id;

        COMMIT TRANSACTION;
        SELECT N'Cập nhật thông tin khách hàng thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

CREATE PROCEDURE SP_XoaMemKhachHang
    @customer_id INT,
    @update_by INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = @customer_id AND is_delete = 0)
        BEGIN
            RAISERROR(N'ID khách hàng không tồn tại hoặc đã bị xóa trước đó.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE customer
        SET
            is_delete = 1,
            update_by = @update_by,
            update_date = GETDATE()
        WHERE customer_id = @customer_id;

        COMMIT TRANSACTION;
        SELECT N'Xóa mềm khách hàng thành công.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;