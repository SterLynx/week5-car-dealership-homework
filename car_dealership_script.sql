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
	customer_id SERIAL primary key,
	mechanic_first_name VARCHAR(25),
	mechanic_last_name VARCHAR(25),
	email VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS service_ticket (
    service_ticket_id SERIAL PRIMARY KEY,
    customer_first_name TEXT,
    customer_last_name TEXT,
    mechanic_first_name TEXT,
    mechanic_last_name TEXT,
    customer_make TEXT,
    customer_model TEXT,
    foreign key (customer_first_name) references customer(first_name),
    foreign key (customer_last_name) references customer(last_name),
    foreign key (mechanic_first_name) references mechanics(first_name),
    foreign key (mechanic_last_name) references mechanics(last_name),
    foreign key (customer_make) references customer(make),
    foreign key (customer_model) references customer(model)
); -- TODO foreign key isn't working for some
	-- reason I can't figure it out



create table if not exists sales_invoice(
	sales_invoice_id SERIAL primary key,
	foreign key (first_name) references customer(first_name),
	foreign key (last_name) references customer(last_name),
	foreign key (first_name) references sales_employees(first_name),
	
);
-- Foreign keys not working
-- Table creation end

select *
from sales_inventory;

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