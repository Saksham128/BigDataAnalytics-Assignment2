# BigDataAnalytics-Assignment2

Using *Hospital database* which contains the following 3 tables:

1. doctorDetails

- *Stores doctor information, including unique DOCTORID, DOCTOR_NAME, GENDER, SPECIALIZATION, and optional PHONE_NO.*

2. patientDetails

- *Holds patient details such as unique PATIENTID, PATIENT_NAME, AGE, GENDER, linked DOCTORID, DIAGNOSED_WITH condition, optional ROOM_WARD_NO, admission and discharge dates, health card details, ADDRESS, and optional PHONE_NO. The DOCTORID is a foreign key that links to DOCTORDETAILS and is set to NULL if the doctor is removed.*

3. treatmentDetails

- *Contains treatment records with unique TREATMENTID, linked PATIENTID and DOCTORID, TREATMENT_DATE, MEDICATION, TREATMENT_NOTES, and BILL_AMT. PATIENTID references PATIENTDETAILS and cascades on delete, while DOCTORID references DOCTORDETAILS and is set to NULL if the doctor is removed.*

## Basic SQL Queries

### 1. CREATE
The CREATE command defines new database objects like tables and indexes. It establishes the structure, including column types and constraints.

E.g.
- Create a tables
```
CREATE TABLE DOCTORDETAILS (
	DOCTORID CHAR(9) PRIMARY KEY UNIQUE NOT NULL,
	DOCTOR_NAME VARCHAR(50) NOT NULL,
	GENDER CHAR(1) NOT NULL,
	SPECIALIZATION VARCHAR(100) NOT NULL,
	PHONE_NO VARCHAR(15)
);
```
```
CREATE TABLE PATIENTDETAILS (
	PATIENTID CHAR(9) PRIMARY KEY UNIQUE NOT NULL,
	PATIENT_NAME VARCHAR(50) NOT NULL,
	AGE INT NOT NULL,
	GENDER CHAR(1) NOT NULL,
	DOCTORID CHAR(9) NOT NULL,
	DIAGNOSED_WITH VARCHAR(100) NOT NULL,
	ROOM_WARD_NO VARCHAR(25),
	ADMIT_DATE DATE NOT NULL,
	DISCHARGE_DATE DATE,
	HEALTH_CARD VARCHAR(10),
	ADDRESS TEXT,
	PHONE_NO VARCHAR(15),
	FOREIGN KEY (DOCTORID) REFERENCES DOCTORDETAILS (DOCTORID) ON DELETE SET NULL
);
```
```
CREATE TABLE TREATMENTDETAILS (
	TREATMENTID CHAR(9) PRIMARY KEY UNIQUE NOT NULL,
	PATIENTID CHAR(9) NOT NULL,
	DOCTORID CHAR(9),
	TREATMENT_DATE DATE NOT NULL,
	MEDICATION VARCHAR(300),
	TREATMENT_NOTES VARCHAR(300),
	BILL_AMT DECIMAL(10, 2),
	FOREIGN KEY (PATIENTID) REFERENCES PATIENTDETAILS (PATIENTID) ON DELETE CASCADE,
	FOREIGN KEY (DOCTORID) REFERENCES DOCTORDETAILS (DOCTORID) ON DELETE SET NULL
);
```
<img title="CREATE" alt="OUTPUT image" src="/outputPhotos/create.png">

***

### 2. SELECT
The SELECT command retrieves data from tables based on specified conditions. It allows for filtering, sorting, and grouping results.

- Retrieve all details of each table:
```
SELECT * FROM PATIENTDETAILS
SELECT * FROM DOCTORDETAILS
SELECT * FROM TREATMENTDETAILS
```
<img title="Patient Table" alt="OUTPUT image" src="/outputPhotos/select1.1.png">
<img title="Doctor Table" alt="OUTPUT image" src="/outputPhotos/select1.2.png">
<img title="Treatment Table" alt="OUTPUT image" src="/outputPhotos/select1.3.png">

