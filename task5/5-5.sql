
create table thistory
(
	-- полагаю, что id задачи менять нельзя, по нему она везде везде идентифицируется

	-- данные задачи
	id int,
	project varchar(50),
	title varchar(50) NOT NULL,
	priority smallint NOT NULL CHECK (priority >= 0), 
	description text,
	state varchar(20) CHECK (state IN ('Новая', 'Переоткрыта', 'Выполняется', 'Закрыта')),
	estimation real NOT NULL CHECK (estimation > 0),
	spending real CHECK (spending > 0), 
	creator varchar(50),
	performer varchar(50),
	start_date date NOT NULL, 
	completion_date date,

	-- данные изменений
	modif_type varchar(10) check (modif_type in ('UPDATE', 'INSERT', 'DELETE')),
	modif_time timestamp not null
);

create or replace function on_modification() returns trigger as $$
	begin

	if tg_op = 'INSERT' then
		insert into thistory(id, project, title, priority, description, state, estimation, 
			spending, creator, performer, start_date, completion_date, modif_type, modif_time) values
		(new.id, new.project, new.title, new.priority, new.description, new.state, new.estimation,
			new.spending, new.creator, new.performer, new.start_date, new.completion_date,
			'INSERT', now());
	end if;

	if tg_op = 'UPDATE' then 
		insert into thistory(id, project, title, priority, description, state, estimation, 
			spending, creator, performer, start_date, completion_date, modif_type, modif_time) values
		(new.id, new.project, new.title, new.priority, new.description, new.state, new.estimation,
			new.spending, new.creator, new.performer, new.start_date, new.completion_date,
			'UPDATE', now());
	end if;

	if tg_op = 'DELETE' then
		insert into thistory(id, project, title, priority, description, state, estimation, 
			spending, creator, performer, start_date, completion_date, modif_type, modif_time) values
		(old.id, old.project, old.title, old.priority, old.description, old.state, old.estimation,
			old.spending, old.creator, old.performer, old.start_date, old.completion_date,
			'DELETE', now());
	end if;

	return new;
	end;
$$ language plpgsql;

create trigger on_modification_trigger
	after insert or update or delete on tasks
	for each row execute procedure on_modification();*/

create or replace function id_by_title(given_title varchar(50)) returns int as $$
	declare
		found_id int;
	begin
		select tasks.id from tasks where tasks.title = given_title into found_id;
		return found_id;
	end; 
$$ language plpgsql; 

create or replace function task_history(given_title varchar(50))
	returns setof thistory as $$
declare 
	task_id int;
begin
	select id_by_title(given_title) into task_id;
	return query select * from thistory where id = task_id;
end;
$$ language plpgsql;

create or replace function cancel_last_modification(task_id int) returns varchar as $$
declare 
	--task_id int;
	last thistory%rowtype; -- последняя запись по задаче
	before_upd thistory%rowtype;
	result varchar(100);
begin
	--select id_by_title(task_title) into task_id;
	select * from thistory where id = task_id order by modif_time desc limit 1 into last;

	if last.id is null then
		result = 'No modifications found';
		return result;
	end if;

	if last.modif_type = 'INSERT' then
		delete from tasks where tasks.id = task_id;
		result = 'Inserted row was deleted';
	end if;

	if last.modif_type = 'DELETE' then
		insert into tasks (id, project, title, priority, description, state, estimation, spending, 
			creator, performer, start_date, completion_date) VALUES
		(task_id, last.project, last.title, last.priority, last.description, last.state, last.estimation, last.spending,
			last.creator, last.performer, last.start_date, last.completion_date);
		result = 'Deleted row was restored';
	end if;

	if last.modif_type = 'UPDATE' then
		select * from thistory where (thistory.id = task_id) and (thistory.modif_time < last.modif_time) 
		order by modif_time desc limit 1 into before_upd;
		update tasks set project = before_upd.project, title = before_upd.title, priority = before_upd.priority,
			description = before_upd.description, state = before_upd.state, estimation = before_upd.estimation,
			spending = before_upd.spending, creator = before_upd.creator, performer = before_upd.performer,
			start_date = before_upd.start_date, completion_date = before_upd.completion_date where id = task_id;
		result = 'Update was canceled';
	end if;

	delete from thistory where id = task_id and modif_time >= last.modif_time;

	return result;
	end;
$$ language plpgsql;




-- check
select task_history('rtk3');
update tasks set priority = 0 where title = 'rtk3';
select task_history('rtk3');
select cancel_last_modification(4);
delete from tasks where title = 'rtk3';
select cancel_last_modification(4);

INSERT INTO Tasks (project, title, priority, description, state, estimation, spending, creator, performer, start_date, completion_date) VALUES
('РТК', 'rtk50', 51, 'rtk1 description', 'Закрыта', 5.5, 15.5, 'sofia.petrova', 'vasilina.ivanova', '2016-04-11', '2017-01-12');

select cancel_last_modification(29);