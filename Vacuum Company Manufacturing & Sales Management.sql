/* =====================================================
   DATABASE: Vacuum Company Manufacturing & Sales System
   Author: Peter Ho
   Description:
     - This schema models a vacuum manufacturing company.
     - It tracks models, vacuums, designers, technicians,
       inspections, customers, and orders.
===================================================== */

------------------------------------------------------
-- DROP TABLES IN REVERSE DEPENDENCY ORDER
IF OBJECT_ID('Order', 'U') IS NOT NULL DROP TABLE [Order];
IF OBJECT_ID('Inspection', 'U') IS NOT NULL DROP TABLE Inspection;
IF OBJECT_ID('Vacuum_Designer', 'U') IS NOT NULL DROP TABLE Vacuum_Designer;
IF OBJECT_ID('Vacuum', 'U') IS NOT NULL DROP TABLE Vacuum;
IF OBJECT_ID('Model', 'U') IS NOT NULL DROP TABLE Model;
IF OBJECT_ID('Customer', 'U') IS NOT NULL DROP TABLE Customer;
IF OBJECT_ID('CustomerServiceRep', 'U') IS NOT NULL DROP TABLE CustomerServiceRep;
IF OBJECT_ID('Designer', 'U') IS NOT NULL DROP TABLE Designer;
IF OBJECT_ID('Technician', 'U') IS NOT NULL DROP TABLE Technician;

-- CREATE TABLES

--Vacuum Model Details
CREATE TABLE Model (
    ModelCode VARCHAR(10) PRIMARY KEY,
    ModelName VARCHAR(50),
    ModelColors VARCHAR(50),
    Price DECIMAL(10,2)
);

--Individual vacuum units tied to models
CREATE TABLE Vacuum (
    SerialNumber VARCHAR(20) PRIMARY KEY,
    DateOfManufacture DATE,
    ModelCode VARCHAR(10),
    FOREIGN KEY (ModelCode) REFERENCES Model(ModelCode)
);

--Who created the models
CREATE TABLE Designer (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    DateEmployed DATE,
    ContactNumber VARCHAR(20),
    StreetNumber VARCHAR(10),
    StreetName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(10),
    ZipCode VARCHAR(10)
);

--Links vacuum to designers who contributed to them
CREATE TABLE Vacuum_Designer (
    SerialNumber VARCHAR(20),
    EmployeeID VARCHAR(10),
    PRIMARY KEY (SerialNumber, EmployeeID),
    FOREIGN KEY (SerialNumber) REFERENCES Vacuum(SerialNumber),
    FOREIGN KEY (EmployeeID) REFERENCES Designer(EmployeeID)
);

--Technicians who inspects vacuums, supports supervisor relationships
CREATE TABLE Technician (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    DOB DATE,
    DateEmployed DATE,
    ContactNumber VARCHAR(20),
    StreetNumber VARCHAR(10),
    StreetName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(10),
    ZipCode VARCHAR(10),
    SupervisorID VARCHAR(10) NULL,
    FOREIGN KEY (SupervisorID) REFERENCES Technician(EmployeeID)
);

--Inspection results for each vacuum
CREATE TABLE Inspection (
    InspectionID VARCHAR(10) PRIMARY KEY,
    DateOfInspection DATE,
    Status VARCHAR(20),
    SerialNumber VARCHAR(20),
    TechnicianID VARCHAR(10),
    FOREIGN KEY (SerialNumber) REFERENCES Vacuum(SerialNumber),
    FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID)
);

--Employees handeling customer orders
CREATE TABLE CustomerServiceRep (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    DateEmployed DATE,
    ContactNumber VARCHAR(20),
    StreetNumber VARCHAR(10),
    StreetName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(10),
    ZipCode VARCHAR(10)
);

--Customer information and details
CREATE TABLE Customer (
    PhoneNumber VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    StreetNumber VARCHAR(10),
    StreetName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(10),
    ZipCode VARCHAR(10),
    CreditCardNumber VARCHAR(20)
);

--Links customers, vacuums, and customer service reps
CREATE TABLE [Order] (
    OrderID VARCHAR(10) PRIMARY KEY,
    PhoneNumber VARCHAR(20),
    SerialNumber VARCHAR(20),
    EmployeeID VARCHAR(10),
    FOREIGN KEY (PhoneNumber) REFERENCES Customer(PhoneNumber),
    FOREIGN KEY (SerialNumber) REFERENCES Vacuum(SerialNumber),
    FOREIGN KEY (EmployeeID) REFERENCES CustomerServiceRep(EmployeeID)
);

