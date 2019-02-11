/*
https://www.hackerrank.com/domains/sql?filters%5Bstatus%5D%5B%5D=unsolved&badge_type=sql
*/

/*
Revising the Select Query I
*/

SELECT
    *
FROM
    CITY;

/*
Revising the Select Query II
Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.
*/
SELECT
    CITY.NAME
from
    CITY
WHERE
    CountryCode = 'USA'
AND
    POPULATION > 120000;

/*
Select All
Query all columns (attributes) for every row in the CITY table.
*/
SELECT
    *
FROM
    CITY
WHERE ID = 1661;

SELECT
    SUM(POPULATION)
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN'

/*
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN
*/

SELECT
    NAME  
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN';

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT
    CITY,
    STATE
FROM
    STATION;

/*
Query a list of CITY names from STATION with even ID numbers only. You may print the results in any order, but must exclude duplicates from your answer.
*/

SELECT
    DISTINCT CITY
FROM
    STATION
WHERE MOD(ID, 2)  = 0;

/*
Let  be the number of CITY entries in STATION, and let  be the number of distinct CITY names in STATION; query the value of  from STATION. In other words, find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
*/

SELECT
    COUNT(CITY) - COUNT(DISTINCT CITY)
FROM
    STATION

/*
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
*/

(SELECT
    CITY,
    LENGTH(CITY)
FROM
    STATION
WHERE LENGTH(CITY)=(SELECT MIN(LENGTH(CITY)) FROM STATION)
GROUP BY CITY
)
UNION
(SELECT 
    CITY,
    LENGTH(CITY)
FROM
    STATION
WHERE LENGTH(CITY)=(SELECT MAX(LENGTH(CITY)) FROM STATION)
GROUP BY CITY);

select 
    city,
    length_city
from 
    (select 
        a.*, 
        rownum r
    from 
        (select 
            length (city) length_city, 
            city
        from station 
        order by length_city, city) a) 
where r in (1,(select count(*) from station));

/*
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
*/

SELECT
    Name || '(' || SUBSTR( Occupation, 0, 1 ) || ')'
FROM
    OCCUPATIONS
ORDER BY Name;
SELECT
    'There are a total of ' || COUNT(Occupation) || ' ' || LOWER(Occupation) || 's.'
FROM
    OCCUPATIONS
GROUP BY Occupation
ORDER BY  COUNT(Occupation), Occupation; 

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT
   AVG(Salary) -  AVG(TO_NUMBER(REPLACE(TO_CHAR(Salary),'0')))
FROM EMPLOYEES;

/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/

SELECT
    CASE 
        WHEN A + B > C THEN 
            CASE 
                WHEN A = B AND B = C THEN 'Equilateral'
                WHEN A = B OR B = C OR A = C THEN 'Isosceles'
                WHEN A != B OR B != C OR A != C THEN 'Scalene'
            END 
        ELSE 'Not A Triangle' 
    END 
FROM TRIANGLES;

/*
We define an employee's total earnings to be their salary * months   worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.
*/

SELECT
    SUM(months * salary) as earnings,
    COUNT(employee_id)
FROM
    Employee
GROUP BY employee_id
ORDER BY SUM(months * salary) DESC;


SELECT
    ROUND(SUM(LAT_N ),2),
    ROUND(SUM(LONG_W ),2)
FROM
    STATION; 

SELECT
    ROUND(MAX(LAT_N ),4)
FROM
    STATION
WHERE LAT_N BETWEEN < 137.2345;


SELECT
    ROUND(LONG_W,4)
FROM
    STATION
WHERE LAT_N = (
SELECT
    MAX(LAT_N )
FROM
    STATION
WHERE LAT_N < 137.2345);

SELECT
    ROUND(MIN(LAT_N ),4)
FROM
    STATION
WHERE LAT_N > 38.7780;

SELECT
    ROUND(LONG_W,4)
FROM
    STATION
WHERE LAT_N = (
SELECT
    MIN(LAT_N )
FROM
    STATION
WHERE LAT_N > 38.7780);

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT
    Name
FROM
    STUDENTS
WHERE
    Marks > 75
order by SUBSTR('Name', -3, 3);

/*
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY,
    SUBSTR(CITY, 1, 1)
FROM
    STATION
WHERE UPPER(SUBSTR(CITY, 1, 1)) in ('A', 'E', 'I', 'O', 'U', 'Y');

/*
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY,
    SUBSTR(CITY, 1, 1)
FROM
    STATION
WHERE UPPER(SUBSTR(CITY, -1, 1)) in ('A', 'E', 'I', 'O', 'U', 'Y');

/*
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY
FROM
    STATION
WHERE
    UPPER(SUBSTR(CITY, -1, 1)) in ('A', 'E', 'I', 'O', 'U')
AND
    UPPER(SUBSTR(CITY, 1, 1)) in ('A', 'E', 'I', 'O', 'U');

/*
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY,
    SUBSTR(CITY, 1, 1)
FROM
    STATION
WHERE UPPER(SUBSTR(CITY, 1, 1)) NOT IN ('A', 'E', 'I', 'O', 'U');

/*
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY,
    SUBSTR(CITY, 1, 1)
FROM
    STATION
WHERE UPPER(SUBSTR(CITY, -1, 1)) NOT IN ('A', 'E', 'I', 'O', 'U');

/*
Query the list of CITY names from STATION which DO NOT have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
SELECT
    DISTINCT CITY
FROM
    STATION
WHERE
    UPPER(SUBSTR(CITY, -1, 1)) NOT IN ('A', 'E', 'I', 'O', 'U')
AND
    UPPER(SUBSTR(CITY, 1, 1)) NOT IN ('A', 'E', 'I', 'O', 'U');

/*
Query the list of CITY names from STATION which DO NOT have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/

SELECT
    COUNTRY.Continent,
    AVG(CITY.Population)
FROM
    CITY
JOIN
    COUNTRY
ON
    CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT 
    MAX(total_earnings),
    SUM(emp)
FROM
    (SELECT
        SUM(months * salary) as total_earnings,
        COUNT(employee_id) as emp
    FROM
        Employee
    GROUP BY employee_id
    ORDER BY SUM(months * salary) DESC )
WHERE total_earnings = MAX(total_earnings);

SELECT 
    MAX(months * salary) ||' '|| COUNT(*)
FROM employee 
GROUP BY salary 
HAVING MAX(months * salary) = (SELECT MAX(months * salary) from employee);
