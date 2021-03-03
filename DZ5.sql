#1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
alter table users add column created_at datetime
alter table users add column updated_at datetime
update users set created_at = now(),updated_at =now();
#2.������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR �
# � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� 
# DATETIME, �������� �������� ����� ��������
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
#3.� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
# 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
#���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
#������, ������� ������ ������ ���������� � �����, ����� ���� �������.
DROP DATABASE IF EXISTS study_db;
CREATE DATABASE study_db;
USE study_db;
create table storehouses_products (
	value int
);
insert into storehouses_products values (0),(2500),(0),(30),(500),(1);
select * from storehouses_products ORDER BY IF(value > 0, 0, 1), value;
# ��������� ������
#1.����������� ������� ������� ������������� � ������� users
use vk;
select avg((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25) from profiles;
#2.����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������.
# ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
select DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday, 6, 8))) as bd_this_year,
    count(*) as count_bd
from profiles
group by bd_this_year
order by count_bd;
