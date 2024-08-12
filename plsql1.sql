create database plsql;  
use plsql;

create table EEMP(
empno int,
empname varchar (30)
);

insert into EEMP(empno,empname)  values
	(1,'rohit sharma'),
    (2,'shikhar dhavan'),
    (3,'suresh raina'),
    (4,'yuvraj singh'),
    (5,'sachin tendulkar'),
    (6,'kiron pollard'),
    (7,'dhoni'),
    (8,'virat kohli'),
    (9,'shreyash iyer'),
    (10,'simmons'),
    (11,'chrish gayle');
    
delimiter !!

create procedure getname(in emp_no int)

begin
	declare emp_name varchar(30);
    
    select empname into emp_name
    from EEMP
    where empno=emp_no;
    
    if emp_name is null then 
		signal sqlstate '45000'
        set message_text="employee number not exists";
    else
		select emp_name as empname;
        
	end if;
end !!

delimiter ;
call getname(1);
 -- ---------------------------------------------------------------------   
-- question (2)
create table student(
	stud_id int,
    stud_name varchar(50),
    city varchar(50),
    m1 int,
    m2 int,
    m3 int
	);

insert into student (stud_id,stud_name,city,m1,m2,m3) values
	(1,'amit shah','Gandhinagar',70,80,85),
    (2,'j p nadda','bilaspur',80,85,90),
    (3,'nitin gadkari','nagpur',80,90,99),
    (4,'yogi aadityanath','gorakhpur',50,60,70),
    (5,'gopal bera','jamnagar',65,70,75);
 --    select avg(m1+m2+m3) from student;
delimiter $$

create procedure getdata(in rollno int)

begin
	
    declare name varchar(50);
	
    select stud_name,city,m1,m2,m3
    from student
    where stud_id=rollno;
end $$

delimiter ;
call getdata(1);    

-- -========================================================================
-- Q 3

delimiter @@

create procedure checkletters(in input_name varchar(50) , out check_alphabets varchar(30))
	
    begin 
    
		if binary input_name = upper(input_name)
			then
				set check_alphabets ="UPPER";
		elseif binary input_name=lower(input_name)
			then
				set check_alphabets="LOWER";
		else 
			set check_alphabets="MIXCASE";
		end if;
        
	end @@
    
    delimiter ;
    call checkletters('Gopal',@result);
    select @result;
    
-- -=================================================================--------------------------=======-=-
-- 4) WAP which accepts the student rollno and returns the highest percent and name of that
--  student to the calling block.
-- STUDENT(Stud_ID,Stud_name,percent);

create table percentage (
	stud_id int,
    stud_name varchar(50),
    percent float
    );
    
insert into percentage(stud_id,stud_name,percent) values
	(1,'john canady',82.98),
    (2,'abraham linclon',85.67),
    (3,'barak obama',98.00),
    (4,'donald trump',75.75),
    (5,'joe bidden',30.35);
    
    
delimiter ##

create procedure highestper(out highest_percent float,out  name varchar(50))
	
    begin
		
        select max(percent) into highest_percent
        from percentage;
        
        select stud_name into name
        from percentage
		where percent=highest_percent;
        
	end ##
    
    delimiter ;
    call highestper(@highest_percent,@name);
    select @name as StudentName,@highest_percent as HighestPercentage;
    
    
-- 5) WAP which accepts the date of joining for specific employee and returns the years of
-- experience along with its name. Accept the Employee no from user.
-- EMP(empno, empname, DOJ);

create table employee(
	empno int,
    empname varchar(50),
    DOJ date
	);
    
