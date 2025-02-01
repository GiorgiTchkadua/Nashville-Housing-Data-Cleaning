delimiter $$
create trigger employee_insert
	after insert on employee_salary
    for each row
BEGIN
	insert into employee_demographics ( first_name, last_name, employee_id)
    values ( new.first_name, new.last_name, new.employee_id);
END $$
delimiter ;

insert into employee_salary (first_name, last_name, employee_id, occupation, salary, dept_id)
values ('gio', 'Tchkadua', 13, 'director', '100000', null);

select*
from employee_salary
    