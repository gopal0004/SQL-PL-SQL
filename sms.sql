create database E;
use E;

create table employee(
Emp_id varchar(6),
Emp_name char(50),
Emp_deptName char(60),
Emp_salary int
);

insert into employee values('abc001','gopal bera','rollwala computer center',100000);
insert into employee values('abc002','sunil bera','b.k.school of management',500000);
insert into employee values('abc003','paresh bera','modi international schhol',70000);
insert into employee values('abc004','jayesh vasara','anand agriculture university',500000);

select * from employee;

-- searching 
select * from employee where Emp_name like '%g';
select * from employee where emp_salary=500000;
select * from employee where Emp_deptname like '%m';
select * from employee where Emp_salary <1000000;
select * from employee where Emp_salary=500000;

-- in ascending and descending order 

select * from employee order by Emp_name;
select * from employee order by Emp_salary desc;

-- AND,OR,NOT
select * from employee where Emp_name like '%g' and Emp_salary=100000;
select * from employee where emp_salary=500000 or Emp_name like '%g';
select * from employee where not Emp_salary=50000;

-- updating table
UPDATE employee
SET Emp_name = 'Alfred Schmidt', Emp_salary= 125000
WHERE Emp_id= 1;
-- delete from table
-- delete from employee where Emp_salary=500000;


