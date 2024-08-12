create database xyz;
use xyz;

CREATE TABLE client_master (
  Client_No VARCHAR(6) NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Address1 VARCHAR(30),
  Address2 VARCHAR(30),
  City VARCHAR(15),
  Pincode int(8),
  State VARCHAR(15),
  Bal_due double (10,2),
  CONSTRAINT client_master_pk PRIMARY KEY (Client_No)
);


INSERT INTO client_master (Client_No, Name, City, Pincode, State, Bal_Due)
VALUES
('C00001', 'Ivan Bayross', 'Bombay', 400054, 'Maharastra', 15000),
('C00002', 'Vandana Saitwal', 'Madras', 780001, 'Tamil Nadu', 0),
('C00003', 'Pramada Jaguste', 'Bombay', 400057, 'Maharastra', 5000),
('C00004', 'Basu Navindgi', 'Bombay', 400056, 'Maharastra', 0),
('C00005', 'Ravi Sreedharan', 'Delhi', 100001, 'Delhi', 2000),
('C00006', 'Rukmini', 'Bombay', 400050, 'Maharastra', 0);

select*from client_table;