/*Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/
select name
from users join orders 
on  (orders.user_id = users.id)
group by users.name
having count(orders.id)>0;

/*Выведите список товаров products и разделов catalogs, который соответствует товару.
 */
select products.name, catalogs.name
from products join catalogs
on products.catalog_id = catalogs.id
group by products.name;
/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.*/
use study_db;
drop table if exists flights;
create table flights(
	id SERIAL PRIMARY KEY,
	from_city varchar(50),
	to_city varchar(50)
);
drop table if exists cities;
create table cities(
	label varchar(50),
	name varchar(50)
);

insert into flights (from_city,to_city) values 
	('moscow','omsk'),
	('novgorod','kazan'),
	('irkutsk','moscow'),
	('omsk','irkutsk'),
	('moscow','kazan');

insert into cities (label,name) values
	('moscow','Ìîñêâà'),
	('irkutsk','Èðêóòñê'),
	('novgorod','Íîâãîðîä'),
	('kazan','Êàçàíü'),
	('omsk','Îìñê');


select
	(select name from cities where label = from_city) as from_city,
	(select name from cities where label = to_city) as to_city
from
	flights;



