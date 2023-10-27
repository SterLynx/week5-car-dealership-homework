-- Table creation

create table if not exists sales_employees(
	employee_id SERIAL primary key,
	employee_first_name VARCHAR(25),
	employee_last_name VARCHAR(25),
	employee_email VARCHAR(50)
);

create table if not exists sales_inventory(
	vehicle_inventory_id SERIAL primary key,
	make VARCHAR(25),
	model VARCHAR(25),
	color VARCHAR(10),
	vehicle_options VARCHAR(50)
);

create table if not exists customer(
	customer_id SERIAL primary key,
	customer_first_name VARCHAR(25),
	customer_last_name VARCHAR(25),
	customer_email VARCHAR(50),
	make VARCHAR(25),
	model VARCHAR(25)
);

create table if not exists mechanics(
	mechanic_id SERIAL primary key,
	mechanic_first_name VARCHAR(25),
	mechanic_last_name VARCHAR(25),
	email VARCHAR(50)
);


-- Add customer and mechanic ID and reference as a foreign key
CREATE TABLE IF NOT EXISTS service_ticket (
    service_ticket_id SERIAL PRIMARY KEY,
    mechanic_id int,
    foreign key (mechanic_id) references mechanics(mechanic_id),
    customer_id int,
    foreign key (customer_id) references customer(customer_id),
    customer_first_name TEXT,
    customer_last_name TEXT,
    mechanic_first_name TEXT,
    mechanic_last_name TEXT,
    customer_make TEXT,
    customer_model TEXT
); 



create table if not exists sales_invoice(
	sales_invoice_id SERIAL primary key,
	employee_id int,
	foreign key (employee_id) references sales_employees(employee_id),
	customer_id int,
	foreign key (customer_id) references customer(customer_id),
	vehicle_inventory_id int,
	foreign key (vehicle_inventory_id) references sales_inventory(vehicle_inventory_id));

-- Table creation end


-- Tests and insertions start
select *
from sales_inventory;


-- Car inventory
create or replace procedure add_car_inventory(make varchar,model varchar, color varchar, vehicle_options varchar)
language plpgsql
as $add_car_inventory$
begin
	insert into sales_inventory(make, model, color, vehicle_options)
	values(make, model, color, vehicle_options);
end
$add_car_inventory$

call add_car_inventory('Ford', 'F-150', 'Red', 'Heated seats, leather interior');
call add_car_inventory('Ford', 'Fiesta', 'White', 'Premium wheels');
select *
from sales_inventory;

-- Customer info
create or replace procedure add_customer_info(customer_first_name varchar,customer_last_name varchar, customer_email varchar, make varchar, model varchar)
language plpgsql
as $add_customer_info$
begin
	insert into customer(customer_first_name,customer_last_name, customer_email, make, model)
	values(customer_first_name,customer_last_name, customer_email, make, model);
end
$add_customer_info$

call add_customer_info('Johnny', 'Silverhand', 'Jsilverhand@samurai.net', 'Porsche', '911 II');
call add_customer_info('Sterling', 'Meggs', 'sterlingm@gmail.com', 'Hyundai', 'Veloster N');

-- Add employees
create or replace procedure sales_employee_info(employee_first_name varchar, employee_last_name varchar, employee_email varchar)
language plpgsql
as $sales_employee_info$
begin
	insert into sales_employees(employee_first_name, employee_last_name, employee_email)
	values(employee_first_name, employee_last_name, employee_email);
end
$sales_employee_info$

call sales_employee_info('Jeremey', 'Clarkson', 'jclarkson@topgear.net');
call sales_employee_info('Richard', 'Hammond', 'rhammond@topgear.net');

-- Create mechanics
create or replace procedure mechanics_info(mechanic_first_name varchar, mechanic_last_name varchar, email varchar)
language plpgsql
as $mechanics_info$
begin
	insert into mechanics(mechanic_first_name, mechanic_last_name, email)
	values(mechanic_first_name, mechanic_last_name, email);
end
$mechanics_info$

call mechanics_info('The', 'Stig', 'thestig@topgear.net');
call mechanics_info('Chris', 'Fix', 'chrisfix@youtube.com');

-- Create sales invoice
insert into sales_invoice (sales_invoice_id, employee_id, customer_id, vehicle_inventory_id)
values (1,2,1,1);
insert into sales_invoice (sales_invoice_id, employee_id, customer_id, vehicle_inventory_id)
values (2,2,2,2);

-- Create service ticket
insert into service_ticket (service_ticket_id, mechanic_id, customer_id, customer_first_name, customer_last_name, mechanic_first_name, mechanic_last_name, customer_make, customer_model)
values (1,1,1,'Johnny','Silverhand','The','Stig','Porsche','911 II');

insert into service_ticket (service_ticket_id, mechanic_id, customer_id, customer_first_name, customer_last_name, mechanic_first_name, mechanic_last_name, customer_make, customer_model)
values (2,2,2,'Sterling','Meggs','Chris','Fix','Hyundai','Veloster N');
