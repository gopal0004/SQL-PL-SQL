create database comp;
use comp;

-- Create the client_master table
CREATE TABLE client_master (
    client_no VARCHAR(20) NOT NULL,
    client_name VARCHAR(30) NOT NULL,
    address1 VARCHAR(30) ,
    address2 VARCHAR(30),
    city VARCHAR(15) ,
    pincode numeric(15),
    state VARCHAR(10) ,
    bal_due numeric(10,2),
    PRIMARY KEY (client_no),
    CHECK (client_no LIKE 'C%')
);

INSERT INTO client_master (client_no, client_name, city, pincode, state, bal_due)
VALUES
    ('C00001', 'Ivan Bayross', 'Bombay', '400054', 'Maharastra', 15000),
    ('C00002', 'Vandana Saitwal', 'Madras', '780001', 'Tamil Nadu', 0),
    ('C00003', 'Pramada Jaguste', 'Bombay', '400057', 'Maharastra', 5000),
    ('C00004', 'Basu Navindgi', 'Bombay', '400056', 'Maharastra', 0),
    ('C00005', 'Ravi Sreedharan', 'Delhi', '100001', 'Delhi', 2000),
    ('C00006', 'Rukmini', 'Bombay', '400050', 'Maharastra', 0);
    
    
    CREATE TABLE product_master (
    product_no VARCHAR(6) NOT NULL,
    description VARCHAR(15) NOT NULL,
    profit_percent DECIMAL(4,2) NOT NULL,
    unit_measure VARCHAR(10) NOT NULL,
    qty_no_hand INT NOT NULL,
    reorder_lvl INT NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,
    sell_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_no)
    
);

INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_no_hand, reorder_lvl, cost_price, sell_price)
VALUES
    ('P00001', '1.44 Floppies', 10.00, 'Piece', 5, 2, 5.25, 5.00),
    ('P03453', 'Monitors', 10.00, 'Piece', 6, 3, 120.00, 112.80),
    ('P06734', 'Mouse', 20.00, 'Piece', 5, 5, 10.50, 10.00),
    ('P07865', '1.22 Floppies', 10.00, 'Piece', 5, 2, 5.25, 5.00),
    ('P07868', 'Keyboards', 10.00, 'Piece', 2, 2, 31.50, 30.50),
    ('P07885', 'CD Drives', 10.00, 'Piece', 2.5, 3, 52.50, 51.00),
    ('P07965', '540 HHD', 10.00, 'Piece', 4, 3, 84.00, 80.00),
    ('P07975', '1.44 Drives', 10.00, 'Piece', 5, 3, 10.50, 10.00),
    ('P08865', '1.22 Drives', 10.00, 'Piece', 5, 3, 10.50, 10.00);


CREATE TABLE salesman_master (
salesman_no varchar(20)not null,
  salesman_name VARCHAR(20) NOT NULL,
  address1 VARCHAR(30) NOT NULL,
  address2 VARCHAR(30),
  city VARCHAR(20) NOT NULL,
  pincode VARCHAR(8) NOT NULL,
  state VARCHAR(20) NOT NULL,
  sale_amt numeric(8,2)not null,
  tgt_to_get numeric(6,3) not null,
  ytd_sales numeric(6,2) NOT NULL,
  remarks VARCHAR(60) NOT NULL,
  PRIMARY KEY (salesman_no)
);

INSERT INTO salesman_master (salesman_no, salesman_name, address1, address2, city, pincode, state,sale_amt,tgt_to_get, ytd_sales, remarks)
VALUES
    ('S00001', 'Aman', 'A/14', 'Worli', 'Mumbai', 400002, 'Maharashtra', 3000.00, 100.00, 50.00, 'Good'),
    ('S00002', 'Omkar', '65', 'Nariman', 'Mumbai', 400001, 'Maharashtra', 3000.00, 200.00, 100.00, 'Good'),
    ('S00003', 'Raj', 'P-7', 'Bandra', 'Mumbai', 400032, 'Maharashtra', 3000.00, 200.00, 100.00, 'Good'),
    ('S00004', 'Ashish', 'A/5', 'Juhu', 'Mumbai', 400044, 'Maharashtra', 3500.00, 200.00, 150.00, 'Good');

CREATE TABLE sale_orders (
    order_no VARCHAR(10),
    order_date DATE,
    client_no VARCHAR(10),
    dely_addr VARCHAR(50),
    salesman_no VARCHAR(10),
    dely_type CHAR(1) DEFAULT 'P',
    billed_yn CHAR(1) DEFAULT 'N',
    dely_date DATE,
    order_status VARCHAR(20),
    primary key (Order_no),
	foreign KEY(Client_no) references client_master(client_no),
    foreign key(salesman_no)references salesman_master(salesman_no)
);

