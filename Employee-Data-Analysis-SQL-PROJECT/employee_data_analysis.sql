select gender, AVG(age), sum(age), count(age)
FROM Parks_and_Recreation.employee_demographics
group by gender;

select *
from Parks_and_Recreation.employee_salary;

select occupation, avg(salary)
from Parks_and_Recreation.employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

select *
from Parks_and_Recreation.employee_demographics
order by age desc
limit 3;

select gender, avg(age) as avg_age
from Parks_and_Recreation.employee_demographics
group by gender
having avg_age > 40;


select *
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id=sal.employee_id
;

select *
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id=sal.employee_id
inner join Parks_and_Recreation.parks_departments as dep
	on sal.dept_id = dep.department_id
;

select first_name, last_name
from Parks_and_Recreation.employee_demographics
union all
select first_name, last_name
from Parks_and_Recreation.employee_salary;

select first_name, last_name, 'old man' as label
from Parks_and_Recreation.employee_demographics
where age > 40 and gender = 'male'
union 
select first_name, last_name, 'old female' as label
from Parks_and_Recreation.employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'high paid emp' as label
from Parks_and_Recreation.employee_salary
where salary > 70000
order by first_name, last_name
;

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2;

select first_name, upper(first_name)
from employee_demographics;

select first_name, lower(first_name)
from employee_demographics;

select first_name,
left(first_name,4)
from employee_demographics;

select birth_date,
substring(birth_date, 6,2) as birth_month
from employee_demographics;

select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from employee_demographics;


select first_name, 
last_name,
age,
case
	when age <30 then 'young'
    when age between 30 and 50 then 'midage'
    when age >50 then 'old'
end as age_bracket
from employee_demographics;

select *
from employee_salary;

select first_name, 
last_name,
salary,
case 
	when salary < 50000 then salary * 1.05
    when salary >50000 then salary * 1.07
end as 'salary with bonus',
case
	when dept_id = 6 then salary * 0.1
end as 'addition salary'
from employee_salary;

select *
from employee_demographics
where employee_id in
				(select employee_id
                from employee_salary
                where dept_id=1);
select  first_name, salary,              
(select avg(salary)
from employee_salary)
from employee_salary;


select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id;
    
    
select dem.first_name, dem.last_name, gender, sum(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id;
    
    
select dem.first_name, dem.last_name, gender,salary, 
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id;
    
select dem.first_name, dem.last_name, gender,salary, 
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num
from employee_demographics as dem 
join employee_salary as sal
	on dem.employee_id=sal.employee_id;
    
with cte_example as
(select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id
group by gender
)
select avg(avg_sal)
from cte_example;



with cte_example as
( 
select employee_id, gender, birth_date
from employee_demographics 
where birth_date > '1985-01-01'
),
cte_example2 as
( select employee_id, salary
from employee_salary 
where salary > 50000
)
select *
from cte_example
join cte_example2
on cte_example.employee_id=cte_example2.employee_id;


delimiter $$
create procedure large_salaryes()
BEGIN
	select *
    from employee_salary
    where salary >= 50000;
    select * 
    from employee_salary
    where salary > 10000;
END $$
delimiter ;


delimiter $$
create event delete_retires
on ScHEDULE every 30 second
do
BEGIN
	delete
    from employee_demographics
    where age >60;
END $$
delimiter ;

