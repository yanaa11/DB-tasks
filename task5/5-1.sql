-- 2 процесса

begin transaction; 
update A set data = 'iii' where id = 1;
update A set data = 'iii' where id = 2;

-- во втором наоборот id

--решение: 
select * from A for update;

--тогда второй процесс просто дождется первого и продолжит