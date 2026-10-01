-- HOSPITAL MANAGEMENT SYSTEM
-- DBMS IMPLEMENTATION USING MySQL
-- NORMALIZATION: UP TO 3NF

CREATE DATABASE Hospital_Management_System;
USE Hospital_Management_System;

-- 1. DEPARTMENT TABLE

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100),
    Phone VARCHAR(15),
    Head_Doctor VARCHAR(100),
    Description VARCHAR(255)
);

-- 2. PATIENT TABLE

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male','Female','Other')),
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(255)
);

-- 3. DOCTOR TABLE

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);

-- 4. APPOINTMENT TABLE

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    Status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
);

-- 5. MEDICAL RECORD TABLE

CREATE TABLE Medical_Record (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Diagnosis VARCHAR(255),
    Treatment VARCHAR(255),
    Record_Date DATE NOT NULL,
    FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
);

-- 6. MEDICINE TABLE

CREATE TABLE Medicine (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(100),
    Manufacturer VARCHAR(100),
    Quantity INT CHECK (Quantity >= 0),
    Unit_Price DECIMAL(10,2) CHECK (Unit_Price >= 0)
);

-- 7. PRESCRIPTION TABLE

CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Medicine_ID INT NOT NULL,
    Dosage VARCHAR(100),
    Duration VARCHAR(50),
    FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Medicine_ID)
        REFERENCES Medicine(Medicine_ID)
);

-- 8. BILLING TABLE

CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Bill_Date DATE NOT NULL,
    Consultation_Fee DECIMAL(10,2) DEFAULT 0,
    Medicine_Fee DECIMAL(10,2) DEFAULT 0,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
);

-- 9. ROOM TABLE

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Number VARCHAR(20) NOT NULL UNIQUE,
    Room_Type VARCHAR(50),
    Department_ID INT,
    Room_Charge DECIMAL(10,2),
    Status VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);

-- 10. STAFF TABLE

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Staff_Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);

-- INSERT SAMPLE DATA

INSERT INTO Department VALUES
(1,'Cardiology','Block A','9876543210','Dr. Ravi','Heart related treatment'),
(2,'Neurology','Block B','9876543211','Dr. Kumar','Brain and nervous system'),
(3,'Orthopedics','Block C','9876543212','Dr. Priya','Bone and joint treatment'),
(4,'General Medicine','Block D','9876543213','Dr. Anil','General treatment');


INSERT INTO Patient VALUES
(101,'Rahul','2002-05-15','Male','9000000001','Kakinada'),
(102,'Sneha','2003-08-20','Female','9000000002','Rajahmundry'),
(103,'Arjun','2001-11-10','Male','9000000003','Amalapuram'),
(104,'Divya','2004-02-25','Female','9000000004','Vizag'),
(105,'Kiran','2000-06-18','Male','9000000005','Vijayawada');


INSERT INTO Doctor VALUES
(201,'Dr. Ravi','Cardiologist','9100000001','ravi@gmail.com',1),
(202,'Dr. Kumar','Neurologist','9100000002','kumar@gmail.com',2),
(203,'Dr. Priya','Orthopedic','9100000003','priya@gmail.com',3),
(204,'Dr. Anil','General Physician','9100000004','anil@gmail.com',4);


INSERT INTO Appointment VALUES
(301,101,201,'2026-09-15','10:00:00','Scheduled'),
(302,102,202,'2026-09-15','11:00:00','Scheduled'),
(303,103,203,'2026-09-16','10:30:00','Completed'),
(304,104,204,'2026-09-17','12:00:00','Scheduled'),
(305,105,201,'2026-09-18','09:30:00','Cancelled');


INSERT INTO Medical_Record VALUES
(401,101,201,'Chest Pain','ECG and Medication','2026-09-10'),
(402,102,202,'Headache','Medication and Rest','2026-09-11'),
(403,103,203,'Fracture','Plaster Treatment','2026-09-12'),
(404,104,204,'Fever','Medicines','2026-09-13');


INSERT INTO Medicine VALUES
(501,'Paracetamol','Tablet','ABC Pharma',100,5.00),
(502,'Amoxicillin','Capsule','XYZ Pharma',80,10.00),
(503,'Aspirin','Tablet','ABC Pharma',60,8.00),
(504,'Ibuprofen','Tablet','PQR Pharma',75,12.00);


INSERT INTO Prescription VALUES
(601,101,201,503,'1 tablet daily','5 days'),
(602,102,202,501,'1 tablet twice daily','3 days'),
(603,103,203,504,'1 tablet daily','7 days'),
(604,104,204,502,'1 capsule twice daily','5 days');


INSERT INTO Billing VALUES
(701,101,'2026-09-10',500,40,540),
(702,102,'2026-09-11',400,30,430),
(703,103,'2026-09-12',600,84,684),
(704,104,'2026-09-13',300,50,350);


