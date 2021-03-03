#1. 
# создала файлы my.cnf и my.ini расположила их тут C:\Windows
# файлы следующего содержания 
[mysql]
user=root
password=
#к сожалению, вход без пароля так и не заработал
#я запихнула файлы по так же просто в корень диска С, но все равно безуспешно

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