insert into employee (empno,empname,DOJ) values
	(1,'rahul gandhi','2001-01-12'),
    (2,'indira gandhi','2000-05-25'),
    (3,'manmohansinh','2004-02-28'),
    (4,'Ashok Gehlot','2012-08-15'),
    (5,'lalu yadav','2015-05-05');
    

 DELIMITER $$

 CREATE PROCEDURE experience(IN emp_no INT, OUT year_of_exp INT, INOUT emp_name VARCHAR(50))
 BEGIN
     -- SELECT empname INTO emp_name FROM employee;
     SELECT (YEAR(NOW())-YEAR(DOJ)), empname INTO year_of_exp, emp_name
     FROM employee
     WHERE empno = emp_no;
 END $$

 DELIMITER ;

 CALL experience(5, @year_of_exp, @emp_name);
 SELECT  @emp_name AS EmployeeName,@year_of_exp AS YearsOfExperience;

-- ==============----------===================================================--------------
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

call calculation(3,@result,@percentage);
select @result as result,@percentage as percentage ;

-- ===================================================================================================

-- 1) Create a cursor for the emp table. Produce the output in following format:
-- {empname} employee working in department {deptno} earns Rs. {salary}.
-- EMP(empno, empname, salary, deptno);

drop table if exists EMP;
create table EMP(
	empno int,
    empname varchar(40),
    salary int,
    deptno int ,
    deptname varchar(50),
    city varchar(50),
    doj date
    );
    drop table EMP;
  insert into EMP values
     (1,'sunil',100000,001,'MCA','Delhi','2015-12-12'),
     (2,'piyush',60000,002,'MSC','Bombay','2018-2-28'),
     (3,'jayesh',80000,003,'ANIMATION','Baroda','2017-05-05'),
     (4,'prakash',70000,004,'DESIGN','Banglore','2020-07-15');
    
    DELIMITER @@
CREATE PROCEDURE details()
BEGIN 
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary INT;
    DECLARE dept_no INT;
    DECLARE emp_cursor CURSOR FOR SELECT empname, deptno,salary FROM EMP;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN emp_cursor;
    FETCH emp_cursor INTO emp_name, dept_no, emp_salary;
    emp: LOOP
        IF done = 1 THEN
            LEAVE emp; 
        END IF;
        SELECT CONCAT(emp_name,' employee working in department ',dept_no,' earning Rs.',emp_salary) AS EmployeeDetails;
        FETCH emp_cursor INTO emp_name, dept_no, emp_salary;
    END LOOP;
    CLOSE emp_cursor;
END @@
DELIMITER ;
 
call details();

-----------------------------------------------------------------------------------------------------

-- 2) Create a cursor for updating the salary of emp working in deptno 10 by 20%.
-- If any rows are affected than display the no of rows affected. Use implicit cursor.

DELIMITER ## 
CREATE PROCEDURE updating()
BEGIN
    DECLARE done boolean DEFAULT FALSE;
    DECLARE emp_no INT;
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE cursor_employee CURSOR FOR SELECT empno, salary FROM EMP WHERE deptno = 001;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_employee;
    employee_loop: LOOP
        FETCH cursor_employee INTO emp_no, emp_salary;
        IF done THEN 
            LEAVE employee_loop;
        END IF;
        UPDATE EMP SET salary = salary * 1.2 WHERE empno = emp_no;
    END LOOP;
    CLOSE cursor_employee;

	end ##
DELIMITER ;

call updating();
select * from EMP;

-- ----------------------------------- ------------------------------------------------------------------
-- 3) Create a cursor for updating the salary of emp working in deptno 10 by 20%.
-- Use explicit cursor.
-- EMP(empno, empname, salary, deptno);
 --   -------------------------------------------------------------------------------------------------
 
 -- -------
--  4) WAP that will display the name, department and salary of the first 10 employees
-- getting the highest salary.


