create database practice;
use practice;

create table client_master(
client_no varchar(6) primary key,
name varchar(20) not null,
address1 varchar(30),
address2 varchar(30),
city varchar(15),
pincode int(8),
state varchar(15),
bal_due decimal(10,2),
check(client_no like "c%"));

create table product_master (
	Product_no varchar(6),
    Description varchar(15) NOT NULL,
    Profile_percent float(4,2)NOT NULL,
    Unit_measure varchar(10)NOT NULL,
    Qty_on_hand numeric(8) NOT NULL,
    Recorder_lvl numeric(8)NOT NULL,
	Sell_price numeric(8,2)NOT NULL,
    Cost_price numeric(8,2)NOT NULL,
    primary key (Product_no),
    check (Product_no like 'P%'),
    check (Sell_price > 0) ,
    check (Cost_price > 0)
);

CREATE TABLE salesman_master (
    salesman_no varchar(6) ,
    Salesman_name varchar(20) NOT NULL,
    Address1 varchar(30) NOT NULL,
    Address2 varchar(30),
    City varchar(20),
    Pincode varchar(8),
    State varchar(20),
    Sal_amt numeric(8, 2) NOT NULL,
    Tgt_to_get numeric(6, 2) NOT NULL,
    Ytd_sales numeric(6, 2) NOT NULL,
    Remarks varchar(60) ,
    primary key (salesman_no) ,
    check (salesman_no like 'S%'),
    CHECK (Sal_amt > 0),
    CHECK (Tgt_to_get > 0)
);

-- drop table sale_order;
-- drop table sale_order_details;

create table sale_order(
order_no varchar(6)  primary key,
order_date date,
client_no varchar(6),
dely_addr varchar(25),
salesman_no varchar(6),
dely_type char(1) default "F",
billed_yn char(1),
dely_date date,
order_status varchar(10),
check(order_no like "O%"),
foreign key(client_no) references client_master(client_no),
foreign key(salesman_no) references salesman_master(salesman_no),
check(dely_type="P" or dely_type="F"),
check(order_status="In Process" or order_status="Fulfilled" or order_status="Back Order" or order_status="Cancelled"),
check(dely_date>=order_date));

create table sale_order_details
(
	order_no varchar(6),
    product_no varchar(6),
    qty_ordered numeric(8),
    qty_disp numeric(8),
    product_rate numeric(10,2),
    primary key(order_no,product_no),
    foreign key(order_no) references sale_order(order_no),
    foreign key(product_no)  references product_master(product_no)
);


INSERT INTO client_master (Client_No, Name, City, PinCode, State, Bal_due)
VALUES
('C01', 'Ivan Bayross', 'Bombay', 400054, 'Maharashtra', 15000),
('C02', 'Vandana Saitwal', 'Madras', 780001, 'Tamil Nadu', 0),
('C03', 'Pramada Jaguste', 'Bombay', 400057, 'Maharashtra', 5000),
('C04', 'Basu Navindgi', 'Bombay', 400056, 'Maharashtra', 0),
('C05', 'Ravi Sreedharan', 'Delhi', 100001, 'Delhi', 2000),
('C06', 'Rukmini', 'Bombay', 400050, 'Maharashtra', 0);

-- use practice;
-- select count(client_no),name,city from client_master group by city ,name with rollup;


    INSERT INTO product_master VALUES
	('P00001', '1.44 Floppies', 5.00, 'Piece', 100, 2, 525.00, 500.00),
	('P03453', 'monitors', 6.00, 'Piece', 10, 20, 12000.00, 11280.00),
	('P06734', 'mouse', 5.00, 'Piece', 20, 3, 1050.00, 1000.00),
	('P07865', '1.22 Floppies', 5.00, 'Piece', 100, 5, 525.00, 500.00),
	('P07868', 'keyboards', 2.00, 'Piece', 10, 20, 3150.00, 3050.00),
	('P07885', 'CD Drive', 2.50, 'Piece', 10, 3, 5250.00, 5100.00),
	('P07965', '540 HHD', 4.00, 'Piece', 10, 3, 8400.00, 8000.00),
	('P07975', '1.44 Drive', 5.00, 'Piece', 10, 3, 1050.00, 1000.00),
	('P08865', '1.22 Drive', 5.00, 'Piece', 2, 3, 1050.00, 1000.00);
    
    
    INSERT INTO salesman_master (Salesman_no, Salesman_name, Address1, Address2, City, Pincode, State, Sal_amt, Tgt_to_get, Ytd_sales, Remarks)
	VALUES
	('S01', 'Kiran', 'A/14', 'Worli', 'Bombay', '400002', 'Maharashtra', 3000, 100, 50, 'Good'),
	('S02', 'Manish', '65', 'Nariman', 'Bombay', '400001', 'Maharashtra', 3000, 200, 100, 'Good'),
	('S03', 'Ravi', 'P-7', 'Bandra', 'Bombay', '400032', 'Maharashtra', 3000, 200, 100, 'Good'),
	('S04', 'Aashish', 'A/5', 'Juhu', 'Bombay', '400044', 'Maharashtra', 3500, 200, 150, 'Good');



