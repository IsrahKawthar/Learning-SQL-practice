-- CTEs
WITH CTE_Example AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example;
-- CTEs are similar to a subquery but easier to read when it gets too complex- subqueries are usualluy used once and nested inside like a math expression but CTEs are defined at the top and can be usued multiple times.
-- Think of this: Subquery:y=10∗(3+2) CTE: Let x=3+2 Then y=10∗x 
-- CTEs are like saying "Let me name this result and use it cleanly later."




WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id;
-- Here are two CTEs joined 



WITH CTE_Example (Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example;
-- Instead on doing all the aliases like the 3rd line of the above query- you can do it like its done on the first line and that overrides the 3rd lines alias names.




-- Temp tables
-- CREATE TABLE wouldcreate a table (so a new table would be added- check schemas- parks and recreation).
-- CREATE TEMPORARY TABLE creates a temp table
CREATE TEMPORARY TABLE temp_table 
(first_name varchar (50), 
last_name varchar (50), 
favorite_movie varchar (100)
);
-- Now execute this query, the tables created even tho you cant see it. 

SELECT *
FROM temp_table;
-- Do this ^ to see it
-- Temp tables will disappear if you leave sql- theyre only temporary

INSERT INTO temp_table
VALUES('Israh','Kawthar','Star Wars');
-- DONT FORGET BOTH BRACKETSSS or will get error

SELECT *
FROM temp_table;
-- Have to do this again after the values part to actually see them.



-- Here's a diff way to make them
SELECT *
FROM employee_salary;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;
-- Gotta do this to see the table
-- Also better to give temp tables names at work cos you can use many temp tables at once so dont name them temp table but something like salary_over_50k
-- Temp tables are temporary but can be used in this session while its still here so even if i go one a new sheet or window and write "SELECT * FROM salary_over_50k;" it would work 




-- Stored Procedures
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;
-- Now you can store this

CALL large_salaries();
-- This calls it


DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;
-- Delimiter means the symbol which means end of a query. When doing two queries in one stored procedure, we change delimiter to $$. AT the end change delimiter back to ; okayyy

CALL large_salaries2();


DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;
-- Now do the refresh button under schemas. Go to stored procedures and right click large salaries 3. You can see the queries in the stored procedure. this is showing what the stored procedure looks like.
-- Now call this stored procedure.

CALL large_salaries3();

-- Now another way to create stored procedure is to right click stored procedures in schemas and go on create stored procedure and add your info 
-- Then go on apply. 

DELIMITER $$
CREATE PROCEDURE large_salaries4(param_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = param_employee_id;
END $$
DELIMITER ;
-- INT means you want it in intergers not as a date or something else

CALL large_salaries4(1);




-- Triggers and Events 
DELIMITER $$
CREATE TRIGGER employee_insert
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name,last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;
-- AFTER INSERT can also be BEFORE INSERT 
-- Now the trigger is created and we can see it under employee salary in schemas
-- Now that we created a trigger we can insert data onto the table 


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation,
salary, dept_id)
VALUES (13, 'Monkey D', 'Luffy', 'King of the Pirates',30000000, NULL);
-- Can write null for info we dont have 
-- We can write NEW and OLD for values we're adding.
-- NEW is for INSERT or UPDATE and refers to the new row being inserted/updated.
-- OLD is for DELETE or UPDATE and refes to the existing row before the change
-- Now in the employee salary and demograpics we can see luffy- see below. 
-- We can insert this data because we had ceated a trigger ^

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;



-- Events 
-- events are  automated on scheduele


DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
DELETE
FROM employee_demographics
WHERE age >= 60;
END $$
DELIMITER ;
-- Events can be scheduled and do it auotnmously

SELECT *
FROM employee_demographics;
-- Now jerry is no more