select * from EMP;
delimiter $$
	create procedure showing()
		begin
			declare emp_name varchar(50);
            declare dept_name varchar(50) ;
            declare emp_salary int;
            declare done boolean default false;
            
            declare cursor_show cursor for select empname,deptname,salary 
            from EMP order by salary desc;
            
            declare continue handler for not found set done=true;
            
            open cursor_show;
            
            show_loop : loop
				fetch cursor_show into emp_name,dept_name,emp_salary;
                
			if done then 
				leave show_loop;
			end if ;
				select  concat('employee name : ',emp_name)'Name',
						concat('department name : ',dept_name)'Department',
                        concat('salary : ',emp_salary)'Highest';
            
            end loop show_loop;
            close cursor_show;
		end $$ 
        
delimiter ;
call showing();

-- ------------------------------------------------------------------------------------------------------
-- 5) WAP using parameterized cursor to display all the information of employee living in
-- specified city. Ask the city from user.
   select * from EMP;
     delimiter %% 
		create procedure WAP(in cityname varchar(50))
			begin
				declare emp_name varchar(50);
                declare emp_no int ;
                declare emp_salary int;
                declare dept_no int;
                declare dept_name varchar(50);
                declare emp_city varchar(50);
                declare done boolean default false;
                
                declare  shown cursor for select empno,empname,salary,deptno,deptname,city
                from EMP where city=cityname;
                
                declare continue handler for not found set done=true;
                
                open shown;
                
                emp_loop:loop
					fetch shown  into emp_no,emp_name,emp_salary,dept_no,dept_name,emp_city;
                    
				if done then 
				leave emp_loop;
                end if;
                
					select concat('EmpId : ',emp_no)'id',
						   concat('EmpName : ',emp_name)'Name',
                           concat('Salary : ',emp_salary)'Salary',
                           concat('Dept_no : ',dept_no)'Department No',
                           concat('Dept Name : ',dept_name)'Department name',
                           concat('city : ',emp_city)'Employee city' ;
					
                    end loop emp_loop;
                    close shown;
            end %%
		delimiter ;
        
        call WAP('Banglore');
			
-- -------------------------------------------------------------------------------------------------
-- 6) WAP which display the sum of salary department wise. 

	delimiter !!
		create procedure display( )
	begin 
		declare sum_salary int;
        declare dept_no int;
        declare dept_name varchar(50);
		declare done boolean default false;
        
        declare display_salary cursor for select deptno,deptname,sum(salary) from EMP
        group   by deptno,deptname;
        
        declare continue handler for not found set done=true;
        
        open display_salary;
        salary_loop:loop
			
            fetch display_salary into dept_no,dept_name,sum_salary;
		
        if done =true then leave
         salary_loop;
		end if;
        
				select concat('dept_no',dept_no)'Department_no',
					   concat('dept_name',dept_name)'Department name',
                       concat('sum_salary',sum_salary)'Sum Of Salary';
		end loop salary_loop;
        close  display_salary;
	end !!
    delimiter ;    
	
    call display();
    
-- ======================================================================================================
-- 1) WAF which accepts the name from user and returns the length of that name.

delimiter @@
	create function lng(input_name varchar(100) )returns int deterministic
		
        begin 
			declare name_length int;
            set name_length =length(input_name);
            
            return name_length;
		end @@
	delimiter ;
    
    select lng('rohit sharma')'length of name' ;
    
-- -----------------------------------------------------------------------------------------------
-- 2) WAF which accepts one number and return TRUE if no is prime and return FALSE if
-- no is not prime.

delimiter !!
	create function checking(num int  ) returns boolean  deterministic
		
        begin 
			
            declare x int default 2;
            
            if  num <= 2 then
				return false;
			end if;
            
            while x <= num / 2 do 
				if num % x = 0 then
					return false;
				end if;
                set x = x+1;
			end while;
            return true;
		end !!
	delimiter ;
    
    select checking(3) ;
    
-- ----------------------------------------------------------------------------------------
-- 3) Write a function which accept the department no and returns maximum salary of that
-- department. Handle the error if deptno does not exist or select statement return more
-- than one row.