INSERT INTO  sale_order 
		(order_no, order_date, Client_no, Dely_type, Billed_yn, Salesman_no, Dely_date, Order_status)
			VALUES
		('O19001', '1996-01-12', 'C01', 'F', 'N', 'S01', '1996-01-20', "In Process"),
		('O19002', '1996-01-25', 'C02', 'P', 'N', 'S02', '1996-01-27', "Cancelled"),
		('O46865', '1996-02-18', 'C03', 'F', 'Y', 'S03', '1996-02-20', "Fulfilled"),
		('O19003', '1996-04-03', 'C01', 'F', 'Y', 'S01', '1996-04-07', "Fulfilled"),
		('O46866', '1996-05-20', 'C04', 'P', 'N', 'S02', '1996-05-22', "Cancelled"),  
		('O19008', '1996-05-24', 'C05', 'F', 'N', 'S04', '1996-05-26', "In Process");
        
        
          INSERT INTO sale_order_details VALUES
('O19001', 'P00001', 4, 4, 525),
('O19001', 'P07965', 2, 1, 8400),
('O19001', 'P07885', 2, 1, 5250),
('O19002', 'P00001', 10, 0, 525),
('O46865', 'P07868', 3, 3, 3150),
('O46865', 'P07885', 3, 1, 5250),
('O46865', 'P00001', 10, 10, 525),
('O46865', 'P03453', 4, 4, 1050),
('O46865', 'P06734', 1, 1, 12000),
('O19003', 'P07965', 1, 0, 8400),
('O19003', 'P07975', 1, 0, 1050),
('O46866', 'P00001', 10, 5, 525),
('O19008', 'P07975', 5, 3, 1050);  


select * from client_master where name like '_a%';

select * from client_master where city like '_a%';

select * from client_master where city like 'bombay' or city like 'delhi';

select * from client_master where bal_due > 10000;

select * from sale_order where monthname(order_date) like 'january';

select * from client_master where client_no like 'C01' or client_no like 'C02';

select * from product_master where sell_price > 2000 and sell_price <= 5000;

select * from product_master;
select sell_price*1.5 'new_price',description from product_master where sell_price > 1500;

select name,city,state from client_master where state not like 'maharashtra%';

select count(order_no) from sale_order;

select avg(sell_price) from product_master;

select min(sell_price)'min_price', max(sell_price)'max_price' from product_master;

select count(product_no)  from product_master where sell_price >= 1500;

select * from product_master where Qty_on_hand < Recorder_lvl;

-- ------------------------------------------------------------------------------------------------ 

select day(order_date)'day',order_no from sale_order;

select order_date,dely_date from sale_order;
select monthname(dely_date),date(dely_date) from sale_order;

select date_format(order_date,'%d-%b-%y') 'formate'from sale_order;

select  adddate(curdate(),15)'current_date';

select datediff(dely_date,order_date)'elapsed' from sale_order;
select datediff(curdate(),order_date) from sale_order;


-- ------------------------------------------------------------------------------------------------------

-- having and group by
select description,sum(sod.qty_ordered)'total' from product_master p,sale_order_details sod 
where p.product_no=sod.product_no group by description;
--  select p.description,sum(sa.qty_ordered) from product_master p,sale_order_details sa
 -- where sa.product_no=p.product_no group by p.description;
 

 select sum(pm.sell_price),pm.description from sale_order_details as sod,product_master as pm where 
 sod.product_no=pm.product_no  group by sod.product_no;
 
 -- select avg(sod.qty_ordered),pm.description,pm.sell_price  from sale_order_details as sod,product_master as pm 
--   where sod.product_no = pm.product_no group by pm.description ; 
 
 select cm.name, avg(sod.qty_ordered) from sale_order_details
 as sod,sale_order as so,
 client_master as cm where sod.order_no=so.order_no and so.client_no=cm.client_no
 group by cm.client_no having sum(sod.product_rate)>15000;
 
 select sum(sod.product_rate),so.billed_yn,so.dely_date from sale_order_details as sod, sale_order as so
 where sod.order_no=so.order_no group by so.order_no having monthname(so.dely_date) like 'january%';
 -- ============================join ==============
 select distinct description from sale_order_details 
 as sod,sale_order as so,client_master as cm,product_master as pm where sod.order_no=so.order_no 
 and sod.product_no=pm.product_no and so.client_no=cm.client_no and cm.name="ivan bayross";
 
 SELECT sod.Product_no, p.Description, sod.Qty_ordered
        FROM practice.sale_order_details sod 
        INNER JOIN practice.product_master p 
            ON sod.Product_no = p.Product_no 
            INNER JOIN practice.sale_order so 
                ON sod.order_no = so.order_no
            WHERE EXTRACT(MONTH FROM so.Dely_date) = EXTRACT(MONTH FROM sysdate());
            
