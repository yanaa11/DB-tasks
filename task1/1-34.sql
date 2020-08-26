-- 1-3) 

-- a) 
--1)
SELECT * FROM Tasks;
--2)
SELECT id, project, title, priority, description, state, estimation, spending, creator, performer, start_date, completion_date FROM Tasks;

--b)
SELECT name, department FROM Users; 

--c)
SELECT login, email FROM Users;

--d)
SELECT title, priority FROM Tasks WHERE (Tasks.priority > 50);

--e)
SELECT DISTINCT performer FROM Tasks;

--f)
(SELECT creator AS users FROM Tasks) UNION (SELECT performer FROM Tasks); 

--k) 
SELECT title, creator, performer FROM Tasks WHERE ((creator != 'sofia.petrova') AND (performer IN ('vasilina.ivanova', 'petr.sidorov', 'aleksey.berkut')));

-- 1-4) 
SELECT title, performer, start_date FROM Tasks WHERE (start_date BETWEEN '2016-01-01' AND '2016-01-03');
