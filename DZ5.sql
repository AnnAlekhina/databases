#1. ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. «аполните их текущими датой и временем.
alter table users add column created_at datetime
alter table users add column updated_at datetime
update users set created_at = now(),updated_at =now();
#2.“аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR и
# в них долгое врем€ помещались значени€ в формате "20.10.2017 8:10". Ќеобходимо преобразовать пол€ к типу 
# DATETIME, сохранив введеные ранее значени€
alter table users modify created_at varchar(255)
alter table users modify updated_at varchar(255)
update users set created_at = '20.10.2017 8:10' ,updated_at ='20.10.2017 8:10';
alter table users add column created_at_new datetime;
alter table users add column updated_at_new datetime;
update users set  created_at_new  = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i');
update users set updated_at_new = str_to_date(updated_at,'%d.%m.%Y %h:%i');
alter table users
drop created_at,drop updated_at;
alter table users
rename column created_at_new to created_at,
rename column updated_at_new to updated_at;
#3.¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры:
# 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. 
#Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value. 
#ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.
DROP DATABASE IF EXISTS study_db;
CREATE DATABASE study_db;
USE study_db;
create table storehouses_products (
	value int
);
insert into storehouses_products values (0),(2500),(0),(30),(500),(1);
select * from storehouses_products ORDER BY IF(value > 0, 0, 1), value;
# јгрегаци€ данных
#1.ѕодсчитайте средний возраст пользователей в таблице users
use vk;
select avg((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25) from profiles;
#2.ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели.
# —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.
select DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday, 6, 8))) as bd_this_year,
    count(*) as count_bd
from profiles
group by bd_this_year
order by count_bd;
