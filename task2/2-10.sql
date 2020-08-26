-- почта сотрудников, выполняющих задачи

-- простое объединение, по условию
select tasks.title task, users.email from users, tasks where users.login = tasks.performer;

-- соотнесенный подзапрос
select tasks.title, (select users.email from users where tasks.performer = users.login) from tasks;

-- вложенный подзапрос
select a.title, b.email from 
	(select title, performer from tasks) as a, (select email, login from users) as b
	where a.performer = b.login;