-- 1) WAP to input two numbers and find out what is the output of all arithmetic operations.
-- (Addition, Subtraction, Multiplication, Division etc.)

-- =================================================-- ======================================================
-- 1) Write a procedure which accepts the empno and returns the associated empname. If
-- empno does not exist than give proper error message.

create database sem1;
use sem1;

create table employee(
	empno int,
    empname varchar(50)
    );
    
insert into employee(empno,empname) values
	(1,'rohit sharma'),
    (2,'virat kohli'),
    (3,'lord bhumit'),
    (4,'amit shah');
    
delimiter @@

create procedure employee(in id int)
begin 
declare emp_name varchar(50);

select empname into emp_name from employee where empno=id;

if emp_name is null then signal sqlstate '45000'
	set message_text=' employee could not found ';
else
	select emp_name as empname;
end if;
end @@

delimiter ;
call employee(7);

-- ---------------------------------------------------------------------------------------------------
-- 2) WAP which accepts the student rollno and returns the name,city and marks of all the
-- subjects of that student.
-- STUDENT(Stud_ID,Stud_name,m1,m2,m3).
create table student(
	stud_id int,
    stud_name varchar(50),
    m1 int,
    m2 int,
    m3 int,
    city varchar(50));
    
insert into student(stud_id,stud_name,m1,m2,m3,city) values
	(1,'rohit',67,68,69,'pune'),
    (2,'shikhar',78,79,77,'delhi'),
    (3,'raina',67,68,69,'chennai'),
    (4,'thala',56,57,58,'mumbai'),
    (5,'pollard',78,79,80,'africa');


delimiter !!
create procedure student(in roll_no int)
begin
select stud_name,m1,m2,m3,city from student where stud_id=roll_no;

if roll_no is null then signal sqlstate '45000'
	set message_text = "id is not there ";
end if;
end !!
delimiter ;
call student(3);

-- ------------------------------------------------------------------- ----------------------------------
-- 3) WAP which accepts the name from the user. Return UPPER if name is in uppercase,
-- LOWER if name is in lowercase, MIXCASE if name is entered using both the case.

DELIMITER ##
create procedure checking(in user_name varchar(50),out check_alphabets varchar(50))
begin 
	if binary user_name =upper(user_name) then
		set check_alphabets = "UPPER";
	elseif binary user_name=lower(user_name) then
		set check_alphabets="lower";
	else
		set check_alphabets="MIXcase";
	end if;
end ##
delimiter ;
call checking('opal',@result);
select @result;

-- ---------------------------------- ------------------------------------------
-- 4) WAP which accepts the student rollno and returns the highest percent and name of that
-- student to the calling block.
-- STUDENT(Stud_ID,Stud_name,percent);
drop table student ;
create table student(
	stud_id int,
    stud_name varchar(50),
    percentage double);
    
insert into student(stud_id,stud_name,percentage) values
	(1,'rohit',45),
    (2,'kohli',60),
    (3,'sachin',32),
    (4,'shikhar',70),
    (5,'dhoni',55);
    
delimiter !!
create procedure highest_per(in roll_no int,out highest_percentage double)
begin 
	select max(percentage)into highest_percentage from student; 
    
    select stud_name,highest_percentage from student;
    if stud_name is null then 
		signal sqlstate '45000' set message_text="roll no not found ";
	else
		select student_name,highest_percentage;
	end if;
end !!
delimiter ;
call highest_per(1,@result);
select result;

-- ------------------------ ----------------------------------------------------------------------
-- 5) WAP which accepts the date of joining for specific employee and returns the years of
-- experience along with its name. Accept the Employee no from user.
-- EMP(empno, empname, DOJ);
create table emp(
	empno int,
    empname varchar (50),
    DOJ date );
    
insert into emp(empno,empname,DOJ) values
	(1,'sunil','2015-01-03'),
    (2,'jayesh','2017-05-05'),
    (3,'paresh','2020-07-28');
    
select year(now())-year(DOJ) from emp;
    
delimiter !!
create procedure years(in joindate date,out year_of_exaperience int)
begin 
	select year(now())-year(DOJ) into year_of_exaperience  from emp
    where DOJ=joindate;
    -- select year_of_exaperience as years_of_experience;
