CREATE VIEW	view22 AS 
	SELECT creator, date_part('month', start_date) as month, date_part('year', start_date) as year 
	FROM tasks;

SELECT count(creator), month, creator FROM view22 
	WHERE (year = 2015) GROUP BY month, creator;  