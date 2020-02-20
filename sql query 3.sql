#What is the employee id of the highest-paid employee?
select emp_id,
salary
from salaries
where salary in(select max(salary)
from salaries);
#What is the name of the youngest employee?
select first_name,
last_name
from employees 
where birth_date in(select max(birth_date)
from employees);
#What is the name of the first hired employee? 
select first_name,
last_name
from employees 
where emp_id in(select min(emp_id)
from employees);
#What percentage of employees are Female?
select gender,
count(*)*100.0/(select count(*) from employees) as percentage
from employees
where gender='F';
#Show the employee count by department name wise, sorted alphabetically on department name.
select departments.dept_name,
count(dept_emp.emp_id)
from dept_emp
inner join departments on dept_emp.dept_no=departments.dept_no
group by dept_name
order by (dept_name) asc;
#Count the number of employees by each calendar year ( take the value of year from from_date)
select year(from_date),
count(emp_id)
from dept_emp
group by (year(from_date)) 
order by (year(from_date)) desc;
#Count the number of employees by each calendar year (take the value of year from from_date) ordered by the calendar year excluding all years before 1990.
select year(dept_emp.from_date),
employees.gender,count(employees.emp_id)
from dept_emp
inner join employees on employees.emp_id=dept_emp.emp_id
where year(from_date)>=1990
group by  year(from_date),gender
order by  year(from_date);
#What is the number of managers hired each calendar year? The table should look like below?
select year(from_date) as calender_year,count(emp_id) as manager
from dept_manager
group by year(from_date)
order by year(from_date);
#What will be the department-wise break up of managers?
select year(dept_manager.from_date) as calender_year,count(dept_manager.emp_id) as manager,
departments.dept_name
from dept_manager
inner join departments on departments.dept_no=dept_manager.dept_no
group by dept_name,from_date
order by year(from_date);
#What is the number of male managers and female managers hired each calendar year from the year 1990 onwards?
select year(dept_manager.from_date) as calender_year,
employees.gender,
count(dept_manager.emp_id) as manager
from dept_manager
inner join employees on employees.emp_id=dept_manager.emp_id
where year(from_date)>=1990
group by year(from_date),gender
order by year(from_date);