
Use capstone;

SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM jobs;

-- 1 - How many employees are in each department, and which department has the highest headcount?
SELECT * FROM employees;
SELECT count(employee_id) AS employee_count 
FROM employees group by department_id ORDER by employee_count DESC;

-- 2 - What is the average salary per department, and which department has the highest and lowest average salaries?
WITH dept_avg_salary AS (
    SELECT department_id, ROUND(AVG(salary), 0) AS avg_salary
    FROM employees
    GROUP BY department_id)
SELECT * FROM dept_avg_salary
WHERE avg_salary = (SELECT MAX(avg_salary) FROM dept_avg_salary)
   OR avg_salary = (SELECT MIN(avg_salary) FROM dept_avg_salary);

 -- 3  - Classify employees into three salary bands using CASE
 SELECT
    CASE
        WHEN salary < 5000 THEN 'Low'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        WHEN salary > 10000 THEN 'High'
        ELSE 'No Category'
    END AS salary_band,
    COUNT(employee_id) AS employee_count
FROM employees
GROUP BY
    CASE
        WHEN salary < 5000 THEN 'Low'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        WHEN salary > 10000 THEN 'High'
        ELSE 'No Category'
    END;
    
    -- 4 - List all countries in which Orion Data Systems operates. For each country, show the number of departments located there
 SELECT * FROM countries;
 SELECT * FROM departments;
 SELECT * FROM employees;

  SELECT c.country_name, COUNT(DISTINCT e.department_id) AS dept_count
 FROM countries AS c
 INNER JOIN employees AS e
 ON c.country_id = e.country_id
GROUP BY c.country_name;

-- 5 - Find all employees whose salaries are greater than the company-wide average salary.
SELECT emp_name, salary FROM employees
WHERE salary > (SELECT ROUND(AVG(salary),0) AS avg_salary FROM employees);

-- 6 - For each job title, calculate the average salary. Then, identify job titles where the average salary is above 12,000
SELECT job_title, ROUND((min_salary + max_salary) /2,0) AS avg_salary FROM jobs
HAVING avg_salary > 12000;
 
 -- 7 - Calculate the total salaries paid to employees in each country. List the country name alongside the total salary cost, ordered from highest to lowest.
 SELECT c.country_name, SUM(e.salary) AS total_salary
 FROM employees AS e
 JOIN countries AS c
 ON c.country_id = e.country_id
 GROUP BY c.country_name
 ORDER BY total_salary DESC;
 
 -- 8 - Identify all job roles in the company (jobs table) that currently have no employees assigned.
 SELECT j.job_title FROM jobs as j
 JOIN employees as e
 ON j.job_id = e.job_id
 WHERE e.employee_id IS NULL;
 