delimiter !! 
	create function fun(dept_no int) returns int deterministic
		begin 
			declare maxsalary int ;
            declare message_text varchar(100);
            select max(salary) into maxsalary from EMP
            where deptno=dept_no;
            
            if maxsalary is null then 
				signal sqlstate '45000'
                set message_text ='Department number does not exist :';
			end if;
            
            return maxsalary;
		end !!
	delimiter ;
    
    select fun(1) 'maximum salary';
    
-- ---------------------------------------------------------------------------------------------------
-- 4) Write a function to display whether the inputed employee no is exists or not.

delimiter !!
	create function exist(emp_no int) returns boolean deterministic
		
        begin
			declare employee boolean;
            
            select count(*) into employee from EMP
            where empno=emp_no;
            
            return employee;
		end !!
	delimiter ;
    
    select exist(5);
    
-- ------------------------------------------------------------------- --------
-- 5) WAF which accepts one no and returns that no+100. Use INOUT mode.
delimiter @@
	create function nomber( num int) returns int deterministic
		begin 
			declare res int ;
			set res =num +100;
			return res;
        end @@
	delimiter ;
    select nomber(101) 'new number';
    
-- --------------------------------------------------------------------------------------------
-- 6) WAF which accepts the empno. If salary<10000 than give raise by 30%.
-- If salary<20000 and salary>=10000 than give raise by 20%. If salary>20000 than
-- give raise by 10%. Handle the error if any.
select * from EMP;

delimiter !!
	
    create function increse(emp_no int )returns int deterministic
		begin 
			declare emp_salary int;
            declare result int;
            
            
            select salary into emp_salary from EMP
            where empno=emp_no;
            if emp_no > 4 then 
				signal sqlstate '45000'
                set message_text='employee does not exist : ';
			end if;
			
            if emp_salary < 70000 then 
				set result = emp_salary * 0.30;
			elseif emp_salary > 70000 and emp_salary < 90000 then 
				set result=emp_salary * 0.20;
			elseif emp_salary  > 90000 then 
				set result=emp_salary * 0.10;
			else
				set result=emp_salary * 0.10;
			end if;
            set emp_salary=emp_salary+result;
            return emp_salary;
			
			
		end !!
	delimiter ;
    
    select increse(4)'raised salary';
        
-- ------------------------------------------------------------------------------------------------------
-- 7) WAF which accepts the empno and returns the experience in years. Handle the error if
-- empno does not exist.
-- EMP(Empno, Empname, DOJ);

describe EMP;
select * from EMP  ;
select (year(now())-(year(doj))) from EMP;
delimiter ++
	create function experience(emp_no int ) returns int deterministic
		begin 
			declare years int;
            declare result int;
            
            select (year(now())-(year(doj))) into years
            from EMP where empno=emp_no;
            
            if emp_no > 4 then 
				signal sqlstate '45000'
                set  message_text ='employee no does not exist:';
			end if;
            return years;
		end ++
	delimiter ;
    select experience(1)'experience ';
    
-- =====================================================================================================
-- 1) Write a Trigger that stores the old data table of student table in student_backup while
-- updating the student table.
-- Student_backup (Stud_ID, Stud_name, Address, Contact_no, Branch, Operation_date)
-- Student (Stud_ID, Stud_name, Address, Contact_no, Branch)

drop table if exists Student;
create table Student (
	stud_id int ,
    stud_name varchar(50),
    address varchar(50),
    contact_no varchar(15),
    branch varchar(50)
    );
create table student_backup(
	stud_id int,
    stud_name varchar(50),
    address varchar(50),
    contact_no varchar(15),
    branch varchar(50),
    operation_date date
    );
    insert into student values
		(1,'gopal','amadavad','9313904218','computer engineering'),
        (2,'mohit','jamnagar','7984581449','Diploma');
delimiter !!
	create trigger backup_student_data before update on student for each row
		begin
			
            insert into student_backup(stud_id,stud_name,address,contact_no,branch,operation_date) 
            values
            (old.stud_id,old.stud_name,old.address,old.contact_no,old.branch,now());
		end !!
