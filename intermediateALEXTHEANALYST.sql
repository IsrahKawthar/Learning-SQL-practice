
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;



-- Joins

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- By default JOIN is inner join but you can write it as INNER JOIN if you want. Or just leave it as JOIN. I wrote INNER JOIN.
-- We add a tab (space) and write ON. Don't have to but makes it easier to understand and read. ON means we join salary table to demographis table based ON these columns. Both columns in the demo and salary table are called employee_id that we wanna join. We dont have to add a tab before tho so its alright if you dont.
-- If we just added employee.id we'd get error since its ambiguous where we got employee.id from which table, so we specify it by writing in front of it. We added AS dem and sal to shorten the words.
-- Now if we execute we join the tables- but theres no 2, since there was no 2 in employee demographis but there was for salary, but we need same value for both for it to join.


SELECT dem.employee_id, age, occupation 
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- have to specify where we get employee.id from as its a,biguous cos its from both tables, so add dem before it (we used AS function earlier so we can use dem)


-- Outer joins have left joins and right joins.

SELECT *
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- can write left join or left outer join.
-- looks similar to the inner join example.

-- if we do right join (or right outer join) it adds nulls for values that werent matched in both table- so number 2.
SELECT *
FROM employee_demographics AS dem
RIGHT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;


-- Here's a self join. We dont have to add AS before emp1 since its implied.
-- We join two same tables together, we can rename so we can differentitate between the two identical tables.
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;
-- We added +1 above to assign each person to a different partner so they dont get themself.
-- Too many coluns so we only select the ones we wanna see.
-- pay atention to commas, undrscores and dots to avoid errors.
    


-- Joining muliple tables together

    
SELECT *
FROM parks_departments;
-- ^ this is a reference table. 
-- We want to join this department id table to the table we did earlier.

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;
-- we call it pd for short
-- we can only join ON salary cos they have a common table of department id but demogrphaics doesnt share that in common with the reference table. Sal and reference table dont have the exact same name (dept id and department id but hey have the same values).



-- Unions

SELECT age, gender
FROM employee_demographics
UNION
SELECT first_name, last_name 
FROM employee_salary;
-- This table shows age and gender and then lower down also shows first/last name
-- If we use first/last name for both demographic and salary, by default it does UNION DISTINCT so only does unique values
-- To ad all vales not just unique, we do UNION ALL- this would add first/last name even if its repeated in both salary and demo unlike UNION DISTINCT which doesnt repeat.

SELECT first_name, last_name 
FROM employee_demographics
UNION
SELECT first_name, last_name 
FROM employee_salary;
-- By default is UNION DISTINCT

SELECT first_name, last_name 
FROM employee_demographics
UNION ALL
SELECT first_name, last_name 
FROM employee_salary;
-- Union ALL does values even if theyre repeated


SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name,'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name,'Highly paid employee' AS Label
FROM employee_salary
WHERE salary > 70000 
ORDER BY first_name, last_name;



-- String functions

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;
-- Tells the length of each first name

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;
-- To start from smallest to largest name (will start with 2 letter names if any)

SELECT UPPER('sky');
-- gives the word sky in upper case
SELECT LOWER('SKY');
-- gives the word SKY in lower case

SELECT first_name, UPPER (first_name)
FROM employee_demographics;
-- Will do names in uppercase



SELECT TRIM('      sky    ');
-- will trim the white spaces 

SELECT LTRIM('      sky    ');
-- LTRIM means left trim and trims only the left hand side
SELECT RTRIM('      sky    ');
-- RTIM does the same for the right hand side


-- Substring
SELECT first_name,
LEFT(first_name, 4), 
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics; 
-- LEFT first name 4 does first 4 characters from the left of the first name and RIGHT does first 4 characters on the right of the first name
-- SUBSTRING 3,2 starts from the 3rd character and picks 2 characters from there (so it does the 3rd and 4th character- starting from 3rd character)
-- SUBSTRING is useful for stuff like birth_date as you can find everyones birth month as shown above (6th character in the full birthdate and we choose two characeters)


SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics; 
-- This will replace every lower case a with a z (so Mark and Craig's 'a' become 'z')

SELECT LOCATE('x', 'Alexander');
-- Gotta add SELECT beforehand. This locates at what character the x is in alexander. So it'll say 4.


SELECT first_name, LOCATE ('An', first_name)
FROM employee_demographics;
-- An is the first character (or rather two characters but it's counted as one since we putboth in speech marks, so first phrase?) in Ann and Andy


SELECT first_name, last_name,
CONCAT(first_name, last_name)
FROM employee_demographics;
-- CONCAT combines the two into one category

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;
-- To add a space between the names use speech marks as shown above


-- CASE statements 
SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door :("
END AS Age_bracket
FROM employee_demographics; 
-- For some reason I had to use "" marks for the last one instead of '' or else it didnt work so im not sure why
-- I used tabs for the WHENs and we can use multiple WHENs for CASE statements- dont forget to add END at the end




-- Below we're gonna do this:
-- < 50000 gets 5% salary increase
-- > 50000 gets 7% salary increase
-- Finance department also get 10% bonus 
Select first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS new_salary
FROM employee_salary;

-- can also write as (see the 5% and 7% bonus part)
Select first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS new_salary
FROM employee_salary;


-- To find finance department we check dept ID from employee_alary and then table from parks department
SELECT *
FROM employee_salary;
SELECT *
FROM parks_departments;

Select first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * 1.10
END AS Bonus
FROM employee_salary;
-- Only ben was part of finance department which is 6 on the ID table


-- Subqueries
-- A bit of a harder topic but it's like a outer and inner query as seen below. In maths terms to make it easier to understand, it's like x=3+2 and y= x^2
SELECT *
FROM employee_demographics
WHERE employee_id IN
				(SELECT employee_id
                FROM employee_salary
                WHERE dept_id = 1);
-- In the subquery (inner query) select can only have one column- so employee_id not employee_id, employee_salary.


SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;

SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;
-- So here the subquery (in brackets) is like x being solved and inputed in Y (out brackets).



SELECT gender, AVG(`MAX(age)`)
FROM 
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender;
-- Have to add back ticks `` NOT the same as '' check left of the z button on keyboard on mac. Make sure you know where to add the back ticks. In back ticks put the query you want to find.
-- Have to add group by (i think) when stuck check what the errors say to do
-- Pay a lot of attention to brckets too or will get errors.

-- same as above but i renamed so didnt have to add back ticks 
SELECT AVG(max_age)
FROM
(SELECT gender,
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table;


-- Windows function
SELECT gender, AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
-- this means average salary over everything- putting nothing in brackets for over means over everything.

SELECT gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
-- we can add PARTITION BY 

SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;
-- Using PARTION BY avg salary is differnt to using GROUP BY avg salary cos group by uses other columns but partition by is independent of them.


SELECT dem.first_name, dem.last_name,gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem. employee_id = sal.employee_id;
-- Rolling total cumitavley adds it on as it goes along- since its partioned by gender, it starts again at the next gender.


SELECT dem.first_name, dem.last_name,gender, salary,
ROW_NUMBER() OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem. employee_id = sal.employee_id;
-- This numbers the rows 

SELECT dem.employee_id, dem.first_name, dem.last_name,gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem. employee_id = sal.employee_id;
-- Numbers the rows but cos of the partition, starts again at the next gender

SELECT dem.employee_id, dem.first_name, dem.last_name,gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem. employee_id = sal.employee_id;
-- we can also do ths and order by salary

SELECT dem. employee_id,dem.first_name, dem.last_name,gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
-- As you can see the row number just counts the row numbers but rank ranks them and since number 5 is the same value for two values, it stays as 5 for both so there's no 6, then it goes straight to 7.
-- dense_rank is similar to rank but instead of skipping 6, it just continues on from 6 whereas rank skipped it and went to 7 as that was the 7th row, but dense_rank does whatever value would have been next so 6 after 5.
-- DONT FORGET COMMAS thered be an error if you didnt add the comma after rank and before dense rank lines.