------------------------------------------------------
--INSERT SAMPLE DATA
------------------------------------------------------

--Models
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M001', 'Model-A', 'Black', '166.56');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M002', 'Model-B', 'Red', '307.64');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M003', 'Model-C', 'Blue', '367.3');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M004', 'Model-D', 'Blue', '224.1');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M005', 'Model-E', 'Red', '378.2');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M006', 'Model-F', 'Black', '182.3');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M007', 'Model-G', 'Red', '166.26');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M008', 'Model-H', 'Red', '284.06');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M009', 'Model-I', 'Black', '243.19');
INSERT INTO Model (ModelCode, ModelName, ModelColors, Price) VALUES ('M010', 'Model-J', 'Blue', '308.14');

-- Vacuums
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1001', '2021-07-08', 'M002');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1002', '2013-09-27', 'M004');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1003', '2007-10-31', 'M006');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1004', '2014-05-21', 'M006');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1005', '2012-06-08', 'M004');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1006', '2022-08-15', 'M007');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1007', '2017-08-03', 'M001');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1008', '2014-12-11', 'M008');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1009', '2016-08-17', 'M009');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1010', '2016-08-18', 'M001');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1011', '2016-08-19', 'M002');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1012', '2016-08-20', 'M005');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1013', '2016-08-21', 'M007');
INSERT INTO Vacuum (SerialNumber, DateOfManufacture, ModelCode) VALUES ('SN1014', '2016-08-22', 'M008');

-- Designers
VALUES ('D001', 'Designer 1', '1982-10-27', '2014-01-03', '555-700-001', '123', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D002', 'Designer 2', '1983-03-14', '2013-05-01', '555-700-002', '124', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D003', 'Designer 3', '1984-04-12', '2015-06-15', '555-700-003', '125', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D004', 'Designer 4', '1985-06-09', '2016-07-20', '555-700-004', '126', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D005', 'Designer 5', '1986-08-22', '2012-03-10', '555-700-005', '127', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D006', 'Designer 6', '1987-11-30', '2011-10-12', '555-700-006', '128', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D007', 'Designer 7', '1988-02-18', '2014-01-28', '555-700-007', '129', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D008', 'Designer 8', '1989-09-10', '2017-04-17', '555-700-008', '130', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D009', 'Designer 9', '1990-07-25', '2018-02-05', '555-700-009', '131', 'Creative Blvd', 'Artville', 'GA', '30001'),
('D010', 'Designer 10', '1991-12-03', '2020-06-23', '555-700-010', '132', 'Creative Blvd', 'Artville', 'GA', '30001');



--Vacuum-Designers(many-to-many)
INSERT INTO Vacuum_Designer (SerialNumber, EmployeeID) VALUES ('SN1000', 'D001'),
('SN1001', 'D002'),
('SN1002', 'D003'),
('SN1003', 'D004'),
('SN1004', 'D005'),
('SN1005', 'D006'),
('SN1006', 'D007'),
('SN1007', 'D008'),
('SN1008', 'D009'),
('SN1009', 'D010');

--Technicians and Supervisors
INSERT INTO Technician (EmployeeID, Name, Age, DOB, DateEmployed, ContactNumber, StreetNumber, StreetName, City, State, ZipCode, SupervisorID)
VALUES 
('T001', 'Supervisor 1', 40, '1982-05-15', '2013-06-01', '555-TECH-1', '200', 'Service Ln', 'Maintown', 'GA', '30100', NULL),
('T002', 'Supervisor 2', 41, '1983-05-15', '2014-06-01', '555-TECH-2', '201', 'Service Ln', 'Maintown', 'GA', '30101', NULL),
('T003', 'Supervisor 3', 42, '1984-05-15', '2015-06-01', '555-TECH-3', '202', 'Service Ln', 'Maintown', 'GA', '30102', NULL);