INSERT INTO Room VALUES
(801,'A101','General',1,1000,'Occupied'),
(802,'B201','ICU',2,3000,'Available'),
(803,'C301','General',3,1200,'Occupied'),
(804,'D401','Private',4,2000,'Available');


INSERT INTO Staff VALUES
(901,'Ramesh','Nurse','9200000001','ramesh@gmail.com',1),
(902,'Sita','Receptionist','9200000002','sita@gmail.com',2),
(903,'Mohan','Nurse','9200000003','mohan@gmail.com',3),
(904,'Lakshmi','Pharmacist','9200000004','lakshmi@gmail.com',4);

-- BASIC SELECT QUERIES

SELECT * FROM Patient;

SELECT * FROM Doctor;

SELECT * FROM Department;

SELECT * FROM Appointment;

SELECT * FROM Medical_Record;

SELECT * FROM Medicine;

SELECT * FROM Prescription;

SELECT * FROM Billing;

SELECT * FROM Room;

SELECT * FROM Staff;

-- WHERE CLAUSE

SELECT *
FROM Patient
WHERE Gender = 'Female';


SELECT *
FROM Medicine
WHERE Unit_Price > 8;


SELECT *
FROM Doctor
WHERE Specialization = 'Cardiologist';

-- ORDER BY

SELECT *
FROM Patient
ORDER BY Patient_Name ASC;


SELECT *
FROM Medicine
ORDER BY Unit_Price DESC;

-- DISTINCT

SELECT DISTINCT Specialization
FROM Doctor;


SELECT DISTINCT Room_Type
FROM Room;

-- LIKE OPERATOR

SELECT *
FROM Patient
WHERE Patient_Name LIKE 'A%';


SELECT *
FROM Doctor
WHERE Doctor_Name LIKE 'Dr.%';

-- BETWEEN OPERATOR

SELECT *
FROM Medicine
WHERE Unit_Price BETWEEN 5 AND 10;

-- IN OPERATOR

SELECT *
FROM Patient
WHERE Gender IN ('Male','Female');

-- AGGREGATE FUNCTIONS

SELECT COUNT(*) AS Total_Patients
FROM Patient;


SELECT COUNT(*) AS Total_Doctors
FROM Doctor;


SELECT AVG(Unit_Price) AS Average_Medicine_Price
FROM Medicine;


SELECT MAX(Unit_Price) AS Maximum_Price
FROM Medicine;


SELECT MIN(Unit_Price) AS Minimum_Price
FROM Medicine;


SELECT SUM(Total_Amount) AS Total_Hospital_Collection
FROM Billing;

-- GROUP BY


SELECT Gender, COUNT(*) AS Number_Of_Patients
FROM Patient
GROUP BY Gender;


SELECT Status, COUNT(*) AS Number_Of_Appointments
FROM Appointment
GROUP BY Status;

-- HAVING

SELECT Status, COUNT(*) AS Total
FROM Appointment
GROUP BY Status
HAVING COUNT(*) > 1;

-- INNER JOIN

SELECT
    d.Doctor_ID,
    d.Doctor_Name,
    d.Specialization,
    dp.Department_Name
FROM Doctor d
INNER JOIN Department dp
ON d.Department_ID = dp.Department_ID;

-- PATIENT + APPOINTMENT + DOCTOR

SELECT
    p.Patient_Name,
    d.Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Status
FROM Appointment a
INNER JOIN Patient p
ON a.Patient_ID = p.Patient_ID
INNER JOIN Doctor d
ON a.Doctor_ID = d.Doctor_ID;

-- PATIENT + MEDICAL RECORD + DOCTOR

SELECT
    p.Patient_Name,
    d.Doctor_Name,
    m.Diagnosis,
    m.Treatment,
    m.Record_Date
FROM Medical_Record m
JOIN Patient p
ON m.Patient_ID = p.Patient_ID
JOIN Doctor d
ON m.Doctor_ID = d.Doctor_ID;

-- PATIENT + PRESCRIPTION + MEDICINE

SELECT
    p.Patient_Name,
    d.Doctor_Name,
    me.Medicine_Name,
    pr.Dosage,
    pr.Duration
FROM Prescription pr
JOIN Patient p
ON pr.Patient_ID = p.Patient_ID
JOIN Doctor d
ON pr.Doctor_ID = d.Doctor_ID
JOIN Medicine me
ON pr.Medicine_ID = me.Medicine_ID;

-- LEFT JOIN

SELECT
    p.Patient_ID,
    p.Patient_Name,
    a.Appointment_ID,
    a.Appointment_Date
FROM Patient p
LEFT JOIN Appointment a
ON p.Patient_ID = a.Patient_ID;

-- RIGHT JOIN

