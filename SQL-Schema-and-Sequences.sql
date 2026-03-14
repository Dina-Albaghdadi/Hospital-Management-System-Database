//create tables
CREATE TABLE Patients (
  2      patient_id NUMBER PRIMARY KEY,
  3      first_name VARCHAR2(50) NOT NULL,
  4      last_name VARCHAR2(50) NOT NULL,
  5      date_of_birth DATE NOT NULL,
  6      gender VARCHAR2(10) CHECK (gender IN ('Male', 'Female')),
  7      phone_number VARCHAR2(20),
  8      address VARCHAR2(200),
  9      registration_date DATE DEFAULT SYSDATE NOT NULL
 10* )
  1  CREATE TABLE Doctors (
  2      doctor_id NUMBER PRIMARY KEY,
  3      first_name VARCHAR2(50) NOT NULL,
  4      last_name VARCHAR2(50) NOT NULL,
  5      specialization VARCHAR2(100) NOT NULL,
  6      phone_number VARCHAR2(20),
  7      email VARCHAR2(100),
  8      hire_date DATE DEFAULT SYSDATE NOT NULL
  9* )

Table created.
  1  CREATE TABLE Appointments (
  2      appointment_id NUMBER PRIMARY KEY,
  3      patient_id NUMBER NOT NULL,
  4      doctor_id NUMBER NOT NULL,
  5      appointment_date TIMESTAMP NOT NULL,
  6      status VARCHAR2(20) DEFAULT 'Scheduled' CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
  7      notes VARCHAR2(500),
  8      CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  9      CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
 10* )
 1  CREATE TABLE MedicalRecords (
  2      record_id NUMBER PRIMARY KEY,
  3      patient_id NUMBER NOT NULL,
  4      doctor_id NUMBER NOT NULL,
  5      visit_date DATE DEFAULT SYSDATE NOT NULL,
  6      diagnosis VARCHAR2(200) NOT NULL,
  7      prescription VARCHAR2(500),
  8      notes VARCHAR2(1000),
  9      CONSTRAINT fk_record_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
 10      CONSTRAINT fk_record_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
 11* )
//create the view
 1  CREATE MATERIALIZED VIEW DoctorAppointmentStats
  2  REFRESH COMPLETE ON DEMAND
  3  AS
  4  SELECT 
  5      d.doctor_id,
  6      d.first_name || ' ' || d.last_name AS doctor_name,
  7      d.specialization,
  8      COUNT(a.appointment_id) AS total_appointments,
  9      SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
 10      SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_appointments
 11  FROM 
 12      Doctors d
 13  LEFT JOIN 
 14      Appointments a ON d.doctor_id = a.doctor_id
 15  GROUP BY 
 16*     d.doctor_id, d.first_name, d.last_name, d.specialization

//create sequences
SQL> CREATE SEQUENCE patient_id_seq START WITH 1001 INCREMENT BY 1;
SQL> CREATE SEQUENCE doctor_id_seq START WITH 2001 INCREMENT BY 1;
SQL> CREATE SEQUENCE appointment_id_seq START WITH 3001 INCREMENT BY 1;
SQL> CREATE SEQUENCE record_id_seq START WITH 4001 INCREMENT BY 1;
// Insert sample data using sequences 

SQL> INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender, phone_number, address)
VALUES (patient_id_seq.NEXTVAL, 'Mohammed', 'Ali', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'Male', '0599123456', 'Gaza City');

SQL> INSERT INTO Doctors (doctor_id, first_name, last_name, specialization, phone_number, email)
VALUES (doctor_id_seq.NEXTVAL, 'Ahmed', 'Khalil', 'Cardiology', '0599765432', 'ahmed.khalil@hospital.com');

SQL> INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
VALUES (appointment_id_seq.NEXTVAL, 1001, 2001, TO_TIMESTAMP('2025-07-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled');

SQL> INSERT INTO MedicalRecords (record_id, patient_id, doctor_id, diagnosis, prescription, notes)
VALUES (record_id_seq.NEXTVAL, 1001, 2001, 'Hypertension', 'Lisinopril 10mg daily', 'Patient advised to reduce salt intake and exercise regularly');

