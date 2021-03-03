/*��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������*/
select name
from users join orders 
on  (orders.user_id = users.id)
group by users.name
having count(orders.id)>0;

/*�������� ������ ������� products � �������� catalogs, ������� ������������� ������
 */
select products.name, catalogs.name
from products join catalogs
on products.catalog_id = catalogs.id
group by products.name;
/*����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
���� from, to � label �������� ���������� �������� �������, ���� name � �������.
�������� ������ ������ flights � �������� ���������� �������.*/
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
	('moscow','������'),
	('irkutsk','�������'),
	('novgorod','��������'),
	('kazan','������'),
	('omsk','����');


select
	(select name from cities where label = from_city) as from_city,
	(select name from cities where label = to_city) as to_city
from
	flights;



