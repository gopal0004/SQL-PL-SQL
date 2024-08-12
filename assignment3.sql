create database assignment3;
use assignment3;

CREATE TABLE DEPOSIT (
    ACTNO VARCHAR(5),
    CNAME VARCHAR(18),
    BNAME VARCHAR(18),
    AMOUNT NUMeric(8,2),
    ADATE DATE
    
);

INSERT INTO DEPOSIT (ACTNO, CNAME, BNAME, AMOUNT, ADATE) VALUES
('100', 'ANIL', 'VRCE', 1000, '1995-03-01'),
('101', 'SUNIL', 'AJNI', 5000, '1998-01-04'),
('102', 'MEHUL', 'KAROLBAGH', 3500, '1995-11-17' ),
('104', 'MADHURI', 'CHANDNI', 1200,'1995-12-17'),
('105', 'PRAMOD', 'MGROAD', 3000, '1996-03-27'),
('106', 'SANDIP', 'ANDHERI', 2000,'1996-03-31'),
('107', 'SHIVANI', 'VIRAR', 1000, '1995-09-05'),
('108', 'KRANTI', 'NEHRUPLACE', 5000,'1995-07-2'),
('109', 'NAREN', 'POWAI', 7000, '1995-08-10');

CREATE TABLE BORROW (
    LOANNO VARCHAR(5),
    CNAME VARCHAR(18),
    BNAME VARCHAR(18),
    AMOUNT NUMERic(8,2)
);

INSERT INTO BORROW (LOANNO, CNAME, BNAME, AMOUNT) VALUES
('201', 'ANIL', 'VRCE', 1000),
('206', 'MEHUL', 'AJNI', 15000),
('311', 'SUNIL', 'DHARAMPETH', 3000),
('321', 'MADHURI', 'ANDHERI', 2000),
('375', 'PRAMOD', 'VIRAR', 8000),
('481', 'KRANTI', 'NEHRUPLACE', 3000);

CREATE TABLE CUSTOMER (
    CNAME VARCHAR(18),
    CITY VARCHAR(18) 
);

INSERT INTO CUSTOMER (CNAME, CITY) VALUES
('ANIL', 'CALCUTTA'),
('SUNIL', 'DELHI'),
('MEHUL', 'BARODA'),
('MANDAR', 'PATNA'),
('MADHURI', 'NAGPUR'),
('PRAMOD', 'NAGPUR'),
('SANDIP', 'SURAT'),
('SHIVANI', 'BOMBAY'),
('KRANTI', 'BOMBAY'),
('NAREN', 'BOMBAY');

CREATE TABLE BRANCH (
    BNAME VARCHAR(18),
    CITY VARCHAR(18)
    
);

INSERT INTO BRANCH (BNAME, CITY) VALUES
('VRCE', 'NAGPUR'),
('AJNI', 'NAGPUR'),
('KAROLBAGH', 'DELHI'),
('CHANDNI', 'DELHI'),
('DHARAMPTEH', 'NAGPUR'),
('MGROAD', 'BANGALORE'),
('ANDHERI', 'BOMBAY'),
('VIRAR', 'BOMBAY'),
('NEHRUPLACE', 'DELHI'),
('POWAI', 'BOMBAY');

select * from borrow b join customer c on b.cname=c.cname
join deposit d on d.cname=b.cname 
join branch br on br.bname=b.bname or br.bname=d.bname
where c.cname like '%anil%';


-- Give the name of customer having living city = Bombay and branch city = nagpur
select c.cname from customer c join branch br on c.city=br.city
where c.city='bombay' and br.city = 'nagpur';

-- Give name of customer having same living city as their branch city.
select distinct c.cname from customer c join branch br on c.city=br.city
where c.city=br.city;

-- Give the name of customer who are borrowers and depositers and having living city = Nagpur.
select c.cname from customer c join borrow b on c.cname=b.cname
join deposit d on c.cname=d.cname and b.cname=d.cname
and d.cname =c.cname  and c.city ='nagpur'; 

-- Give the name of customers who are depositors having same branch city of Sunil
select distinct  c.cname from customer c join deposit d on c.cname=d.cname
join branch br on c.city=br.city
where c.cname != 'sunil';

-- Give name of depositors having same living city as Anil and having deposit amount greater than 2000.
-- select d.cname from deposit d join borrow b on d.amount=b.amount join customer c on d.cname=c.cname 
-- where c.city in(select c.city from customer where c.cname like 'anil') and d.amount>2000;

-- Give name of depositors having same branch as branch of Sunil.
select d.cname from deposit d join branch br on d.bname=br.bname 
join customer c on br.city=c.city where br.city 
in (select c.city from customer c where c.cname like 'sunil');

-- give name of borrowers having loan amount greater than amount of Parmod.

select  cname,amount from borrow
where amount > (select amount from borrow  where cname='pramod');

-- Give name of Customers living in same city where branch of depositor sunil is located.
select cname from customer 
where city = (select distinct(d.bname) from deposit as d, customer as c
where c.cname=d.cname and c.cname='sunil');