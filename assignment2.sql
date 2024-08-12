create database a;
use a;

-- 1. Create the table
CREATE TABLE stud_marks (
    no INT,
    fname VARCHAR(255),
    lname VARCHAR(255),
    m1 INT,
    m2 INT,
    m3 INT,
    dob DATE
);

-- 2. Insert values into the table
INSERT INTO stud_marks VALUES
(1, 'Amit', 'Shah', 85, 90, 95, '2000-01-01'),
(2, 'Sachin', 'Tendulkar', 70, 75, 80, '2000-02-02'),
(3, 'Rahul', 'Dravid', 65, 70, 75, '2000-03-03'),
(4, 'Sourav', 'Ganguly', 60, 65, 70, '2000-04-04'),
(5, 'Virender', 'Sehwag', 55, 60, 65, '2000-05-05'),
(6, 'Yuvraj', 'Singh', 50, 55, 60, '2000-06-06'),
(7, 'Mahendra', 'Dhoni', 45, 50, 55, '2000-07-07'),
(8, 'Virat', 'Kohli', 40, 45, 50, '2000-08-08'),
(9, 'Rohit', 'Sharma', 35, 40, 45, '2000-09-09'),
(10, 'Shikhar', 'Dhawan', 30, 35, 40, '2000-10-10');

-- Rest of the queries remain the same


-- 3. Display the details in following order: RollNo, Lname, Fname
SELECT no AS RollNo, lname, fname FROM stud_marks;

-- 4. Find the current age of each student
SELECT no AS RollNo, fname, lname, TIMESTAMPDIFF(month, dob, CURDATE()) AS age FROM stud_marks;
select no,fname,lname,datediff(curdate(),date(dob))/365 *12'cur_age' from stud_marks;
select year(now())-year(dob) from stud_marks;

-- 5. Display the total marks of each student along with the rollno
SELECT no AS RollNo, fname, lname, (m1 + m2 + m3) AS total_marks FROM stud_marks;

-- 6. Display the percentage of each student
SELECT no AS RollNo, fname, lname, ((m1 + m2 + m3) / 3) AS percentage FROM stud_marks;

-- 7. Display the students scoring highest marks in each subject
SELECT MAX(m1) AS max_m1 , MAX(m2) AS max_m2, MAX(m3) AS max_m3 FROM stud_marks;

-- 8. Display the students scoring highest total marks
SELECT no AS RollNo, fname, lname, (m1 + m2 + m3) AS total_marks FROM stud_marks ORDER BY total_marks DESC LIMIT 1;

-- 9. Display the students whose name starts with ‘S’
SELECT * FROM stud_marks WHERE fname LIKE 'S%';

-- 10. Display the students whose surname ends with ‘kar’
SELECT * FROM stud_marks WHERE lname LIKE '%kar';

-- 11. List all the students who fails in any one of the subjects
-- Assuming that the passing mark is 50
SELECT * FROM stud_marks WHERE m1 < 50 OR m2 < 50 OR m3 < 50;

-- 12. List all the students who are passing in all subjects but the percentage < 60
SELECT * FROM stud_marks WHERE m1 >= 50 AND m2 >= 50 AND m3 >= 50 AND ((m1 + m2 + m3) / 3) < 60;

-- 13. List the students whose total marks are between 50 and 60
SELECT * FROM stud_marks WHERE (m1 + m2 + m3) BETWEEN 50 AND 60;

-- 14. List all the students whose name does not start with ‘S’
SELECT * FROM stud_marks WHERE fname NOT LIKE 'S%';

-- 15. Update the table, set marks m1=40 for those students who scored a total of atleast 100 marks in m2 and m3
UPDATE stud_marks SET m1 = 40 WHERE (m2 + m3) >= 100;

-- 16. Display the students whose marks are either 50, 60 or 70
SELECT * FROM stud_marks WHERE m1 IN (50, 60, 70) OR m2 IN (50, 60, 70) OR m3 IN (50, 60, 70);

-- 17. List all the students born in the month of January
SELECT * FROM stud_marks WHERE MONTH(dob) = 1;

-- 18. List all the students whose date of birth is an even number
SELECT * FROM stud_marks WHERE DAY(dob) % 2=0 and month(dob)%2 = 0 and year(dob)%2=0;

-- 19. Find the age of students in terms of months passed
SELECT no AS RollNo, fname, lname, TIMESTAMPDIFF(MONTH, dob, CURDATE()) AS age_in_months FROM stud_marks;

-- 20. Display the students whose date of birth falls in the first quarter of the year
SELECT * FROM stud_marks WHERE MONTH(dob) BETWEEN 1 AND 3;

-- 21. Find the date, 15 days after today’s date
SELECT DATE_ADD(CURDATE(), INTERVAL 15 DAY) AS date_after_15_days;

-- 22. List the students whose name contains vowels (small)
SELECT * FROM stud_marks WHERE fname REGEXP '[aeiou]';

-- 23. List the students whose name does not contain vowels
SELECT * FROM stud_marks WHERE fname NOT REGEXP '[aeiou]';

-- 24. Count the no. of students whose name starts with ‘S’
SELECT COUNT(*) AS count FROM stud_marks WHERE fname LIKE 'S%';

-- 25. Count the no. of students whose name ends with ‘kar’
SELECT COUNT(*) AS count FROM stud_marks WHERE lname LIKE '%kar';

-- 26. Display the names of student in following format Eg. If name is ‘hardik’ & surname is ‘joshi’ then display ‘harshi’
SELECT CONCAT(SUBSTRING(fname, 1, 3), SUBSTRING(lname, 1, 3)) AS new_name FROM stud_marks;

-- 27. Display the rows which contains null values in m1, m2 or m3
SELECT * FROM stud_marks WHERE m1 IS NULL OR m2 IS NULL OR m3 IS NULL;

-- 28. Display the rows which does not contain null values in name
SELECT * FROM stud_marks WHERE fname IS NOT NULL AND lname IS NOT NULL;

-- 29. Display the rows where name sounds like ‘sachin’ (use soundex function)
SELECT * FROM stud_marks WHERE SOUNDEX(fname) = SOUNDEX('sachin');

-- 30. Generate a random no. using date
SELECT RAND(DATE_FORMAT(CURDATE(), '%Y%m%d')) AS random_number;

-- 31. Display the output in following form: <Name was born on Day> Eg. Hardik was born on Thursday.
SELECT CONCAT(fname, ' was born on ', DAYNAME(dob)) AS birth_day FROM stud_marks;








select no as rollno,fname,lname from stud_marks;
select dob from stud_marks where year(dob)/2=0;