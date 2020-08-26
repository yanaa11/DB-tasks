CREATE VIEW v7 AS SELECT performer, max(priority) max_priority FROM tasks GROUP BY performer;

SELECT tasks.performer, tasks.priority, tasks.title FROM v7, tasks 
	WHERE (v7.performer = tasks.performer) AND (v7.max_priority = tasks.priority);
	