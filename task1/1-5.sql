--1-5)

SELECT title, performer FROM Tasks 
	WHERE (performer = 'sofia.petrova') 
		AND (creator IN (SELECT login FROM Users WHERE (department IN ('Администрация', 'Бухгалтерия', 'Производство'))));


--var2)

CREATE VIEW tu AS 
SELECT title, performer, creator, department FROM Tasks AS t 
LEFT JOIN Users AS u ON t.creator = u.login;

SELECT title, performer, creator, department FROM tu 
WHERE (department IN ('Администрация', 'Бухгалтерия', 'Производство')) AND (performer = 'sofia.petrova');




SELECT t.title, t.performer, t.creator, u.department FROM Tasks t, Users u

	WHERE t.creator = u.login 
	and t.performer = 'sofia.petrova' 
	and u.department IN ('Администрация', 'Бухгалтерия', 'Производство'); 
