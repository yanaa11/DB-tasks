
/*create table orders2(

	id serial primary key,
	datime timestamp not null

);*/

/*insert into orders (id, datime) values
	(1, '2020-01-08 04:05:06'),
	(2, '2020-01-15 16:05:06'),
	(3, '2020-02-01 11:05:06'),
	(4, '2020-02-01 15:05:06'),
	(5, '2020-02-17 04:05:06'),
	(6, '2020-03-11 18:05:06'),
	(7, '2020-03-16 21:05:06'),
	(8, '2020-04-01 00:05:06'),
	(9, '2020-04-27 12:05:06'),
	(10, '2020-05-01 17:05:06');*/
	
/*create or replace procedure finddates(in first timestamp, in second timestamp)
language plpgsql as $$
	begin 
		select * from orders where orders.datime between first and second;
	end $$;*/

/*create or replace function finddates(in first timestamp, in second timestamp) returns setof timestamp as
	$$ 
	declare 
		datime timestamp;
	begin
		for datime in select orders.datime from orders where orders.datime between first and second
		loop
			return next datime;
		end loop;
		return;
	end
	$$ language plpgsql;*/


-- insert a looooot of records
/*create or replace function insetdates() returns int as $$
declare 
	i int;

begin
	i = 0;
	while i < 1000 loop
		insert into orders2 (datime) values ('2020-01-08 04:05:06');
		i = i + 1;
	end loop;

	while i < 2000 loop
		insert into orders2 (datime) values ('2020-02-01 11:05:06');
		i = i + 1;
	end loop;

	while i < 3000 loop
		insert into orders2 (datime) values ('2020-02-17 04:05:06');
		i = i + 1;
	end loop;

	while i < 4000 loop
		insert into orders2 (datime) values ('2020-01-15 16:05:06');
		i = i + 1;
	end loop;

	while i < 5000 loop
		insert into orders2 (datime) values ('2020-03-11 18:05:06');
		i = i + 1;
	end loop;

	while i < 6000 loop
		insert into orders2 (datime) values ('2020-04-01 00:05:06');
		i = i + 1;
	end loop;

	while i < 7000 loop
		insert into orders2 (datime) values ('2020-04-27 12:05:06');
		i = i + 1;
	end loop;

	while i < 8001 loop
		insert into orders2 (datime) values ('2020-05-01 17:05:06');
		i = i + 1;
	end loop;

	return i;
end;
$$ language plpgsql;*/

-- 2 VARIANTS

/*create or replace function findadate(in first timestamp, in second timestamp) returns timestamp as
	$$ 
	declare 
		min timestamp;
	begin
		select datime from orders2 where datime between first and second 
 			order by datime asc limit 2 into min;
		return min;
	end
	$$ language plpgsql;*/

-- 1 VAR

/*create or replace function finddates3(first timestamp, second timestamp) returns setof date as
	$$ 
	declare 
		min timestamp;
	begin
		select findadate(first, second) into min;
		return query 
		with recursive rec as
                   (
                       select min::date as dates
                       union
                       select datime::date
                       from orders2
                       where (datime + interval '1 day') < second
                   )
		select * from rec;
	end
	$$ language plpgsql;*/

-- 2 VAR

/*create or replace function finddates4(first timestamp, second timestamp) returns setof date as
	$$ 
	declare 
		min timestamp;
		d timestamp;
	begin
		min = first;
		d = first;
		while d is not null loop
			select findadate(min, second) into d;
			min = d + interval '1 day';
			return next d::date;
		end loop;
		return;
	end
	$$ language plpgsql;*/


-- COMPARE
\timing on

select finddates3('2020-01-01', '2020-03-01');

select finddates4('2020-01-01', '2020-03-01');

select distinct datime::date from orders2 where datime between '2020-01-01' and '2020-03-01';

\timing off
