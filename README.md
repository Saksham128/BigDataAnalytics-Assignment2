# BigDataAnalytics-Assignment2

Using *Hospital database* which contains the following 3 tables:

1. doctorDetails

- *Attributes:* doctor_id, doctor_name, gender, specialization, phone_no

2. patientDetails

- *Attributes:* patient_id, patient_name, age, gender, doctor_id, diagnosed_with, room_ward_no,  admit_date, discharge_date, health_card, address, phone_no

3. treatmentDetails

- *Attributes:* treatment_id, patient_id, doctor_id, treatment_date, medication, treatment_notes, bill_amt

## Basic SQL Queries

### 1. CREATE
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
<img title="a title" alt="Alt text" src="/outputPhotos/">

### 2. SELECT
- Retrieve all details of each table:
```
SELECT * FROM PATIENTDETAILS
SELECT * FROM DOCTORDETAILS
SELECT * FROM TREATMENTDETAILS
```
<img title="Patient Table" alt="Patient Table" src="/outputPhotos/select1.1.png">
<img title="Doctor Table" alt="Doctor Table" src="/outputPhotos/select1.2.png">
<img title="Treatment Table" alt="Treatment Table" src="/outputPhotos/select1.3.png">

- Get names and ages of all patients who are older than 50:
```
SELECT patient_name, age FROM patientDetails WHERE age > 50;
```
<img title="a title" alt="Alt text" src="/outputPhotos/select2.png">

- List all male doctors specializing in Cardiology:
```
SELECT doctor_name FROM doctorDetails WHERE gender = 'M' AND specialization = 'Cardiology';
```
<img title="a title" alt="Alt text" src="/outputPhotos/select3.png">

### 3. INSERT

- Insert a new patient record:
```
INSERT INTO patientDetails (patientID, patient_name, age, gender, doctorID, diagnosed_with, admit_date, phone_no)
VALUES ('P021', 'Suresh Kumar', 60, 'M', 'D001', 'Hypertension', '2023-11-15', '9876543210');
```
<img title="a title" alt="Alt text" src="/outputPhotos">

- Add a new doctor record:
```
INSERT INTO doctorDetails (doctorID, doctor_name, gender, specialization, phone_no)
VALUES ('D007', 'Dr. Kavita Singh', 'F', 'Endocrinology', '9123456780');
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 4. ALTER

- 
```
ALTER TABLE patientDetails ADD COLUMN emergency_contact VARCHAR(15);
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
ALTER TABLE doctorDetails ALTER COLUMN phone_no TYPE VARCHAR(20);
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 5. DELETE

- Remove a patient record by patient ID:
```
DELETE FROM patientDetails WHERE patientID = 'P021';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 6. UPDATE

- Update phone number for a specific patient:
```
UPDATE patientDetails SET phone_no = '5555555555' WHERE patientID = 'P001';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 7. AND/OR
```
SELECT * FROM patientDetails WHERE age > 30 AND diagnosed_with = 'Diabetes';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
SELECT doctor_name FROM doctorDetails WHERE specialization = 'Pediatrics' OR specialization = 'Dermatology';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
SELECT * FROM patientDetails 
WHERE (diagnosed_with = 'Hypertension' OR age > 60) 
AND admit_date >= CURRENT_DATE - INTERVAL '1 month';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 8. WHERE
```
SELECT patient_name, age FROM patientDetails WHERE age > 50;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
SELECT doctor_name FROM doctorDetails WHERE gender = 'M' AND specialization = 'Cardiology';
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 9. ORDER BY
```
SELECT patient_name, age, diagnosed_with FROM patientDetails ORDER BY patient_name ASC;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
SELECT patientID, treatment_date, bill_amt FROM treatmentDetails ORDER BY treatment_date DESC;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 10. LIMIT
```
SELECT * FROM patientDetails LIMIT 10;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

```
SELECT treatmentID, patientID, bill_amt FROM treatmentDetails ORDER BY bill_amt DESC LIMIT 5;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

## SQL Joins

### 1. (INNER) JOIN
```
SELECT p.patient_name, t.treatment_date, d.doctor_name, t.bill_amt FROM patientDetails p 
INNER JOIN treatmentDetails t ON p.patientID = t.patientID 
INNER JOIN doctorDetails d ON t.doctorID = d.doctorID;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 2. LEFT (OUTER) JOIN
```
SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
LEFT JOIN treatmentDetails t ON p.patientID = t.patientID;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 3. RIGHT (OUTER) JOIN
```
SELECT t.treatment_date, t.bill_amt, p.patient_name FROM treatmentDetails t 
RIGHT JOIN patientDetails p ON t.patientID = p.patientID;
```
<img title="a title" alt="Alt text" src="/outputPhotos">

### 4.FULL (OUTER) JOIN
```
SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
FULL OUTER JOIN treatmentDetails t ON p.patientID = t.patientID;
```
<img title="a title" alt="Alt text" src="/outputPhotos">
