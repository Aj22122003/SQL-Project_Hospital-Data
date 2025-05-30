CREATE DATABASE Hospital;

CREATE TABLE Patients(
Hospital_Name VARCHAR(100),
Location VARCHAR(50),
Department VARCHAR(50),	
Doctors_Count INT,	
Patients_Count INT,	
Admission_Date DATE,
Discharge_Date DATE,
Medical_Expenses FLOAT);

SET datestyle = 'DMY';

COPY Patients(Hospital_Name,Location,Department,Doctors_Count,
Patients_Count,Admission_Date,Discharge_Date,Medical_Expenses
)
FROM'E:\SQL\Project2\Hospital_Data.csv'
DELIMITER ',' 
CSV HEADER;

SELECT * FROM Patients;

--1 Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM(Patients_Count) AS total_patients
FROM Patients;

--2 Retrieve the average count of doctors available in each hospital.
SELECT Hospital_Name, AVG(Doctors_Count) AS Avg_Doctors
FROM Patients
GROUP BY Hospital_Name;

--3 Find the top 3 hospital departments that have the highest number of patients.
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Patients
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT 3;

--4 Identify the hospital that recorded the highest medical expenses.
SELECT Hospital_Name, SUM(Medical_Expenses) AS Total_Expenses
FROM Patients
GROUP BY Hospital_Name
ORDER BY Total_Expenses DESC
LIMIT 1;

--5 Calculate the average medical expenses per day for each hospital.
SELECT Hospital_Name,
       SUM(Medical_Expenses) / COUNT(DISTINCT Admission_Date) AS Avg_Daily_Expenses
FROM Patients
GROUP BY Hospital_Name;

--6 Find the patient with the longest stay by calculating the difference between
--Discharge Date and Admission Date.
SELECT *, 
       (Discharge_Date - Admission_Date) AS Stay_Length
FROM Patients
ORDER BY Stay_Length DESC
LIMIT 1;

--7 Count the total number of patients treated in each city.
SELECT Location AS City, SUM(Patients_Count) AS Total_Patients
FROM Patients
GROUP BY Location;

--8 Calculate the average number of days patients spend in each department.
SELECT Department,
       AVG(Discharge_Date - Admission_Date) AS Avg_Stay_Length
FROM Patients
GROUP BY Department;

--9 Find the department with the least number of patients.
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Patients
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;

--10 Group the data by month and calculate the total medical expenses for each month.
SELECT DATE_TRUNC('month', Admission_Date) AS Month, 
       SUM(Medical_Expenses) AS Total_Expenses
FROM Patients
GROUP BY Month
ORDER BY Month;