end !!
delimiter ;
call years('2017-05-05',@result); 
select @result;

-- ----------------------------------- ------------------------------------------------------------------
-- 6) WAP which accepts the student rollno and returns the result (in the form of class: first
-- class, second class, third class or fail).
-- STUDENT(Stud_ID,Stud_name,m1,m2,m3).
create table abc(
	stud_id int ,
    stud_name varchar(50),
    m1 int,
    m2 int,
    m3 int
     );
     
     insert into abc values
		(1,'rohit',97,98,99),
        (2,'virat',45,76,56),
        (3,'dhavan',80,80,87),
        (4,'sachin',30,33,27),
        (5,'thala',65,90,99);
    select (avg(m1+m2+m3)/3) from abc where stud_id=1; 
delimiter !!
create procedure  calculation(in roll_no int ,out percentage decimal (8,2),out result varchar(50) )

	begin 
		declare total_marks int ;
        declare avg_marks decimal(8,2);
    
		select m1+m2+m3 into total_marks from abc
        where stud_id=roll_no;
        
        set avg_marks = total_marks /3.0;
        set percentage = avg_marks;
        
        if avg_marks > 90 then 
			set result="first class ";
            
		elseif avg_marks > 70 then
			set result="second class";
            
		elseif avg_marks > 40 then
			set result="third class";
            
		else
			set result="failed";
            
	end if;
    
    end !!
    
delimiter ;

call calculation(4,@result,@percentage);
select @result as result,@percentage as percentage ;

-- ----------------------------------------------------------------------------------------------------
-- trigger 
-- ======================================================-- ====================================
-- 1) Write a Trigger that stores the old data table of student table in student_backup while
-- updating the student table.
-- Student_backup (Stud_ID, Stud_name, Address, Contact_no, Branch, Operation_date)
-- Student (Stud_ID, Stud_name, Address, Contact_no, Branch)

create table student_backup(
	stud_id int,
    stud_name varchar(100),
    address varchar(100),
    contact_no numeric(8,2),
    branch varchar(100),
    operation_date date  );
    
create table students(
	stud_id int,
    stud_name varchar(100),
    address varchar(100),
    contact_no numeric(8,2),
    branch varchar(100));
    
     insert into students values
		(1,'gopal','amadavad',93139,'computer engineering'),
        (2,'mohit','jamnagar',81449,'Diploma');
    
delimiter !!
create trigger first_trigger before update on students for each row
begin
	insert  into student_backup(stud_id,stud_name,address,contact_no,branch,operation_date)
		values
	(old.stud_id,old.stud_name,old.address,old.contact_no,old.branch,now());
end !!

update students set stud_name="shailesh" where stud_id=2;
select * from students;
select * from student_backup;

-- -----------------------------------
-- 2) Write a trigger, that ensures the empno of emp table is in a format ‘E00001’ (empno
-- must start with ‘E’ and must be 6 characters long). If not than complete empno with this
-- format before inserting into the employee table.

drop table if exists employee;
create table employee(
	emp_no varchar(6),
    emp_name varchar(50),
    salary int
    );
delimiter !!
create trigger before_insert before insert on employee for each row
begin
	if left(new.emp_no,1)!='E' or length(new.emp_no)!='6' then
		set new.emp_no =concat('E',lpad(right(new.emp_no,5),5,'0'));
	end if;
end !!
delimiter ;
insert into employee values(1,'gopal',45000);
select * from employee;

-- --------------------------------------------------------------------------- ---
-- 3) Write a trigger which checks the age of employee while inserting the record in emp
-- table. If it is negative than generate the error and display proper message.
drop table employee;
create table employee(
	emp_id int,
    emp_name varchar(40),
    age int);
delimiter !!
create trigger before_insert before insert on employee for each row
begin 	
	if(new.age < 0) 
		then signal sqlstate '45000' 
        set message_text ="unable to insert age";
	end if;
end !!
delimiter ;

insert into employee values(1,'gopal',76);
select * from employee;
-- ----------------------------------------------------------- ----------------------------
-- 4) Write a trigger which converts the employee name in upper case if it is inserted in any
-- other case. Change should be done before the insertion only.

