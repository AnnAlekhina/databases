use vk;

/*����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������,
������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).*/

select from_user_id,
	(select firstname from users where id = messages.from_user_id),
	(select lastname from users where id = messages.from_user_id),
	count(*)  
from messages 
where to_user_id = 1
group by from_user_id
order by from_user_id desc
limit 1;
/*���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..*/

select count(*) from likes
where media_id in (select id from media 
	where user_id in (select user_id from profiles 
		where (birthday + interval 10 year) > now() 
		)
	);

/*���������� ��� ������ �������� ������ (�����): ������� ��� �������.*/



select count(*),'�������' from likes
where media_id in (select id from media 
	where user_id in (select user_id from profiles 
		where gender ='m'
		)
	)
	union 
select count(*),'�������' from likes
where media_id in (select id from media 
	where user_id in (select user_id from profiles 
		where gender ='f'
		)
	);


