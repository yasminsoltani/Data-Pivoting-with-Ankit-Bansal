--	DATA PIVOTING: converting columns into rows

SELECT emp_id,
sum(CASE WHEN salary_component_type = 'salary' THEN val end) as salary, --sum the NULL rows with the salary
sum(CASE WHEN salary_component_type = 'bonus' THEN val end) as bonus, --sum the NULL rows with bonus
sum(CASE WHEN salary_component_type = 'hike_percent' THEN val end) as hike_percent --sum the NULL rows with hike_percent
INTO emp_compensation_pivot --inserting data into a different table
FROM emp_compensation
GROUP BY emp_id

--DATA UNPIVOTING: converting rows to columns

SELECT emp_id, 'salary' as salary_component_type,
salary as val
FROM emp_compensation_pivot
union all 
SELECT emp_id, 'bonus' as salary_component_type,
bonus as val 
FROM emp_compensation_pivot
union all
SELECT emp_id, 'hike_percent' as salary_component_type,
hike_percent as val 
FROM emp_compensation_pivot