/* 1.Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
идентификатор первичного ключа и содержимое поля name.*/
use SHOP;
drop table if exists logs;
create table logs(
	created_at datetime not null,
	table_name varchar(50) not null,
	str_id int not null,
	name varchar(50)		
)  engine  = ARCHIVE;

drop trigger if exists user_log_trigger;

delimiter //
create trigger user_log_trigger after insert on users
for each row
begin 
	insert into logs (created_at,table_name,str_id,name)
	values(now(),'users',new.id,new.name);
end//
delimiter ;



drop trigger if exists catalogs_log_trigger;

delimiter //
create trigger catalogs_log_trigger after insert on catalogs
for each row
begin 
	insert into logs (created_at,table_name,str_id,name)
	values(now(),'catalogs',new.id,new.name);
end//
delimiter ;


drop trigger if exists products_log_trigger;

delimiter //
create trigger products_log_trigger after insert on products 
for each row
begin 
	insert into logs (created_at,table_name,str_id,name)
	values(now(),'products ',new.id,new.name);
end//
delimiter ;

