INSERT INTO Emp(empID, first_name, last_name, middle_name, job, salary)
SELECT empID, SUBSTRING_INDEX(empName, ' ', 1), SUBSTRING_INDEX(empName, ' ', -1), IF(LENGTH(empName) - LENGTH(REPLACE(empName, ' ', '')) > 1, SUBSTRING_INDEX(SUBSTRING_INDEX(empName, ' ', 2), ' ', -1), ''), job, salary
FROM Employee;

INSERT INTO Proj(projID, title, budget, funds)
SELECT projID, title, budget, funds
FROM Project;

INSERT INTO Dept(deptID, deptName)
SELECT deptID, deptName
FROM Department;

INSERT INTO Belong(empID,deptID)
SELECT empID, deptID
FROM Employee;

INSERT INTO Assign(empID,projID,role)
SELECT empID,projID,role
FROM Assigned;

INSERT INTO Location(deptID, street_number, street_name, city_name, province, postal_code)
SELECT deptID, SUBSTRING_INDEX(location, ' ', 1), TRIM(LEADING CONCAT(SUBSTRING_INDEX(location, ' ', 1),' ') FROM SUBSTRING_INDEX(location, ',', 1)), TRIM(LEADING ' ' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ',', -1)), TRIM(LEADING ' ' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 3), ',', -1)), TRIM(LEADING ' ' FROM SUBSTRING_INDEX(location, ',', -1))
FROM Department;

DROP VIEW IF EXISTS `original_emp`;
-- show warnings;
CREATE VIEW original_emp AS(


SELECT t3.empID, empName, deptID, job, salary

FROM

(
SELECT t1.empID, empName, deptID

FROM

((SELECT empID, IF(middle_name = '', CONCAT(first_name,' ', last_name), CONCAT(first_name, ' ', middle_name, ' ', last_name)) AS empName FROM Emp) t1

INNER JOIN

(SELECT empID, deptID FROM Belong) t2

ON t1.empID = t2.empID)) t3

INNER JOIN

(SELECT empID, job, salary FROM Emp) t4

ON t3.empID = t4.empID
);

DROP VIEW IF EXISTS `original_dept`;
CREATE VIEW original_dept AS(

SELECT t1.deptID, t1.deptName, t2.Location

FROM

((SELECT deptID, deptName FROM Dept) t1

INNER JOIN

(SELECT deptID, CONCAT(street_number, ' ', street_name, ', ', city_name, ', ', province, ', ', postal_code) AS location FROM Location) t2

ON t1.deptID = t2.deptID)

);

