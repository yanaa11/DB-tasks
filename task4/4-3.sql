select name, login from users 
	where exists (select 1 from tasks where tasks.performer = users.login and priority > 90);


select distinct users.name, tasks.performer from users, tasks 
	where users.login = tasks.performer and tasks.priority > 90;


select distinct users.name, users.login from users 
	inner join (select performer from tasks where priority > 90) as perf on perf.performer = users.login;