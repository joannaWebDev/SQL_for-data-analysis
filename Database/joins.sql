CREATE TABLE employee (
    empl_id MEDIUMINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (empl_id),
    EmplFname VARCHAR(30) NOT NULL,
    EmplLname VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    Email VARCHAR(120) NOT NULL,
    phoneNo VARCHAR(30) NOT NULL,
    address VARCHAR(120)
); 
CREATE TABLE client (
    client_id MEDIUMINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (client_id),
    ClientFname VARCHAR(30) NOT NULL,
    ClientLname VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    ClientEmail VARCHAR(120) NOT NULL,
    phoneNo VARCHAR(30) NOT NULL,
    address VARCHAR(120),
    empl_id INT
); 

CREATE TABLE projects (
    project_id MEDIUMINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (project_id),
    empl_id INT,
    client_id INT,
    projectName VARCHAR(30) NOT NULL,
    projectStartDate DATE NOT NULL
); 

INSERT INTO employee (EmplFname, EmplLname, age, Email, phoneNo, address)
VALUES ('Mary', 'Sweet', 30,'mary@adn.com','9765411231','Berlin'),
('Minnie', 'Sower', 22,'min@email.com','9876543561','London'),
('Tom', 'Bitter', 47,'tom@email.com','9765411231','Barcelona'),
('Sam', 'Felix', 32,'am@email.com','9955884422','Amsterdam');


INSERT INTO client (ClientFname, ClientLname, age, Clientemail, phoneNo, address, empl_id)
VALUES ('Susan', 'Smith', 30,'susan@adn.com','9765411231','Kolkata',3),
('Mois', 'Ali', 22,'mois@email.com','9876543561','Hyderabad',1),
('John', 'Paul', 47,'john@email.com','9765411231','Berlin',2),
('Ingrid', 'Dagina', 32,'ingrid@email.com','9955884422','Delhi',4);

INSERT INTO projects (empl_id, client_id, projectName, projectStartDate)
VALUES (1, 3, 'Project1', '2021-04-01'),
(2, 1, 'Project2', '2021-04-01'),
(3, 4, 'Project3', '2021-04-01'),
(4, 5, 'Project4', '2021-04-01'),
(1, 3, 'Project5', '2021-04-01');


DROP TABLE employee;
DROP TABLE client;
DROP TABLE projects;

/*◾◾◾◾◾◾◾◾◾◾◾INNER JOIN ◾◾◾◾◾◾◾◾◾◾◾
An INNER JOIN of A and B gives the result of A intersect B. It returns all the common records between two tables. If there’s no related record, it will contain NULL.
This type of join returns those records which have matching values in both tables. So, if you perform an INNER join operation between the Employee table and the Projects table, all the rows which have matching values in both the tables will be given as output
NOTE: ❗❗❗❗❗ You can either use the keyword INNER JOIN or JOIN to perform this operation..👇  */

SELECT e.empl_id, e.EmplFname, e.EmplLname, p.project_id, p.projectName
FROM employee AS e
INNER JOIN projects AS p ON e.empl_id = p.empl_id;


/*◾◾◾◾◾◾◾◾◾◾◾FULL JOIN ◾◾◾◾◾◾◾◾◾◾◾
❗❗❗❗❗ MySQL does not support FULL JOIN, so you have to combine JOIN, UNION and LEFT JOIN to get an equivalent. It gives the results of A union B. It returns all records from both tables. Those columns which exist in only one table will contain NULL in the opposite table.
Full Join or the Full Outer Join returns all those records which either have a match in the left(Table1) or the right(Table2) table. 👇 */

SELECT employee.emplFName, employee.emplLName, projects.projectName, projectStartDate
FROM employee
LEFT JOIN projects ON employee.empl_id = projects.project_id
UNION
SELECT employee.emplFName, employee.emplLName, projects.projectName, projectStartDate 
FROM employee
RIGHT JOIN projects ON employee.empl_id = projects.project_id;

/*◾◾◾◾◾◾◾◾◾◾◾LEFT JOIN ◾◾◾◾◾◾◾◾◾◾◾
The LEFT JOIN or the LEFT OUTER JOIN  returns all the records from the left table and also those records which satisfy a condition from the right table. Also, for the records having no matching values in the right table, the output or the result-set will contain the NULL values. 
A LEFT JOIN gives all rows in A, plus any common rows in B. If a record in A doesn’t exist in B, it will return NULL for that row. 👇 */
/* ❗❗❗❗❗ USING WORKS ONLY IF THE COLUMN NAME MATCHES EXACTLY */

SELECT e.emplFName, e.emplLName, p.projectName, p.projectStartDate
FROM Employee AS e
LEFT JOIN projects AS p
USING(empl_id);


/*◾◾◾◾◾◾◾◾◾◾◾RIGHT JOIN ◾◾◾◾◾◾◾◾◾◾◾
The RIGHT JOIN or the RIGHT OUTER JOIN  returns all the records from the right table and also those records which satisfy a condition from the left table. Also, for the records having no matching values in the left table, the output or the result-set will contain the NULL values. 
A RIGHT JOIN gives all rows in table B, plus any common rows in A. If a record in B doesn’t exist in A, it will return NULL for that row. 👇  */

SELECT employee.emplFName, employee.emplLName, projects.projectName, projects.project_id
FROM employee 
RIGHT JOIN projects on employee.empl_id = projects.project_id;

/*MAX + GROUP BY + JOINS*/
SELECT employee.emplFName, MAX(employee.age)
FROM employee
LEFT JOIN projects
ON employee.empl_id = projects.empl_id
GROUP BY employee.EmplFname;


/*COUNT*/

SELECT empl_id, projects.projectName, 
COUNT(projects.projectName) AS total_projects_per_cl
FROM projects
JOIN employee USING(empl_id)
GROUP BY 1;



