-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

-----> SELECT DISTINCT p.Name FROM Physician p JOIN Trained_In t ON p.EmployeeID = t.Physician JOIN Procedures pr ON t.Treatment = pr.Code
WHERE pr.Code NOT IN (SELECT t2.Treatment FROM Trained_In t2 WHERE t2.Physician = p.EmployeeID);


-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.

-----> SELECT p.Name AS PhysicianName, pr.Name AS ProcedureName, u.DateUndergoes AS ProcedureDate, pa.Name AS PatientName
FROM Physician p JOIN Undergoes u ON p.EmployeeID = u.Physician JOIN Procedures pr ON u.Procedures = pr.Code JOIN Patient pa ON u.Patient = pa.SSN
WHERE pr.Code NOT IN (SELECT t2.Treatment FROM Trained_In t2 WHERE t2.Physician = p.EmployeeID);


-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).

-----> SELECT DISTINCT p.Name FROM Physician p
JOIN Trained_In t ON p.EmployeeID = t.Physician JOIN Procedures pr ON t.Treatment = pr.Code JOIN Undergoes u ON p.EmployeeID = u.Physician AND pr.Code = u.Procedures
WHERE u.DateUndergoes > t.CertificationExpires;


-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.

-----> SELECT p.Name AS PhysicianName, pr.Name AS ProcedureName, u.DateUndergoes AS ProcedureDate, pa.Name AS PatientName, t.CertificationExpires AS CertificationExpirationDate
FROM Physician p JOIN Trained_In t ON p.EmployeeID = t.Physician JOIN Procedures pr ON t.Treatment = pr.Code JOIN Undergoes u ON p.EmployeeID = u.Physician AND pr.Code = u.Procedures
JOIN Patient pa ON u.Patient = pa.SSN WHERE u.DateUndergoes > t.CertificationExpires;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

-----> select pat.name as patientname, phy.name as physicianname, n.name as nursename, a.start, a.end, a.examinationroom, pcp.name as primarycarephysician
from appointment a join patient pat on a.patient = pat.ssn join physician phy on a.physician = phy.employeeid left join nurse n on a.prepnurse = n.employeeid
join physician pcp on pat.pcp = pcp.employeeid where a.physician != pat.pcp;


-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

-----> SELECT * FROM Undergoes u LEFT JOIN Stay s ON u.Stay = s.StayID WHERE u.Patient <> s.Patient;


-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.

-----> SELECT DISTINCT n.Name FROM Nurse n JOIN On_Call oc ON n.EmployeeID = oc.Nurse WHERE oc.BlockFloor = 1 AND oc.BlockCode = 2;



-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.

-----> SELECT ExaminationRoom, COUNT(*) AS NumAppointments FROM Appointment GROUP BY ExaminationRoom;


-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.


-----> 
