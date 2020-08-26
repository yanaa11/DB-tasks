-- views to work with
create view hp as select id, title, priority from tasks where priority >= 50;

create view he as select id, title, estimation from tasks where estimation > 60;

-- queries 

select hp.id, hp.title, hp.priority, he.estimation from hp inner join he on hp.id = he.id;

select * from hp full outer join he on hp.id = he.id;

select * from hp full outer join he on hp.id = he.id where hp.id is null or he.id is null;

select * from hp left join he on hp.id = he.id;

select * from hp left join he on hp.id = he.id where he.id is null;

select * from hp right join he on hp.id = he.id;

select * from hp right join he on hp.id = he.id where hp.id is null;

--

select hp.id, hp.title, hp.priority, he.estimation from hp inner join he using (id, title);

select * from hp full outer join he using (id, title);

select * from hp full outer join he using (id, title) where hp.id is null or he.id is null;

select * from hp left join he using (id, title);

select * from hp left join he using (id, title) where he.id is null;

select * from hp right join he using (id, title);

select * from hp right join he using (id, title) where hp.id is null;


