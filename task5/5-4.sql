
--							CREATE TABLES

/*create table nodes 
(
	id serial primary key, 
	node_path varchar
);

create table files
(
	id serial primary key,
	name varchar(20),
	node int references nodes(id) on delete cascade on update cascade,
	full_path varchar(210),
	size int not null, 
	created date not null,
	written date not null,
	modified date
);

insert into nodes(node_path) values
	('first'),
	('second'); 

insert into files(name, node, full_path, size, created, written, modified) values
	('file1', 1, '/', 100, '2020-05-01', '2020-05-02', null), 
	('dir1', 2, '/', 1000, '2020-05-01', '2020-05-01', '2020-05-05'),
	('file2', 2, '/dir1', 200, '2020-05-05', '2020-05-05', '2020-05-05'),
	('dir2', 2, '/dir1', 1000, '2020-05-01', '2020-05-01', '2020-05-05'),
	('dir3', 1, '/', 1000, '2020-05-01', '2020-05-01', '2020-05-05');*/

--							TECNICAL FUNCTIONS

create or replace function last_dash_pos(full_path varchar) returns int as
	$$
	declare
		cur_pos int;
		count_pos int;
		cur_path varchar;
	begin
		cur_pos = -1;
		count_pos = 0;
		cur_path = full_path;
		while cur_pos != 0 loop
			if cur_pos = -1 then
				cur_pos = 0;
			end if;
			select substring(cur_path, cur_pos + 1) into cur_path;
			select position('/' in cur_path) into cur_pos;
			count_pos = count_pos + cur_pos;
		end loop;
		return count_pos;
	end;
	$$ language plpgsql;

create or replace function cut_path(full_path varchar) returns varchar as
	$$
	declare
		new_path varchar;
		pos int;
	begin
		select last_dash_pos(full_path) into pos;
		if pos = 0 then
			return 'not a path';
		end if;
		if pos = 1 then
			return '/';
		end if;
		select substring(full_path, 1, pos-1) into new_path;
		return new_path;
	end;
	$$ language plpgsql;

create or replace function cut_name(full_path varchar) returns varchar as
	$$
	declare
		new_name varchar;
		pos int;
	begin
		select last_dash_pos(full_path) into pos;
		if pos = 0 then
			return full_path;
		end if;
		select substring(full_path, pos+1) into new_name;
		return new_name;
	end;
	$$ language plpgsql;

create or replace function glue_path(first_path varchar, name varchar) returns varchar as 
	$$
	declare
		new_path varchar;
	begin
		if first_path = '/' then
			select concat(first_path, name) into new_path;
			return new_path;
		end if;
		select concat(first_path, '/', name) into new_path;
		return new_path;
	end;
	$$ language plpgsql;

--							ADD FILE

create or replace function add_file(i_node int, i_full_path varchar, i_name varchar, i_size int, i_created date) 
returns varchar as 
	$$
	declare 
		result varchar;
		c int;
		dir_path varchar;
		dir_name varchar;

	begin
		-- check if node exists
		select id from nodes where nodes.id = i_node into c;
		if c is null then
			return 'incorrect node id';
		end if;

		-- check if such directory exists
		if i_full_path != '/' then
			select cut_path(i_full_path) into dir_path;
			select cut_name(i_full_path) into dir_name;
			select id from files where full_path = dir_path and name = dir_name into c;
			if c is null then
				return 'incorrect path';
			end if;
		end if;

		-- check if the same file alredy exists
		select id from files where files.full_path = i_full_path and files.name = i_name and files.node = i_node into c;
		if c is not null then
			return 'file already exists';
		end if;

		insert into files (name, node, full_path, size, created, written, modified) values
			(i_name, i_node, i_full_path, i_size, i_created, current_date, null);
		return 'file added';
	end;
	$$ language plpgsql;

--								DELETE 

create or replace function delete_file(i_node int, i_full_path varchar, i_name varchar) returns varchar as
	$$
	declare
		c int;
		glue_path varchar;
	begin
		-- check if node exists
		select id from nodes where nodes.id = i_node into c;
		if c is null then
			return 'incorrect node id';
		end if;

		-- check if file exists
		select id from files where files.full_path = i_full_path and files.name = i_name and files.node = i_node into c;
		if c is null then
			return 'no file to delete';
		end if;

		select glue_path(i_full_path, i_name) into glue_path;
		delete from files where full_path = i_full_path and name = i_name and node = i_node;
		-- delete folded files if it was a parent dirictory
		delete from files where (full_path like concat(glue_path, '/%') or full_path = glue_path) and node = i_node;
		return 'file was deleted';
	end;
	$$ language plpgsql;

--								RENAME

