create database temp;
use temp;

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    BaseSalary DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    Designation VARCHAR(255)
);


INSERT INTO Employee (EmployeeID, BaseSalary, NetSalary, Designation)
VALUES
    (1, 60000.00, NULL, 'Manager'),
    (2, 50000.00, NULL, 'Developer'),
    (3, 45000.00, NULL, 'Analyst'),
    (4, 70000.00, NULL, 'Manager'),
    (5, 55000.00, NULL, 'Developer'),
    (6, 48000.00, NULL, 'Analyst'),
    (7, 75000.00, NULL, 'Manager'),
    (8, 52000.00, NULL, 'Developer'),
    (9, 47000.00, NULL, 'Analyst'),
    (10, 68000.00, NULL, 'Manager');

DELIMITER //

CREATE PROCEDURE calculateAndUpdateNetSalary(IN empID INT, IN baseSalary DECIMAL(10,2))
BEGIN
    DECLARE designation VARCHAR(255);
    DECLARE netSalary DECIMAL(10,2);

   
    SELECT Designation INTO designation FROM Employee WHERE EmployeeID = empID;


    IF designation = 'Manager' THEN
        SET netSalary = baseSalary + (baseSalary * 0.15);
    ELSEIF designation = 'Developer' THEN
        SET netSalary = baseSalary + (baseSalary * 0.10);  
    ELSE
        SET netSalary = baseSalary;
    END IF;

   
    UPDATE Employee SET NetSalary = netSalary WHERE EmployeeID = empID;

    SELECT * FROM Employee WHERE EmployeeID = empID;

END //

DELIMITER ;
call calculateAndUpdateNetSalary(1,50000);