create table employee(
	stud_id int,
    stud_name varchar(50));
    
delimiter !!
create trigger before_insert before insert on employee for each row
begin
	if(new.stud_name=lower(new.stud_name)) then
		set new.stud_name=upper(new.stud_name);
	end if;
end !!
delimiter ;

insert into employee values(1,'Gopal');
select * from employee;

-- --------------------------- ---------------------------------------------- ----------- -------- -
-- 5) WAT that stores the data of emp table in emp_backup table for every delete operation
-- and store the old data for every update operation.
-- EMP(Empno, Empname, salary);

drop table EMP;
CREATE TABLE EMP (
    Empno INT PRIMARY KEY,
    Empname VARCHAR(255),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Emp_Backup (
    Empno INT,
    Empname VARCHAR(255),
    Date_of_operation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Type_of_operation ENUM('update', 'delete')
);

delimiter !!
create trigger after_delete after delete on emp for each row
begin
	insert into emp_backup(empno,empname,date_of_operation,type_of_operation)
		values
	(old.empno,old.empname,curdate(),'delete');
end !!
delimiter ;
delimiter !!
create trigger after_update after update on emp for each row
begin
	insert into emp_backup(empno,empname,date_of_operation,type_of_operation)
		values
	(old.empno,old.empname,curdate(),'update');
end !!
delimiter ;

insert into emp values(1,'gopal',45000);
update emp set empname='rohit' where empno=1;
select * from emp_backup;
delete from emp where empno=1;
select * from emp; 

-- --------------------------------------------------------------------- -------------
-- 6) WAT which display the message ‘Updating’,’Deleting’ or ’Inserting’ when Update,
-- Delete or Insert operation is performed on the emp table respectively.
drop table EMP;
CREATE TABLE EMP (
    Empno INT PRIMARY KEY,
    Empname VARCHAR(255),
    Salary DECIMAL(10, 2)
);
delimiter !!
create trigger before_insert_11 before insert on emp for each row
begin
	signal sqlstate '45000'  set 
		message_text = "insertion not allowed ";
end!!
delimiter ;
delimiter !!
create trigger before_update_11 before update on emp for each row
begin 
	signal sqlstate '45000' set 
		message_text = "updation not allowed ";
end !!
delimiter ;
delimiter !!
create trigger before_delete_11 before delete on emp for each row
begin 
	signal sqlstate '45000' set
		message_text = "deletion not allowed";
end !!
delimiter ;
insert into emp values(1,'gopal',45000);
update emp set empname='rohit' where empno=1;
-- -----------------------------------------------------------------------------------------------

-- 7) WAT which generate an error if any user try to delete from product_master table on
-- weekends (i.e. Saturday and Sunday).
create table product_master(
	product_id int,
    product_name varchar(50));
    
delimiter !!
create trigger prevent_delete before delete on product_master for each row
begin
	if dayofweek(now()) in (1,7) then
		 signal sqlstate '45000' set
         message_text="deletion is not allowed on weekend ";
	end if;
end !!
delimiter ;

-- ------------------------------------------------- ------------------------------------
-- 8) WAT which inserts the value of client_no in the client_master table whenever user tries
-- to insert data in the emp table. Generate primary key using sequence and enter the
-- client_no using that sequence.
-- Client_Master(client_no,client_name,address,city);
create table client_master(
	client_no int,
    client_name varchar(50),
    city varchar(50),
    address varchar(50));
-- -------------------------------------------- -----------------------------------------------------------
-- 9) WAT to calculate the Income Tax amount and insert it in emp table..
-- EMP(emp_no,emp_name, emp_income, income_tax);
-- If emp_income <100000 and >=50000 then incometax = 10%
-- If emp_income <200000 and >=100000 then incometax = 15%
-- If emp_income <300000 and >=200000 then incometax = 20%

drop table EMP;
CREATE TABLE EMP (
    Empno INT PRIMARY KEY,
    Empname VARCHAR(255),
    income DECIMAL(10, 2),
    tax decimal(10,2)
);
delimiter !!
create trigger before_insert_23 before insert on emp for each row
begin
-- declare tax decimal(10,2); 
	-- insert into emp(empno,empname,income,tax) values
