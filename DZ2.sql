#1. 
# ������� ����� my.cnf � my.ini ����������� �� ��� C:\Windows
# ����� ���������� ���������� 
[mysql]
user=root
password=
#� ���������, ���� ��� ������ ��� � �� ���������
#� ��������� ����� �� ��� �� ������ � ������ ����� �, �� ��� ����� ����������

#2.
CREATE TABLE IF NOT EXISTS users(
id INT,
name CHAR(32)
);
#3.
#mysqldump -u root -p example>sample.sql
create database sample;
#use sample
#source sample.sql