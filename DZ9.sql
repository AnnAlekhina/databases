/*� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
 * 
 ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.*/


drop database IF EXISTS sample;
CREATE DATABASE sample;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

select * from sample.users ;

start transaction;

insert into sample.users 
select * from shop.users where id = 1;
commit;

/*�������� �������������, ������� ������� �������� name �������� ������� �� ������� products � 
 
 ��������������� �������� �������� name �� ������� catalogs.*/
use shop;
create or replace view prods (prods_name,catalog_name) as
select products.name, catalogs.name
from products 
join catalogs
on products.catalog_id = catalogs.id;

select * from prods;


/*�������� �������� ������� hello(), ������� ����� ���������� �����������,
 *  � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����",
 *  � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����",
 *  � 00:00 �� 6:00 � "������ ����".*
 */
drop procedure if exists hello;
delimiter //
create procedure hello()
begin
	case 
		when CURTIME() between '06:00:00' and '12:00:00' then select  '������ ����';
		when CURTIME() between '12:00:00' and '18:00:00' then select '������ ����';
		when CURTIME() between '18:00:00' and '00:00:00' then select '������ �����';
		else
			select '������ ����';
	end case;
end //
delimiter ;

CALL hello();

/*� ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
 ��������� ����������� ����� ����� ��� ���� �� ���.
  ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
  ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
  ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.*/



drop trigger if exists nullTrigger;
delimiter //
create trigger nullTrigger before insert on products
for each row
begin
	if(isnull(new.name) and isnull(new.description)) then
		signal sqlstate '45000' SET MESSAGE_TEXT = 'NULL!';
	end if;
end//
delimiter ;



