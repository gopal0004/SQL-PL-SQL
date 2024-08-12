create database selling;
use selling;

create table customer(
cus_id varchar(6),
cus_name char(50),
cus_deptName char(60),
cus_salary int
);

insert into customer values('abc001','gopal bera','rollwala computer center',100000);
insert into customer values('abc002','sunil bera','b.k.school of management',500000);
insert into customer values('abc003','paresh bera','modi international schhol',70000);
insert into customer values('abc004','jayesh vasara','anand agriculture university',500000);

create table suplier(
Sup_id varchar(6),
Sup_name char(50),
Sup_deptName char(60),
Sup_salary int
);

insert into suplier values('abc001','gopal','rollwala',10200);
insert into suplier values('abc002','sunil','b.k.school',5500);
insert into suplier values('abc003','paresh','modi international',7000);
insert into suplier values('abc004','jayesh','anand arts college',5000);

select cus_salary from customer union select Sup_salary from suplier;
select cus_id,cus_name,cus_deptname,cus_salary from customer union all select Sup_id,Sup_name,Sup_deptName,Sup_salary from suplier;