INSERT INTO sale_orders (
    order_no,
    order_date,
    client_no,
    dely_addr,
    salesman_no,
    dely_type,
    billed_yn,
    dely_date,
    order_status
) VALUES
    ('019001', '1996-01-12', 'C00001', NULL, 'S00001', 'F', 'N', NULL, 'In Process'),
    ('019002', '1996-01-25', 'C00002', NULL, 'S00001', 'P', 'N', NULL, 'Fulfilled'),
    ('046865', '1996-02-18', 'C00003', NULL, 'S00002', 'F', 'N', NULL, 'In Process'),
    ('019003', '1996-04-03', 'C00001', NULL, 'S00003', 'F', 'N', NULL, 'Fulfilled'),
    ('046866', '1996-05-20', 'C00004', NULL, 'S00004', 'P', 'N', NULL, 'In Process'),
    ('019008', '1996-05-24', 'COOKIOS', NULL, 'S00002', 'N', 'N', NULL, 'Cancelled');

CREATE TABLE sale_order (
  order_no VARCHAR(25) NOT NULL,
  order_date DATE NOT NULL,
  client_no VARCHAR(25) NOT NULL,
  dely_type CHAR(1) DEFAULT 'F',
  billed_yn CHAR(1) NOT NULL,
  salesman_no VARCHAR(25),
  dely_date DATE NOT NULL,
  order_status VARCHAR(25) NOT NULL,
  PRIMARY KEY (order_no),
  FOREIGN KEY (client_no) REFERENCES client_master (client_no),
  FOREIGN KEY (salesman_no) REFERENCES salesman_master (salesman_no)
);


INSERT INTO sale_order(order_no,order_date,client_no,dely_type,billed_yn,salesman_no,dely_date,order_status) VALUES
    ('019001', '1996-01-12', 'C00001', 'F', 'N','S00001', '1996-01-20','In Process'),
    ('019002', '1996-01-25', 'C00002', 'P', 'N','S00001','1996-01-27', 'Fulfilled'),
    ('046865', '1996-02-18', 'C00003',  'F', 'N','S00002','1996-02-20','In Process'),
    ('019003', '1996-04-03', 'C00001',  'F', 'N', 'S00003', '1996-03-07','Fulfilled'),
    ('046866', '1996-05-20', 'C00004',  'P', 'N', 'S00004','1996-04-22','In Process'),
    ('019008', '1996-05-24', 'C00005', 'N', 'N', 'S00002',  '1996-04-26','Cancelled');

CREATE TABLE sale_order_details (
  order_no VARCHAR(6) NOT NULL,
  product_no VARCHAR(6) NOT NULL,
  qty_ordered INT NOT NULL,
  qty_disp INT NOT NULL,
  product_rate DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_no, product_no),
  FOREIGN KEY (order_no) REFERENCES sale_order (order_no)
);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019001', 'P00001', 4, 4, 525.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019001', 'P07965', 1, 42, 8400.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019001', 'P07885', 1, 1, 5250.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019002', 'P00001', 2, 2, 525.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046865', 'P07868', 1, 0, 3150.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046865', 'P07885', 3, 3, 5250.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046865', 'P00001', 10, 10, 525.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046865', 'P03453', 10, 10, 1050.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019003', 'P03453', 5, 5, 1050.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019003', 'P06734', 0, 0, 12000.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046866', 'P07965', 3, 3, 8400.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('046866', 'P07975', 1, 1, 1050.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019008', 'P00001', 2, 2, 525.00);

INSERT INTO sale_order_details (order_no, product_no, qty_ordered, qty_disp, product_rate)
VALUES ('019008', 'P07975', 1, 0, 1050.00);


select * from client_master;
select client_name from client_master where client_name like '_a%';
select city from client_master  where city like '_a%';
select city from client_master where city like 'bombay' or city like 'delhi';
 select bal_due from client_master where  bal_due >10000;
 select * from sale_order_detailsproduct_master;
 select order_date from sale_order where monthname(order_date)='january';
 select * from client_master where client_no='C00001' or client_no='C00002';
 select sell_price from product_master where sell_price>=2000 and sell_price<=5000;
 select description,sell_price * 1.50 'new_price' from product_master where sell_price > 15;
 select count(order_no) from sale_order;
 select avg(sell_price) from product_master;
 select min(sell_price)'min_price',max(sell_price)'max_price' from product_master;
 select count(product_no)'having price <1500'from sale_order_details where product_rate >=1500;
 select qty_no_hand from product_master where qty_no_hand > reorder_lvl;
 select description from product_master where qty_no_hand < reorder_lvl;
 
 
 select order_no,day(order_date) from sale_order;
select monthname(dely_date)'month',date(dely_date)'date'from sale_order;
select order_date,date_format(order_date,'%d-%b-%y')'date format' from sale_order;
select adddate(curdate(),15)'added date';
select order_date from sale_order;
select datediff(dely_date,order_date)'elasped' from sale_order;

describe client_master;
select * from client_master;



select client_name  from client_master where client_name like'ivan bayross%' ;
select p.description,sum(sa.qty_ordered) from product_master p,sale_order_details sa 
where sa.product_no=p.product_no group by p.description;

select p.description,sum(sa.qty_ordered) from product_master p,sale_order_details sa 
where sa.product_no=p.product_no group by p.description;

