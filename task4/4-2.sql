
select id, title, priority, creator from tasks as out 
	where priority = (select max(priority) from tasks as inr where inr.creator = out.creator);


select o.id, o.title, o.priority, o.creator from tasks o right outer join (select i.creator, max(i.priority) priority from tasks i group by i.creator) as t2 using (priority, creator);



select o.id, o.title, o.priority, o.creator from tasks o left join tasks i on o.creator = i.creator and o.priority < i.priority where i.creator is null;

-- select o.id, o.title, o.priority, o.creator, i.creator, i.priority from tasks o left join tasks i on o.creator = i.creator and o.priority < i.priority;