-- Technicians reporting to a supervisor
INSERT INTO Technician (EmployeeID, Name, Age, DOB, DateEmployed, ContactNumber, StreetNumber, StreetName, City, State, ZipCode, SupervisorID)
VALUES 
('T004', 'Technician 4', 33, '1985-07-10', '2016-08-01', '555-TECH-4', '203', 'Service Ln', 'Maintown', 'GA', '30103', 'T001'),
('T005', 'Technician 5', 34, '1986-07-10', '2017-08-01', '555-TECH-5', '204', 'Service Ln', 'Maintown', 'GA', '30104', 'T002'),
('T006', 'Technician 6', 35, '1987-07-10', '2018-08-01', '555-TECH-6', '205', 'Service Ln', 'Maintown', 'GA', '30105', 'T003'),
('T007', 'Technician 7', 36, '1988-07-10', '2019-08-01', '555-TECH-7', '206', 'Service Ln', 'Maintown', 'GA', '30106', 'T001'),
('T008', 'Technician 8', 37, '1989-07-10', '2020-08-01', '555-TECH-8', '207', 'Service Ln', 'Maintown', 'GA', '30107', 'T002'),
('T009', 'Technician 9', 38, '1990-07-10', '2021-08-01', '555-TECH-9', '208', 'Service Ln', 'Maintown', 'GA', '30108', 'T003'),
('T010', 'Technician 10', 39, '1991-07-10', '2022-08-01', '555-TECH-10', '209', 'Service Ln', 'Maintown', 'GA', '30109', 'T001'),
('T011', 'Technician 11', 31, '1992-07-10', '2023-08-01', '555-TECH-11', '210', 'Service Ln', 'Maintown', 'GA', '30110', 'T002'),
('T012', 'Technician 12', 32, '1993-07-10', '2023-09-01', '555-TECH-12', '211', 'Service Ln', 'Maintown', 'GA', '30111', 'T001'),
('T013', 'Technician 13', 33, '1994-07-10', '2023-10-01', '555-TECH-13', '212', 'Service Ln', 'Maintown', 'GA', '30112', 'T003');

--Inspections
INSERT INTO Inspection (InspectionID, DateOfInspection, Status, SerialNumber, TechnicianID)
VALUES ('I001', '2022-01-15', 'Pass', 'SN1000', 'T001'),
('I002', '2023-01-15', 'Fail', 'SN1002', 'T001'),
('I003', '2023-01-22', 'Pass', 'SN1003', 'T008'),
('I004', '2023-01-29', 'Fail', 'SN1004', 'T004'),
('I005', '2023-02-05', 'Pass', 'SN1005', 'T010'),
('I006', '2023-02-12', 'Fail', 'SN1006', 'T002'),
('I007', '2023-02-19', 'Pass', 'SN1007', 'T003'),
('I008', '2023-02-26', 'Fail', 'SN1008', 'T007'),
('I009', '2023-03-05', 'Pass', 'SN1009', 'T005'),
('I010', '2023-03-12', 'Fail', 'SN1001', 'T006'),
('I011', '2023-04-23', 'Fail', 'SN1010', 'T004'),
('I012', '2023-04-30', 'Fail', 'SN1011', 'T006'),
('I013', '2023-05-07', 'Fail', 'SN1012', 'T007'),
('I014', '2023-05-14', 'Fail', 'SN1013', 'T010'),
('I015', '2023-05-21', 'Fail', 'SN1014', 'T002');

--Customer Service Representative
INSERT INTO CustomerServiceRep (EmployeeID, Name, DOB, DateEmployed, ContactNumber, StreetNumber, StreetName, City, State, ZipCode)
VALUES ('C001', 'Customer Service Rep 1', '1985-01-10', '2015-02-01', '555-600-001', '301', 'Support Way', 'Helpville', 'GA', '31001'),
('C002', 'Customer Service Rep 2', '1986-02-15', '2016-03-05', '555-600-002', '302', 'Support Way', 'Helpville', 'GA', '31001'),
('C003', 'Customer Service Rep 3', '1987-03-20', '2017-04-10', '555-600-003', '303', 'Support Way', 'Helpville', 'GA', '31001'),
('C004', 'Customer Service Rep 4', '1988-04-25', '2018-05-15', '555-600-004', '304', 'Support Way', 'Helpville', 'GA', '31001'),
('C005', 'Customer Service Rep 5', '1989-05-30', '2019-06-20', '555-600-005', '305', 'Support Way', 'Helpville', 'GA', '31001'),
('C006', 'Customer Service Rep 6', '1990-06-10', '2020-07-25', '555-600-006', '306', 'Support Way', 'Helpville', 'GA', '31001'),
('C007', 'Customer Service Rep 7', '1991-07-15', '2021-08-30', '555-600-007', '307', 'Support Way', 'Helpville', 'GA', '31001'),
('C008', 'Customer Service Rep 8', '1992-08-20', '2022-09-05', '555-600-008', '308', 'Support Way', 'Helpville', 'GA', '31001'),
('C009', 'Customer Service Rep 9', '1993-09-25', '2023-10-10', '555-600-009', '309', 'Support Way', 'Helpville', 'GA', '31001'),
('C010', 'Customer Service Rep 10', '1994-10-30', '2023-11-15', '555-600-010', '310', 'Support Way', 'Helpville', 'GA', '31001');


