create view pochti as select * from (select distinct performer a, creator b from tasks) as t1 
	union (select distinct creator a, performer b from tasks);


(select creator a, performer b from tasks where creator > performer) union 
	(select performer a, creator b from tasks where creator < performer);