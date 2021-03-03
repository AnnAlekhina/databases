/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
.*/


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

/*Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
*/
use shop;
create or replace view prods (prods_name,catalog_name) as
select products.name, catalogs.name
from products 
join catalogs
on products.catalog_id = catalogs.id;

select * from prods;


/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу
"Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи"
 */
drop procedure if exists hello;
delimiter //
create procedure hello()
begin
	case 
		when CURTIME() between '06:00:00' and '12:00:00' then select  'Äîáðîå óòðî';
		when CURTIME() between '12:00:00' and '18:00:00' then select 'Äîáðûé äåíü';
		when CURTIME() between '18:00:00' and '00:00:00' then select 'Äîáðûé âå÷åð';
		else
			select 'Äîáðîé íî÷è';
	end case;
end //
delimiter ;

CALL hello();

/*В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.*/



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



