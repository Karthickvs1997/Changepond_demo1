

-- 2.1 Select the last name of all employees.


-----> select lastname from employees;


-- 2.2 Select the last name of all employees, without duplicates.


-----> select distinct(lastname) from employees;


-- 2.3 Select all the data of employees whose last name is "Smith".


-----> select * from employees where lastname = 'Smith';


-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".


-----> select * from employees where lastname = 'Smith' or lastname = 'Doe';



-- 2.5 Select all the data of employees that work in department 14.


-----> select * from employees where Department = 14;



-- 2.6 Select all the data of employees that work in department 37 or department 77.


-----> select * from employees where Department = 37 or Department = 77;



-- 2.7 Select all the data of employees whose last name begins with an "S".


-----> select * from employees where LastName like 'S%';



-- 2.8 Select the sum of all the departments' budgets.


-----> select sum(Budget) from departments;



-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).


-----> select department, count(*) as number_of_employees from employees group by department;



-- 2.10 Select all the data of employees, including each employee's department's data.


-----> SELECT Employees.SSN, Employees.Name, Employees.LastName, Employees.Department,Departments.Name AS DepartmentName, Departments.Budget
FROM Employees JOIN Departments ON Employees.Department = Departments.Code;



-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.


-----> SELECT E.Name, E.LastName, D.Name AS DepartmentName, D.Budget
FROM Employees AS E JOIN Departments AS D ON E.Department = D.Code;



-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.


-----> SELECT E.Name, E.LastName FROM Employees AS E JOIN Departments AS D ON E.Department = D.Code WHERE D.Budget > 60000;




-- 2.13 Select the departments with a budget larger than the average budget of all the departments.


-----> SELECT * FROM Departments WHERE Budget > (SELECT AVG(Budget) FROM Departments);




-- 2.14 Select the names of departments with more than two employees.


-----> SELECT D.Name FROM Departments AS D JOIN Employees AS E ON D.Code = E.Department GROUP BY D.Code, D.Name HAVING COUNT(*) > 2;



-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.


-----> SELECT E.Name, E.LastName FROM Employees AS E JOIN Departments AS D ON E.Department = D.Code
WHERE D.Budget = (SELECT MIN(Budget) FROM Departments WHERE Budget > (SELECT MIN(Budget) FROM Departments));




-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.


-----> INSERT INTO Departments (Code, Name, Budget) VALUES (11, 'Quality Assurance', 40000);
-----> INSERT INTO Employees (SSN, Name, LastName, Department) VALUES ('847219811', 'Mary', 'Moore', 11);




-- 2.17 Reduce the budget of all departments by 10%.


-----> UPDATE Departments SET Budget = Budget * 0.90;



-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).


-----> UPDATE Employees SET Department = 14 WHERE Department = 77;



-- 2.19 Delete from the table all employees in the IT department (code 14).


-----> DELETE FROM Employees WHERE Department = 14;



-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.


-----> DELETE FROM Employees WHERE Department IN (SELECT Code FROM Departments WHERE Budget >= 60000);



-- 2.21 Delete from the table all employees.


-----> DELETE FROM Employees;
