SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';


SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;
#here we do greater than AND equal to

SELECT *
FROM employee_demographics
WHERE gender != 'Female';
#do to NOT equal to, we do != 


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'Male';
#SQL does dates in year-month-day 

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'Male';
#AND means both have to be true, OR means either can be true

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male';
#here we can add OR NOT instead of OR

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;
-- PEMDAS is used for these sorts of stuff too- see how we use brackets/parenthesis above


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'JER%';
-- the like statements means a word starting like jer but then has anything after it (we add % to show anything after it)
-- always add ; at the end of a command/query or you'll get a error as it'll merge with your next command.
-- Two dashes also are good for comments, probably even better than the hashtag
-- This command would give us jerry.


SELECT *
FROM employee_demographics
WHERE first_name LIKE '%ER%';
-- If you replace J with % it means anything comes before ER and anything comes after ER


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';
-- To find names that start with a

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';
-- a with two nderscores after it means a with two characters after it. Only Ann shows up.

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%';
-- you can combined % and _ to get a and two characters after it and anything after that.
-- % means anything and _ means that many characters.


SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%';
-- works for dates too


SELECT gender
FROM employee_demographics
GROUP BY gender;
-- select and group by have to match if you're not doing aggregate function

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;
-- the avg age is an aggreg function and now select and group by don't match cos we dont have to add avg(age) to group by.

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary; 
-- you can group on multiple (occupation, salary)


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;
-- count tells you how many values when grouping by gender (so 12 values all togther but by gender 4 female and 7 male)

SELECT *
FROM employee_demographics
ORDER BY first_name;
-- automaically orders by ascending order. First name is ordered alphabetically.

SELECT *
FROM employee_demographics
ORDER BY first_name ASC;
-- can add asc for ascending but its automatic anyway.
-- To change it to descneding we have to add desc

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender, age;
-- can order by multiple stuff, here we do gender and also age. So we do age after we had ordered by gender.


SELECT *
FROM employee_demographics
ORDER BY gender, age DESC;
-- now gender is ascending and age is descending.


SELECT *
FROM employee_demographics
ORDER BY age, gender;
-- if you do age first then gender, the gender is not ordered at all. This is cos all the ages are diff values so you cant order them, if some of them were the same ages, you could order by gender.
-- so be careful about which category you put first in order by. Usually the one with less unique values like male/female.

SELECT *
FROM employee_demographics
ORDER BY 5, 4;
-- you can order by column/category positions rather than names (but better to do names cos if you remove a column, youd do all the wrong numbers). Eg, gender is 5th column and age is 4th.


SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;
-- Do HAVING after group by not before it. This will show the average age over 40 grouped by gender.


SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG (salary) > 75000; 
-- HAVING is used because it can use aggregate functions, whereas WHERE cannot.


SELECT *
FROM employee_demographics
LIMIT 3;
-- This picks first 3 rows only.

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;
-- now this chooeses top 3 oldest people cos of the order by.



SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;
-- This means we start at row 2 (its already chosen top 3 oldest cos of order by, so row 2 should be donna) and then we do 1 after it- which is leslie.
-- So i should get leslie



SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender 
HAVING avg_age > 40;
-- the AS rename the column (it renamed avg_age) and we can even write avg_age after HAVING

SELECT gender, AVG(age) avg_age
FROM employee_demographics
GROUP BY gender 
HAVING avg_age > 40;
-- AS isnt needed since its kinda implied so itd still rename like this