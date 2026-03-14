# 🏥 Hospital Management System - Database Project

## 📝 Project Overview
This project is a comprehensive **Hospital Management System** developed as part of the Database course at **Al-Azhar University of Gaza, Faculty of EIT**. It integrates a robust relational database backend with a functional Java-based graphical interface.

The system is designed to handle core hospital operations, including patient registration, doctor scheduling, and medical record management, using advanced database techniques like **PL/SQL programming** and **JDBC integration**.

---

## 🏗️ Project Components

### 1. 🗄️ Database Schema (SQL)
The database consists of four primary relationally complete tables:
*   **Patients:** Stores personal details and contact information.
*   **Doctors:** Maintains records of medical staff and their specializations.
*   **Appointments:** Manages the scheduling and status of patient visits.
*   **MedicalRecords:** Tracks diagnoses, prescriptions, and visit notes.

**Key SQL Features:**
*   **🔢 Sequences:** Automated ID generation for all tables starting at 1001, 2001, 3001, and 4001.
*   **📊 Materialized View:** `DoctorAppointmentStats` provides a summary of total, completed, and cancelled appointments per doctor to optimize performance.

### 2. 🧠 Database Logic (PL/SQL)
The project implements robust backend logic to ensure data integrity and security:
*   **📥 Stored Procedures:**
    *   `Insert_To_Patients`: Adds new patient records using automated sequences.
    *   `Update_Patient_Info`: Updates patient contact details efficiently.
    *   `Delete_Patient_Record`: Safely removes specific patient entries.
*   **🔍 Functions:**
    *   `GetAllPatientData`: Uses a `SYS_REFCURSOR` to retrieve all information for a specific patient ID.
*   **⚡ Triggers:**
    *   **📝 Audit Trigger (Patient_Update_Audit):** A row-level trigger that records any changes to patient names or phone numbers into an audit table, capturing old/new values, the user, and the timestamp.
    *   **🛡️ Security Trigger (Restrict_Operations_On_Birthday):** A statement-level trigger that prevents any `INSERT`, `UPDATE`, or `DELETE` operations on the DBA's birthday.

### 3. 💻 Application Integration (Java/JDBC)
A graphical application developed in **NetBeans** to simulate real-world database interactions:
*   **🔌 DBConnection.java:** Manages the JDBC connection to the Oracle database.
*   **🖥️ PatientDAO.java:** Handles the execution of PL/SQL procedures from the Java environment to perform CRUD operations.

---

## ⚙️ How to Use
1.  **🛢️ Database Setup:** Run the SQL scripts provided in the `Pt1_SQL` folder to create tables, sequences, and views.
2.  **📜 Logic Deployment:** Run the PL/SQL scripts in the `Pt2_PLSQL` folder to compile the procedures, functions, and triggers.
3.  **🚀 Application Launch:** Open the Java project in NetBeans, ensure your Oracle JDBC driver is configured, and run the application.