create or replace function rename_file(i_node int, i_full_path varchar, i_name varchar, new_name varchar) returns varchar as
	$$
	declare
		c int;
		dir_path varchar;
		dir_name varchar;
		old_path varchar;
		new_path varchar;
	begin
		-- check if node exists
		select id from nodes where nodes.id = i_node into c;
		if c is null then
			return 'incorrect node id';
		end if;

		-- check if such directory exists
		if i_full_path != '/' then
			select cut_path(i_full_path) into dir_path;
			select cut_name(i_full_path) into dir_name;
			select id from files where full_path = dir_path and name = dir_name into c;
			if c is null then
				return 'incorrect path';
			end if;
		end if;

		-- check if file for renaming exists
		select id from files where files.full_path = i_full_path and files.name = i_name and files.node = i_node into c;
		if c is null then
			return 'no such file';
		end if;

		-- check if the same file alredy exists
		select id from files where files.full_path = i_full_path and files.name = new_name and files.node = i_node into c;
		if c is not null then
			return 'file with this name already exists';
		end if;

		-- rename file itself
		update files set name = new_name, modified = current_date where node = i_node and full_path = i_full_path and name = i_name;

		-- change name in path of folded files
		select glue_path(i_full_path, i_name) into old_path;
		select glue_path(i_full_path, new_name) into new_path;
		update files set full_path = replace(full_path, old_path, new_path), modified = current_date 
			where (full_path like concat(old_path, '/%') or full_path = old_path) and node = i_node;
		return 'file was renamed';
	end;
	$$ language plpgsql;

--							COPY

create or replace function copy_file(i_node int, i_full_path varchar, i_name varchar, new_node int, new_full_path varchar) returns varchar as
	$$
	declare
		c int;
		dir_path varchar;
		dir_name varchar;
		initial files%rowtype;
		old_path varchar;
		new_path varchar;
		cr refcursor; 
		row record;
	begin
		-- check if node exists
		select id from nodes where nodes.id = i_node into c;
		if c is null then
			return 'incorrect initial node id';
		end if;

		-- check if new node exists
		select id from nodes where nodes.id = new_node into c;
		if c is null then
			return 'incorrect new node id';
		end if;

		-- check if directory exists
		if i_full_path != '/' then
			select cut_path(i_full_path) into dir_path;
			select cut_name(i_full_path) into dir_name;
			select id from files where full_path = dir_path and name = dir_name into c;
			if c is null then
				return 'incorrect initial path';
			end if;
		end if;

		-- check if new directory exists
		if new_full_path != '/' then
			select cut_path(new_full_path) into dir_path;
			select cut_name(new_full_path) into dir_name;
			select id from files where full_path = dir_path and name = dir_name into c;
			if c is null then
				return 'incorrect path';
			end if;
		end if;

		-- check if no such file in destination
		select * from files where files.full_path = new_full_path and files.name = i_name and files.node = new_node into c;
		if c is not null then
			return 'file already exixts in the destination'; -- check if file for copy exists
		end if;

		select * from files where files.full_path = i_full_path and files.name = i_name and files.node = i_node into initial;
		if initial is null then
			return 'no such file'; -- check if file for copy exists
		end if;

		-- copy file itself
		insert into files (name, node, full_path, size, created, written, modified) values
			(initial.name, new_node, new_full_path, initial.size, initial.created, initial.written, current_date);

		-- copy folded files 
		select glue_path(i_full_path, i_name) into old_path;
		select glue_path(new_full_path, i_name) into new_path;

		-- open cursor for initial folded files
		open cr for select * from files where node = i_node and (full_path like concat(old_path, '/%') or full_path = old_path);
		loop
			fetch cr into row;
			exit when not found;
			insert into files (name, node, full_path, size, created, written, modified) values
			(row.name, new_node, new_path, row.size, row.created, row.written, current_date);
		end loop;

		return 'file was copied';
	end;
	$$ language plpgsql;

-- 									MOVE

create or replace function move_file(i_node int, i_full_path varchar, i_name varchar, new_node int, new_full_path varchar) returns varchar as
	$$ 
	declare
	res varchar;
	begin
		select copy_file(i_node, i_full_path, i_name, new_node, new_full_path) into res;
		if res != 'file was copied' then
			return concat('can not move file: ', res);
		end if;

		select delete_file(i_node, i_full_path, i_name) into res;
		if res != 'file was deleted' then
			return concat('can not move file: ', res);
		end if;
		return 'file was moved';
	end;
	$$ language plpgsql;

--								FIND

-- just count dashes in path ('/' = 1 depth level, '/aaa(/filename)' = 2)
create or replace function get_depth(full_path varchar) returns int as
	$$
	declare
		cur_pos int;
		count_dash int;
		cur_path varchar;
	begin
		if full_path = '/' then
			return 1;
		end if;
		cur_pos = -1;
		count_dash = 0;
		cur_path = full_path;
		while cur_pos != 0 loop
			if cur_pos = -1 then
				cur_pos = 0;
			end if;
			select substring(cur_path, cur_pos + 1) into cur_path;
			select position('/' in cur_path) into cur_pos;
			count_dash = count_dash + 1;
		end loop;
		return count_dash;
	end;
	$$ language plpgsql;

create or replace function find_file(mask varchar, depth int) returns setof files as
	$$
	declare
	begin
		return query select * from files where name like mask and (select get_depth(full_path) = depth);
	end;
	$$ language plpgsql;






-- check 
select add_file('1', '/', 'dir3', 500, '2020-05-14');
select add_file('1', '/dir3', 'myfile', 100, '2020-05-14');
select add_file('1', '/dir3', 'dir5', 100, '2020-05-14');
select add_file('1', '/dir3/dir5', 'foldedfile', 100, '2020-05-14');
select rename_file('1', '/dir3', 'dir5', 'newdir');
select copy_file(1, '/dir3', 'newdir', 2, '/');
select delete_file(2, '/', 'newdir');
select move_file(1, '/', 'dir3', 2, '/');
select find_file('%dir%', 2);