***

- Get names and ages of all patients who are older than 50:
```
SELECT patient_name, age FROM patientDetails WHERE age > 50;
```
<img title="SELECT" alt="OUTPUT image" src="/outputPhotos/select2.png">

***

- List all male doctors specializing in Cardiology:
```
SELECT doctor_name FROM doctorDetails WHERE gender = 'M' AND specialization = 'Cardiology';
```
<img title="SELECT" alt="OUTPUT image" src="/outputPhotos/select3.png">

***

### 3. INSERT
The INSERT command adds new rows to a table with specified values. It populates tables with initial or updated data entries.

- Insert a new patient record:
```
INSERT INTO patientDetails (patientID, patient_name, age, gender, doctorID, diagnosed_with, admit_date, phone_no)
VALUES ('P021', 'Suresh Kumar', 60, 'M', 'D001', 'Hypertension', '2023-11-15', '9876543210');
```
<img title="INSERT" alt="OUTPUT image" src="/outputPhotos/insert1.1.png">

***

- Add a new doctor record:
```
INSERT INTO doctorDetails (doctorID, doctor_name, gender, specialization, phone_no)
VALUES ('D007', 'Dr. Kavita Singh', 'F', 'Endocrinology', '9123456780');
```
<img title="INSERT" alt="OUTPUT image" src="/outputPhotos/insert1.2.png">

***

### 4. ALTER
The ALTER command modifies the structure of an existing table or database object. It allows adding, removing, or changing columns.

- Add a column for storing emergency contact numbers:
```
ALTER TABLE patientDetails ADD COLUMN emergency_contact VARCHAR(15);
```
<img title="ALTER" alt="OUTPUT image" src="/outputPhotos/alter1.1.png">

***

- Change the data type of the phone number to accommodate international formats:
```
ALTER TABLE doctorDetails ALTER COLUMN phone_no TYPE VARCHAR(20);
```
<img title="ALTER" alt="OUTPUT image" src="/outputPhotos/alter1.2.png">

***

### 5. DELETE
The DELETE command removes rows from a table based on given conditions. Without conditions, it deletes all rows, so use carefully.

- Remove a patient record by patient ID:
```
DELETE FROM patientDetails WHERE patientID = 'P021';
```
<img title="DELETE" alt="OUTPUT image" src="/outputPhotos/delete.png">

***

### 6. DROP
The DROP command permanently deletes an entire table, database, or object. It removes both data and structure, with no undo option.

- Delete the treatmentDetails table from your hospital database.
```
DROP TABLE treatmentDetails;
```
<img title="DROP" alt="OUTPUT image" src="/outputPhotos/drop1.1.png">

***

### 7. UPDATE
The UPDATE command modifies data in a table's rows based on conditions. It keeps information current by altering specific fields.

- Update phone number for a specific patient:
```
UPDATE patientDetails SET phone_no = '5555555555' WHERE patientID = 'P001';
```
<img title="UPDATE" alt="OUTPUT image" src="/outputPhotos/update1.1.png">

***

### 8. AND/OR
AND and OR combine conditions for more precise data filtering. AND requires all conditions true, while OR only needs one.


- Get details of patients who are older than 30 and diagnosed with 'Diabetes':
```
SELECT * FROM patientDetails WHERE age > 30 AND diagnosed_with = 'Diabetes';
```
<img title="AND" alt="OUTPUT image" src="/outputPhotos/and.png">

***

- List doctors who are either specialized in 'Pediatrics' or 'Dermatology':
```
SELECT doctor_name FROM doctorDetails WHERE specialization = 'Pediatrics' OR specialization = 'Dermatology';
```
<img title="OR" alt="OUTPUT image" src="/outputPhotos/or.png">

***

