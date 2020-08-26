-- 1-8)

--a)

SELECT name FROM Users WHERE (name NOT LIKE '%а %а');

--b)
SELECT login FROM Users WHERE (login LIKE 'p%r%');