--Customers
INSERT INTO Customer (PhoneNumber, Name, Email, StreetNumber, StreetName, City, State, ZipCode, CreditCardNumber)
VALUES ('404-555-0001', 'Customer 1', 'cust1@example.com', '401', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110001'),
('404-555-0002', 'Customer 2', 'cust2@example.com', '402', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110002'),
('404-555-0003', 'Customer 3', 'cust3@example.com', '403', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110003'),
('404-555-0004', 'Customer 4', 'cust4@example.com', '404', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110004'),
('404-555-0005', 'Customer 5', 'cust5@example.com', '405', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110005'),
('404-555-0006', 'Customer 6', 'cust6@example.com', '406', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110006'),
('404-555-0007', 'Customer 7', 'cust7@example.com', '407', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110007'),
('404-555-0008', 'Customer 8', 'cust8@example.com', '408', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110008'),
('404-555-0009', 'Customer 9', 'cust9@example.com', '409', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110009'),
('404-555-0010', 'Customer 10', 'cust10@example.com', '410', 'Maple St', 'Savannah', 'GA', '31401', '4111111111110010');


--Orders
INSERT INTO [Order] (OrderID, PhoneNumber, SerialNumber, EmployeeID)
VALUES ('O001', '404-555-0001', 'SN1000', 'C001'),
('O002', '404-555-0002', 'SN1001', 'C002'),
('O003', '404-555-0003', 'SN1002', 'C003'),
('O004', '404-555-0004', 'SN1003', 'C004'),
('O005', '404-555-0005', 'SN1004', 'C005'),
('O006', '404-555-0006', 'SN1005', 'C006'),
('O007', '404-555-0007', 'SN1006', 'C007'),
('O008', '404-555-0008', 'SN1007', 'C008'),
('O009', '404-555-0009', 'SN1008', 'C009'),c
('O010', '404-555-0010', 'SN1009', 'C010');

--List model code, name, and price for each vacuum
SELECT 
    V.SerialNumber,
    M.ModelCode,
    M.ModelName,
    M.Price
FROM Vacuum V
JOIN Model M ON V.ModelCode = M.ModelCode;

--Count vacuums manufactured after 2010
SELECT COUNT(*) AS Vacuums_After_2010
FROM Vacuum
WHERE YEAR(DateOfManufacture) > 2010;


--Technician who inspected the most vacuums
SELECT TOP 1 T.Name, COUNT(I.InspectionID) AS InspectionCount
FROM Inspection I
JOIN Technician T ON I.TechnicianID = T.EmployeeID
GROUP BY T.Name
ORDER BY InspectionCount DESC;

--Vacuums marked as "Fail" during inspection
-- Includes serial number, inspection date, and technician ID
SELECT 
    I.SerialNumber,
    I.DateOfInspection,
    I.TechnicianID
FROM Inspection I
WHERE I.Status = 'Fail';

--Model sold the most and CSR(s) who handled those orders
SELECT DISTINCT 
    V.ModelCode,
    CSR.EmployeeID,
    CSR.Name
FROM [Order] O
JOIN Vacuum V ON O.SerialNumber = V.SerialNumber
JOIN CustomerServiceRep CSR ON O.EmployeeID = CSR.EmployeeID
WHERE V.ModelCode = (
    SELECT TOP 1 ModelCode
    FROM [Order] O2
    JOIN Vacuum V2 ON O2.SerialNumber = V2.SerialNumber
    GROUP BY V2.ModelCode
    ORDER BY COUNT(*) DESC
);

--Supervisors and the technicians they oversee
SELECT 
    S.Name AS SupervisorName,
    T.Name AS TechnicianName
FROM Technician T
JOIN Technician S ON T.SupervisorID = S.EmployeeID;

--Display All Tables
-- 1. Display all Models
SELECT * FROM Model;

-- 2. Display all Vacuums
SELECT * FROM Vacuum;

-- 3. Display all Designers
SELECT * FROM Designer;

-- 4. Display all Vacuum_Designer relationships
SELECT * FROM Vacuum_Designer;

-- 5. Display all Technicians
SELECT * FROM Technician;

-- 6. Display all Inspections
SELECT * FROM Inspection;

-- 7. Display all Customer Service Representatives
SELECT * FROM CustomerServiceRep;

-- 8. Display all Customers
SELECT * FROM Customer;

-- 9. Display all Orders
SELECT * FROM [Order];