SELECT
    d.Doctor_Name,
    a.Appointment_ID,
    a.Appointment_Date
FROM Appointment a
RIGHT JOIN Doctor d
ON a.Doctor_ID = d.Doctor_ID;

-- MULTIPLE TABLE JOIN

SELECT
    p.Patient_Name,
    d.Doctor_Name,
    dp.Department_Name,
    a.Appointment_Date,
    a.Status
FROM Patient p
JOIN Appointment a
ON p.Patient_ID = a.Patient_ID
JOIN Doctor d
ON a.Doctor_ID = d.Doctor_ID
JOIN Department dp
ON d.Department_ID = dp.Department_ID;

-- SUBQUERY

SELECT *
FROM Medicine
WHERE Unit_Price >
(
    SELECT AVG(Unit_Price)
    FROM Medicine
);

-- SUBQUERY: PATIENTS WHO HAVE APPOINTMENTS

SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN
(
    SELECT Patient_ID
    FROM Appointment
);

-- EXISTS

SELECT p.Patient_Name
FROM Patient p
WHERE EXISTS
(
    SELECT 1
    FROM Appointment a
    WHERE a.Patient_ID = p.Patient_ID
);

-- UNION

SELECT Patient_Name AS Name
FROM Patient
UNION
SELECT Staff_Name AS Name
FROM Staff;

-- UPDATE

UPDATE Patient
SET Address = 'Hyderabad'
WHERE Patient_ID = 101;


UPDATE Medicine
SET Unit_Price = 6.00
WHERE Medicine_ID = 501;

-- DELETE

DELETE FROM Appointment
WHERE Appointment_ID = 305;

-- ALTER TABLE

ALTER TABLE Patient
ADD Email VARCHAR(100);


ALTER TABLE Patient
MODIFY Phone VARCHAR(20);

-- VIEW

CREATE VIEW Patient_Appointment_View AS
SELECT
    p.Patient_ID,
    p.Patient_Name,
    d.Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Status
FROM Patient p
JOIN Appointment a
ON p.Patient_ID = a.Patient_ID
JOIN Doctor d
ON a.Doctor_ID = d.Doctor_ID;


SELECT *
FROM Patient_Appointment_View;

-- INDEX

CREATE INDEX idx_patient_name
ON Patient(Patient_Name);


CREATE INDEX idx_medicine_name
ON Medicine(Medicine_Name);

-- TRANSACTION

START TRANSACTION;

UPDATE Medicine
SET Quantity = Quantity - 5
WHERE Medicine_ID = 501;

SAVEPOINT medicine_update;

UPDATE Medicine
SET Quantity = Quantity - 10
WHERE Medicine_ID = 502;

ROLLBACK TO medicine_update;

COMMIT;
-- 1NF, 2NF AND 3NF

-- UNNORMALIZED TABLE

CREATE TABLE Patient_Hospital_UNF (
    Patient_ID INT,
    Patient_Name VARCHAR(100),
    Doctor_ID INT,
    Doctor_Name VARCHAR(100),
    Department_ID INT,
    Department_Name VARCHAR(100),
    Medicine_ID INT,
    Medicine_Name VARCHAR(100),
    Dosage VARCHAR(100)
);


-- 1NF:
-- Each field contains atomic values.
-- Repeating groups are removed.


CREATE TABLE Patient_1NF (
    Patient_ID INT,
    Patient_Name VARCHAR(100),
    Doctor_ID INT,
    Doctor_Name VARCHAR(100),
    Department_ID INT,
    Department_Name VARCHAR(100),
    Medicine_ID INT,
    Medicine_Name VARCHAR(100),
    Dosage VARCHAR(100),
    PRIMARY KEY (Patient_ID, Medicine_ID)
);


-- 2NF:
-- Remove partial dependencies.


CREATE TABLE Patient_2NF (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100)
);


CREATE TABLE Medicine_2NF (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(100)
);


CREATE TABLE Prescription_2NF (
    Patient_ID INT,
    Medicine_ID INT,
    Dosage VARCHAR(100),
    PRIMARY KEY (Patient_ID, Medicine_ID),
    FOREIGN KEY (Patient_ID)
        REFERENCES Patient_2NF(Patient_ID),
    FOREIGN KEY (Medicine_ID)
        REFERENCES Medicine_2NF(Medicine_ID)
);


-- 3NF:
-- Remove transitive dependencies.


CREATE TABLE Department_3NF (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100)
);


CREATE TABLE Doctor_3NF (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department_3NF(Department_ID)
);


CREATE TABLE Patient_3NF (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Doctor_ID INT,
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor_3NF(Doctor_ID)
);

-- FINAL DATABASE DISPLAY

SHOW TABLES;

-- END OF HOSPITAL MANAGEMENT SYSTEM