-- 		(new.empno,new.empname,new.income,new.tax);
--         
        if (new.income < 100000) and (new.income > 500000)
			then set new.tax=(new.income*0.10);
		elseif(new.income >200000) and (new.income > 100000)
			then set new.tax=(new.income)*0.15;
		elseif(new.income < 300000) and (new.income > 200000)
			then set new.tax= (new.income)*0.20;
		end if;
end !!
delimiter ;

insert into emp(empno,empname,income) values(3,'gopal',300000);
select * from emp;

-- ========================================================================
-- Cursor
-- =================================-- ========================================
-- 1) Create a cursor for the emp table. Produce the output in following format:
-- {empname} employee working in department {deptno} earns Rs. {salary}.
-- EMP(empno, empname, salary, deptno);
drop table emp;
create table EMP(
	empno int,
    empname varchar(40),
    salary int,
    deptno int ,
    deptname varchar(50),
    city varchar(50),
    doj date
    );
  insert into EMP values
     (1,'sunil',100000,001,'MCA','Delhi','2015-12-12'),
     (2,'piyush',60000,002,'MSC','Bombay','2018-2-28'),
     (3,'jayesh',80000,003,'ANIMATION','Baroda','2017-05-05'),
     (4,'prakash',70000,004,'DESIGN','Banglore','2020-07-15');
     
 DELIMITER @@
CREATE PROCEDURE asdg()
BEGIN 
    declare emp_name varchar(50);
    declare dept_no int;
    declare emp_salary int;
    declare done int default 0;
    declare emp_cursor cursor for select empname,deptno,salary from emp;
    declare continue handler for not found set done=-1;
    open emp_cursor;
    fetch emp_cursor into emp_name,dept_no,emp_salary;
    emp:loop
		if done=-1 then
			leave emp;
		end if;
        
        select concat(emp_name, ' employee working on department ' ,dept_no, 'earn RS. ' ,emp_salary)
        as employee_details;
        fetch emp_cursor into emp_name,dept_no,emp_salary;
	end loop;
	close emp_cursor;
end @@
delimiter ;
call asdg();

-- ---------------------------------------------------------------------------------- -------------
-- 2) Create a cursor for updating the salary of emp working in deptno 10 by 20%.
-- If any rows are affected than display the no of rows affected. Use implicit cursor.
delimiter !!
create procedure updatingg()
begin
	declare dept_no int;
    declare emp_salary int;
    declare emp_name varchar(40);
    declare done int default 0;
    declare update_cursor cursor for select salary,empname from emp where deptno=001;
    declare continue handler for not found set done =-1;
    open update_cursor;
    emp1:loop
    fetch update_cursor into emp_name,emp_salary;
			if done then
				leave emp1;
			end if;
            update emp set salary=salary* 1.12 where empname=emp_name;
		end loop;
	close update_cursor;
end !!
delimiter ;
call updatingg();
-- -------------------------- ---------------------------------------------------------------
-- 4) WAP that will display the name, department and salary of the first 10 employees
-- getting the highest salary.

-- delimiter !!
-- create procedure gett_salar()
-- begin
-- 	declare emp_name varchar(50);
--     declare dept_no int;
--     declare emp_salary int;
--     declare done int default 0;
--     declare salary_cursor cursor for select empname,deptno,max(salary) as max_salary from emp
--     group by empname,salary,deptno limit 4;
--     declare continue handler for not found set done =-1;
--     open salary_cursor;
--     salary:loop
-- 		if done then 
-- 			leave salary;
-- 		end if;	
--         
--         select concat(' name ' , emp_name , ' dept no ', dept_no , ' salary ' , emp_salary);
--         fetch salary_cursor into emp_name,dept_no,emp_salary;
-- 	end loop;
--     close salary_cursor;
-- end !!
-- delimiter ;
-- call gett_salar();

-- Change the delimiter for creating the stored procedure
DELIMITER !!

