------------------------------------------------BASIC QUERY-----------------------------------------------------------

--1 CREATE--
CREATE TABLE DOCTORDETAILS (
	DOCTORID CHAR(9) PRIMARY KEY UNIQUE NOT NULL,
	DOCTOR_NAME VARCHAR(50) NOT NULL,
	GENDER CHAR(1) NOT NULL,
	SPECIALIZATION VARCHAR(100) NOT NULL,
	PHONE_NO VARCHAR(15)
);

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

--2 SELECT--
SELECT * FROM PUBLIC.PATIENTDETAILS
SELECT * FROM PUBLIC.DOCTORDETAILS
SELECT * FROM PUBLIC.TREATMENTDETAILS

SELECT patient_name, age FROM patientDetails WHERE age > 50;

SELECT doctor_name FROM doctorDetails WHERE gender = 'M' AND specialization = 'Cardiology';

--3 INSERT--
INSERT INTO patientDetails (patientID, patient_name, age, gender, doctorID, diagnosed_with, admit_date, phone_no)
VALUES ('P021', 'Suresh Kumar', 60, 'M', 'D001', 'Hypertension', '2023-11-15', '9876543210');

INSERT INTO doctorDetails (doctorID, doctor_name, gender, specialization, phone_no)
VALUES ('D007', 'Dr. Kavita Singh', 'F', 'Endocrinology', '9123456780');

--4 ALTER--
ALTER TABLE patientDetails ADD COLUMN emergency_contact VARCHAR(15);

ALTER TABLE doctorDetails ALTER COLUMN phone_no TYPE VARCHAR(20);

--5 DELETE--
DELETE FROM patientDetails WHERE patientID = 'P021';

--6 DROP--

DROP TABLE treatmentDetails;

DROP DATABASE Patient;

--6 UPDATE--
UPDATE patientDetails SET phone_no = '5555555555' WHERE patientID = 'P001';

--7 AND/OR--
SELECT * FROM patientDetails WHERE age > 30 AND diagnosed_with = 'Diabetes';

SELECT doctor_name FROM doctorDetails WHERE specialization = 'Pediatrics' OR specialization = 'Dermatology';

SELECT * FROM patientDetails 
WHERE (diagnosed_with = 'Hypertension' OR age > 60) 
AND admit_date >= CURRENT_DATE - INTERVAL '1 month';

--8 WHERE--
SELECT * FROM patientDetails WHERE diagnosed_with = 'Hypertension';

SELECT * FROM treatmentDetails WHERE bill_amt > 2000;

--9 ORDER BY--
SELECT patient_name, age, diagnosed_with FROM patientDetails ORDER BY patient_name ASC;

SELECT patientID, treatment_date, bill_amt FROM treatmentDetails ORDER BY treatment_date DESC;

--10 LIMIT--
SELECT * FROM patientDetails LIMIT 10;

SELECT treatmentID, patientID, bill_amt FROM treatmentDetails ORDER BY bill_amt DESC LIMIT 5;


------------------------------------------------------------JOINS--------------------------------------------------------------------------------------

SELECT p.patient_name, t.treatment_date, d.doctor_name, t.bill_amt FROM patientDetails p 
INNER JOIN treatmentDetails t ON p.patientID = t.patientID 
INNER JOIN doctorDetails d ON t.doctorID = d.doctorID;

SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
LEFT JOIN treatmentDetails t ON p.patientID = t.patientID;

SELECT t.treatment_date, t.bill_amt, p.patient_name FROM treatmentDetails t 
RIGHT JOIN patientDetails p ON t.patientID = p.patientID;

SELECT p.patient_name, t.treatment_date, t.bill_amt FROM patientDetails p 
FULL OUTER JOIN treatmentDetails t ON p.patientID = t.patientID;