select s.product_no,p.description 
from sale_order_details as s,sale_order as o,product_master as  p
where s.Order_no=o.Order_no and s.product_no=p.product_no 
group by s.product_no 
having (sum(s.qty_ordered)/ (max(o.Order_date)-min(o.Order_date)))>0.08;

select cm.name from sale_order_details as sod,sale_order as so,client_master as cm,product_master as pm 
where sod.order_no=so.order_no and sod.product_no=pm.product_no and 
so.client_no=cm.client_no and pm.description="cd drive";

select sod.order_no,sod.product_no from sale_order_details as 
sod,sale_order as so,client_master as cm,product_master as pm 
join  sale_order on sod.order_no=so.order_no and sod.product_no=pm.product_no 
and so.client_no=cm.client_no and pm.descriptions="1.44 floppies" and sod.qty_ordered<5;

select sod.product_no,sod.qty_ordered from sale_order_details as sod,sale_order 
as so,client_master as cm,product_master as pm 
where sod.order_no=so.order_no and so.client_no=cm.client_no 
and sod.product_no=pm.product_no and cm.name in ("ivan bayross","Vandana Saitwal");

select sod.product_no,sod.qty_ordered from sale_order_details as 
sod,sale_order as so,client_master as cm,product_master as pm 
where sod.order_no=so.order_no and so.client_no=cm.client_no 
and sod.product_no=pm.product_no and cm.client_no in ("C01","C02");

select cm.name from sale_order_details as sod,sale_order as so,client_master as cm,product_master as pm where sod.order_no=
so.order_no and sod.product_no=pm.product_no and so.client_no=cm.client_no and pm.description="cd drive";
 
 select sod.order_no,sod.product_no from sale_order_details 
 as sod,sale_order as so,client_master as cm,product_master as pm
 where sod.order_no=so.order_no and sod.product_no=pm.product_no and so.client_no=cm.client_no 
 and pm.description="1.44 floppies" and sod.qty_ordered<5;
 
 select description,Qty_on_hand from sale_order_details as sod,sale_order as so,product_master as pm where sod.order_no=so.order_no
 and sod.product_no=pm.product_no and month(so.dely_date)=month(now());


 

-- ```````````````````````````````````````````````````````````````````````````````````````````````````````````
-- ``````````````````````````````````````````````````````````````````````````````````````````````````````````

select product_no,description from product_master where  Product_no  not in
 (select Product_no from sale_order_details);

select name,address1,address2,city,pincode from client_master 
where  client_no in (select client_no from sale_order where order_no = 'O19001' );

select name from client_master where client_no in (select client_no from sale_order 
where date(order_date) < '1996-5-01');

-- select client_no,name from client_master where client_no in (select client_no 
-- from sale_order where order_no in (select order_no from sale_order_details 
-- where product_no in(select distinct product_no from product_master where description ='1.44 drives'))); 

select client_no,name from client_master where client_no in(select client_no 
from sale_order where order_no in (select order_no from sale_order_details
where product_no in (select distinct product_no from product_master where description="1.44 drive")));

select name from client_master where client_no in (select client_no from sale_order where order_no in
(select order_no from sale_order_details where product_rate>10000 ));

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
select concat(pm.description ,'worth rs',sum(product_rate * sod.qty_disp),' was sold ')
from product_master as pm, 
sale_order_details as sod where pm.Product_no=sod.product_no group by pm.Description;

 select concat(pm.description,' worth rs ',sum(sod.product_rate * sod.qty_disp),'was 
 ordered in thr month of ') 
 from product_master as pm,sale_order as so,
 sale_order_details as sod where sod.product_no=pm.Product_no and sod.order_no=so.order_no group by pm.description;

select concat(P.description, ' Worth Rs ', sum(s.qty_disp * s.product_rate) , ' was ordered in the month of ',month(o.order_date))
from product_master p,sale_order_details s,sale_order o 
where p.product_no=s.product_no and s.Order_no=o.Order_no
group by p.descriptions;
 
 
 select concat(cm.name, ' has placed order ' , so.order_no, ' order no ', so.order_date, 'order date ')
 from client_master as cm,sale_order as so where cm.client_no=so.client_no ;
 
 select concat(P.description, ' Worth Rs ', sum(s.qty_disp * s.product_rate) , 
 ' was ordered in the month of ',month(o.order_date),'month')
from product_master p,sale_order_details s,sale_order o 
where p.product_no=s.product_no and s.Order_no=o.Order_no
group by p.description;

select concat(P.description, ' Worth Rs ', sum(s.qty_disp * s.product_rate) , ' was ordered in the month of ',month(o.order_date))
from product_master p,sale_order_details s,sale_order o 
where p.product_no=s.product_no and s.Order_no=o.Order_no
group by o.order_no;


select adddate(curdate(),3650) ;