CREATE PROCEDURE e_ssalary()
BEGIN
    -- Declare variables to store cursor results
    DECLARE emp_name VARCHAR(50);
    DECLARE dept_no INT;
    DECLARE emp_salary INT;
    
    -- Declare variables for cursor handling
    DECLARE done INT DEFAULT 0;
    
    -- Declare cursor with proper grouping and limit
    DECLARE salary_cursor CURSOR FOR 
        SELECT empname, deptno, MAX(salary) AS max_salary 
        FROM emp 
        GROUP BY empname, deptno 
        LIMIT 4;

    -- Declare handler for not found condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = -1;

    -- Open the cursor
    OPEN salary_cursor;

    -- Main loop to fetch and process cursor results
    salary_loop: LOOP
        -- Check if done flag is set, exit loop if true
        IF done THEN
            LEAVE salary_loop;
        END IF;

        -- Fetch data into variables
        FETCH salary_cursor INTO emp_name, dept_no, emp_salary;

        -- Display information (you may want to adjust this part based on your needs)
        select  concat('employee name : ',emp_name)'Name',
						concat('department name : ',dept_no)'Department',
                        concat('salary : ',emp_salary)'Highest';
    END LOOP;

    -- Close the cursor
    CLOSE salary_cursor;
END !!

-- Reset the delimiter to the default semicolon
DELIMITER ;

-- Call the stored procedure
CALL e_ssalary();

-- ------------------------------------------------------------------------------------------
-- ====================================================================================
-- FUNCTION
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-- +++++++++++++++++++++++++++++
-- 1) WAF which accepts the name from user and returns the length of that name.
delimiter !!
create function myfun(name varchar(50)) returns int deterministic
begin
	return length(name);
end!!
select myfun('ha moj ha')as length_of_name;

-- --------------- -----------------------------------------------------------------
-- 2) WAF which accepts one number and return TRUE if no is prime and return FALSE if
-- no is not prime.
delimiter !!
create function iis_prime( num int) returns bool deterministic
begin
declare i int default 2;
	while i*i < num do
		if num % i=0 then 
		return false;
        end if;
	set i=i+1;
    end while;
    
    return num > 1;
end!!
delimiter ;
select iis_prime(97)'is_prime';
-- ------------------------------------------------
-- 3) -- Write a function which a-- ccept the department no and returns maximum salary of that
-- department. Handle the error if deptno does not exist or select statement return more
-- than one row.
-- EMP(Empno, deptno, salary).
drop table empl;
create table empl(
	emp_no int,
    deptno int,
    salary int);
insert into empl values (1,2,500000);
insert into empl values (11,12,150000);
insert into empl values (10,6,80000);
insert into empl values (5,6,70000);
insert into empl values (4,3,60000);

delimiter !!
create function lol(dept_no int)returns int deterministic
begin
declare emp_salary int;
	select max(salary) into emp_salary from empl where deptno=dept_no;
    if emp_salary is null then
		signal sqlstate '45000'
        set message_text="dept not found";
	end if;
    return emp_salary;
end!!
delimiter ;
select lol(6) as 'max';

-- -------------------------------------
-- 5) WAF which accepts one no and returns that no+100. Use INOUT mode.
delimiter !!
create function my_number(num int) returns int deterministic
begin 
	declare added_number int;
    select num+100 into added_number where num=num;
    return added_number;
end !!
delimiter ;
select my_number(123)'added';

-- ---------------------------------------------------------------------------------
-- Change the delimiter for creating the stored procedure
DELIMITER $$

CREATE PROCEDURE arithmetic_operations(IN num1 INT, IN num2 INT)
BEGIN
    DECLARE sum_result INT;
    DECLARE diff_result INT;
    DECLARE prod_result INT;
    DECLARE div_result FLOAT;
    
    -- Addition
    SET sum_result = num1 + num2;
    
    -- Subtraction
    SET diff_result = num1 - num2;
    
    -- Multiplication
    SET prod_result = num1 * num2;
    
    -- Division (checking if divisor is not zero)
    IF num2 <> 0 THEN
        SET div_result = num1 / num2;
    ELSE
        SET div_result = NULL; -- Handle division by zero
    END IF;
    
    -- Display results
    SELECT 'Sum:', sum_result AS result;
    SELECT 'Difference:', diff_result AS result;
    SELECT 'Product:', prod_result AS result;
    SELECT 'Division:', div_result AS result;
END $$

-- Reset the delimiter to the default semicolon
DELIMITER ;

-- Example usage
CALL arithmetic_operations(10, 5);