delimiter ;

update student set  branch='MCA' where stud_id=1;
update student set  branch='Arts' where stud_id=2;
select * from student;
select * from student_backup;

-- -----------------------------------------------------------------------------------------------------
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
	create trigger emp_before_update before insert on employee for each row
		begin 
			if left(new.emp_no,1) !='E' or length(new.emp_no)!=6 then
				set new.emp_no=concat('E',lpad(right(new.emp_no,5),5,'0'));
			end if;
		end !!
delimiter ;
insert into employee values
	(1,'gopal',50000),
    (2,'mohit',60000),
    (3,'nikhil',70000);
    
select * from employee;

-- ---------------------------------------------------------------------------------------------------
-- 3) Write a trigger which checks the age of employee while inserting the record in emp
-- table. If it is negative than generate the error and display proper message.
drop table if exists employee;
create table employee(
	emp_id varchar(10),
    emp_name varchar(50),
    age int
    );
    
delimiter !!
	create trigger checking_age before insert on employee for each row
		begin 
			if new.age < 0 then 
				signal sqlstate '45000'
                set message_text ='unvalid age';
			end if;
		end !!
delimiter ;
insert into employee values 
(1,'gopal',25);
select * from employee;

-- ---------------------------------------------------------------------------------------------------
-- 4) Write a trigger which converts the employee name in upper case if it is inserted in any
-- other case. Change should be done before the insertion only.
drop table employee;
create table employee(
	emp_id varchar(10),
    emp_name varchar(50)
    );
delimiter !! 
	create trigger converts_name before insert on employee for each row
		begin
			if new.emp_name=lower(new.emp_name) then
				set new.emp_name=upper(new.emp_name);
			end if;
		end !!
delimiter ;
insert into employee(emp_id,emp_name) values
	('4','PARESH');
select * from employee;

-- --------------------------------------------------------------------------------------------------
-- 5) WAT that stores the data of emp table in emp_backup table for every delete operation
-- and store the old data for every update operation.
-- EMP(Empno, Empname, salary);
-- Emp_Backup(Empno,Empname,Date_of_operation,Type_of_operation(i.e.update or
-- delete));
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
	create trigger backup_on_delete after delete on EMP for each row
		begin 
			insert into emp_backup (empno,empname,type_of_operation) values 
            (old.empno,old.empname,'delete');
		end;
        !!
delimiter ;
delimiter !!
	create trigger backup_on_update after update on EMP for each row
		begin 
			insert into emp_backup (empno,empname,type_of_operation) values
            (old.empno,old.empname,'update');
		end ;
        !!
delimiter ;
insert into emp(Empno,empname,salary) values
	(1,'gopal',50000),
    (2,'shailesh',60000);
delete from emp where empno=1;

select * from emp_backup;
select * from emp;

update emp set empname='rohit sharma' where empno=2;
select * from emp_backup;

-- ------------------------------------------------------------------------------------------------------
-- 6) WAT which display the message ‘Updating’,’Deleting’ or ’Inserting’ when Update,
-- Delete or Insert operation is performed on the emp table respectively.   

delimiter !!
	create trigger before_update before update on emp for each row
		begin
			signal sqlstate '45000' 
            set message_text = 'updating';
		end !!
delimiter ;

delimiter !!
	create trigger after_delete after delete on emp for each row
		begin
			signal sqlstate '45000' 
            set message_text = 'deleting';
		end !!
delimiter ;

delimiter !!
	create trigger after_insert after insert on emp for each row
		begin 
			signal sqlstate '45000' 
            set message_text = 'inserting';
        end!!
delimiter !!

insert into emp values (4,'gopal',123456);

-- ------------------------------------------------------------------------------------------------------

