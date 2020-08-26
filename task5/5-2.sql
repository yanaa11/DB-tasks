
/*create or replace function func1(a int, b int) returns int as $$
	begin
		return a+b;
	end;
$$ language plpgsql;*/

-- транзакции
-- rollback to по прежнему не работает
create or replace procedure trnsact()
language plpgsql as $$
	begin
		--start transaction;
			INSERT INTO A (id, data) VALUES (7, 'ggg');
			INSERT INTO A (id, data) VALUES (1, 'aaa'); -- тут должно все сломаться и транзакция не пройдет 
		commit;


		--start transaction;
			INSERT INTO A (id, data) VALUES (7, 'ggg'); -- не должно сохраниться
		rollback;


		--start transaction;
			INSERT INTO A (id, data) VALUES (7, 'ggg'); -- это должно сохраниться
			savepoint sp;
			INSERT INTO A (id, data) VALUES (8, 'hhh'); -- это откатится и не сохранится
			ROLLBACK TO SAVEPOINT sp;
		commit;
	end $$;

-- зацикливание
create or replace function loop(a int, b int) returns int as $$
	begin
		while a > 0 loop
			a = a - b;
		end loop; 
		return a; 
	end;
$$ language plpgsql;

-- рекурсия 
create or replace function recr(a int) returns int as $$
	begin
		if a = 0 then 
			return a;
		end if;
		return recr(a-1);
	end;
$$ language plpgsql;

-- select loop(11, 5);
-- select recr(10); 