create database EXCER;
use EXCER;

create table client_master(
client_no varchar(8) primary key,
client_name varchar(60)not null,
client_address1 varchar(20),
client_address2 varchar(20),
client_city varchar(10),
client_pincode numeric(8),
client_state varchar(20),
client_bal_due numeric(10,2)
);

create table product_master(
p_no varchar(8) primary key,
p_des varchar(15) not null,
p_pro_per int not null,
p_unit_mesure varchar(10)not null,
p_qty_no_hands numeric(8)not null,
p_reorder_lvl numeric(8)not null,
p_sell_price numeric(8,2)not null,
p_coast_price numeric(8)not null
);

create table salesman_master(
salesman_no varchar(8)primary key,
salesman_name varchar(20)not null,
salesman_address1 varchar(30) not null,
salesman_address2 varchar(30),
salesman_city varchar(20),
salesman_pincode numeric(8),
salesman_state varchar(20),
sal_smt numeric(8,2)not null,
s_tgt_to_get numeric(6,2)not null,
salesman_ytd_sales numeric(6,2)not null,
salesman_remarks varchar(60)
);

create table sale_order(
order_no varchar(8) primary key,
order_date date,
client_no varchar(8),
order_dely_addr varchar(25),
salesman_no varchar(8),
order_dely_type char(1) ,
order_billed_yn char(1),
order_dely_date date,
order_status varchar(10) check(order_status in('in process','canceled','fulfilled','back order')),
foreign key(client_no)references client_master(client_no),
foreign key(salesman_no)references salesman_master(salesman_no)
);

create table sale_order_detail(
order_no varchar(8),
p_no varchar(8),
sale_qty_order numeric(8),
sale_qty_disp numeric(8),
sale_product_rate numeric(10,2),
foreign key(order_no)references sale_order(order_no),
foreign key(p_no)references product_master(p_no)

);