-- 7) WAT which generate an error if any user try to delete from product_master table on
-- weekends (i.e. Saturday and Sunday).
create table product_master (
	product_id int,
    cust_id int,
    product_name varchar(50)
	);
create table weekend(
	saturday varchar(50),
    sunday varchar(50)
    );
delimiter !!
	create trigger before_delete before delete on product_master for each row
		begin
			declare dayofweek int;
            set dayOfweek=day(curdate());
            
            if dayOfweek=1 or dayOfweek=7 then 
				signal sqlstate '45000'
                set message_text='its sunday or saturday you can not delete';
			end if;
		end!!
delimiter ;

delete from product_master where cust_id=1;

-- ----------------------------------------------------------------------------------------------------
-- 8) WAT which inserts the value of client_no in the client_master table whenever user tries
-- to insert data in the emp table. Generate primary key using sequence and enter the
-- client_no using that sequence.
-- Client_Master(client_no,client_name,address,city);

create table client_master (
	client_no int auto_increment primary key,
    client_name varchar(50),
    address varchar(50),
    city varchar(50)
    );
    
DELIMITER $$

CREATE TRIGGER insert_client_no
AFTER INSERT ON emp
FOR EACH ROW
BEGIN
  DECLARE client_no INT;
  SELECT  client_seq INTO client_no;
  INSERT INTO Client_Master(client_no, client_name, address, city)
  VALUES (client_no, NEW.client_name, NEW.address, NEW.city);
END $$

DELIMITER ;

			insert into client_master (client_no,client_name,address,city) values
            ('gopal','maharashtra','mumbai');
		end !!
delimiter ;
select * from client_master;
-- -----------------------------------------------------------------------------------------------------
-- 9) WAT to calculate the Income Tax amount and insert it in emp table..
-- EMP(emp_no,emp_name, emp_income, income_tax);
-- If emp_income <100000 and >=50000 then incometax = 10%
-- If emp_income <200000 and >=100000 then incometax = 15%
-- If emp_income <300000 and >=200000 then incometax = 20%

create table EMP(
	emp_no int ,
    emp_name varchar(50),
    emp_income decimal(8,2),
    income_tax decimal(8,2)
    );
 -- drop table emp; 
 delimiter !!
 	create trigger empl_before_insert before insert on EMP for each row
 		begin
        declare tax float ;
 
 			if (new.emp_income < 100000) and (new.emp_income >= 50000 ) then 
 				set tax =0.10;
 			elseif(new.emp_income < 200000) and (new.emp_income >= 100000) then
 				set tax =0.15;
			elseif (new.emp_income < 300000) and (new.emp_income >= 200000) then
 				set tax =0.20;
 			else
 				set tax =0;
 			end if;
            
            set new.income_tax = new.emp_income * tax;
 		end !!
 delimiter ;

insert into EMP(emp_name,emp_income) values ('sailesh',100000.0);
select * from emp;
drop table EMP;
-- ====================================================================================================
CREATE TABLE EMP(
	emp_no INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_income DECIMAL(8,2),
    income_tax DECIMAL(8,2)
);

DELIMITER !!
CREATE TRIGGER empl_before_insert BEFORE INSERT ON EMP FOR EACH ROW
BEGIN
    DECLARE tax FLOAT;
    IF (NEW.emp_income < 100000) AND (NEW.emp_income >= 50000) THEN 
        SET tax = 0.10;
    ELSEIF (NEW.emp_income < 200000) AND (NEW.emp_income >= 100000) THEN
        SET tax = 0.15;
    ELSEIF (NEW.emp_income < 300000) AND (NEW.emp_income >= 200000) THEN
        SET tax = 0.20;	
    ELSE
        SET tax = 0;
    END IF;
    SET NEW.income_tax = NEW.emp_income * tax;
END !!
DELIMITER ;

INSERT INTO EMP(emp_name,emp_income) VALUES ('sailesh',100000.0);
SELECT * FROM EMP;