- Get patients who are either diagnosed with 'Hypertension' or older than 60, and admitted in the last month:
```
SELECT * FROM patientDetails 
WHERE (diagnosed_with = 'Hypertension' OR age > 60) 
AND admit_date >= CURRENT_DATE - INTERVAL '1 month';
```
<img title="AND/OR" alt="OUTPUT image" src="/outputPhotos/andor.png">

***

### 9. WHERE
The WHERE clause filters records in queries to meet specific conditions. It is used to refine results in SELECT, UPDATE, or DELETE commands.

- Get details of patients diagnosed with 'Hypertension':
```
SELECT * FROM patientDetails WHERE diagnosed_with = 'Hypertension';
```
<img title="WHERE" alt="OUTPUT image" src="/outputPhotos/where2.png">

***

- Select treatment records where the bill amount is greater than 2000:
```
SELECT * FROM treatmentDetails WHERE bill_amt > 2000;
```
<img title="WHERE" alt="OUTPUT image" src="/outputPhotos/where.png">

***

### 10. ORDER BY
The ORDER BY clause sorts query results by specified columns in ascending or descending order. It makes data easier to analyze and read.

- List all patients in alphabetical order by name:
```
SELECT patient_name, age, diagnosed_with FROM patientDetails ORDER BY patient_name ASC;
```
<img title="ORDER BY" alt="OUTPUT image" src="/outputPhotos/order1.1.png">

***

- Display treatments by most recent treatment date:
```
SELECT patientID, treatment_date, bill_amt FROM treatmentDetails ORDER BY treatment_date DESC;
```
<img title="ORDER BY" alt="OUTPUT image" src="/outputPhotos/order1.2.png">

***

### 11. LIMIT
The LIMIT clause restricts the number of rows returned in a query. Often used with ORDER BY, it delivers a set number of top results.

- Retrieve the first 10 patients:
```
SELECT * FROM patientDetails LIMIT 10;
```
<img title="LIMIT" alt="OUTPUT image" src="/outputPhotos/limit1.1.png">

***

- Get the top 5 most expensive treatments:
```
SELECT treatmentID, patientID, bill_amt FROM treatmentDetails ORDER BY bill_amt DESC LIMIT 5;
```
<img title="LIMIT" alt="OUTPUT image" src="/outputPhotos/limit1.2.png">

***


## SQL Joins

### 1. (INNER) JOIN
The INNER JOIN returns records that have matching values in both tables involved in the join. Only rows with matching keys in both tables are included in the result set.

```
SELECT p.patient_name, t.treatment_date, d.doctor_name, t.bill_amt FROM patientDetails p 
INNER JOIN treatmentDetails t ON p.patientID = t.patientID 
INNER JOIN doctorDetails d ON t.doctorID = d.doctorID;
```
<img title="JOIN" alt="OUTPUT image" src="/outputPhotos/inner.png">

***

### 2. LEFT (OUTER) JOIN
The LEFT OUTER JOIN returns all records from the left table and matching records from the right table. If there is no match, NULL values fill in for the right table's columns.

```
SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
LEFT JOIN treatmentDetails t ON p.patientID = t.patientID;
```
<img title="JOIN" alt="OUTPUT image" src="/outputPhotos/left.png">

***

### 3. RIGHT (OUTER) JOIN
The RIGHT OUTER JOIN returns all records from the right table and matching records from the left table. If there is no match, NULL values fill in for the left table's columns.

```
SELECT t.treatment_date, t.bill_amt, p.patient_name FROM treatmentDetails t 
RIGHT JOIN patientDetails p ON t.patientID = p.patientID;
```
<img title="JOIN" alt="OUTPUT image" src="/outputPhotos/right.png">

***

### 4.FULL (OUTER) JOIN
The FULL JOIN combines results from both left and right tables, including all matches and non-matches. Rows without a match in either table are completed with NULL values for the missing side.

```
SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
FULL OUTER JOIN treatmentDetails t ON p.patientID = t.patientID;
```
<img title="JOIN" alt="OUTPUT image" src="/outputPhotos/full.png">
