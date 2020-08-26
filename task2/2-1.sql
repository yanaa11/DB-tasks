-- 2-1)

SELECT tasks.performer, AVG(tasks.priority) AS avg_priority FROM tasks 
GROUP BY tasks.performer ORDER BY AVG(tasks.priority) DESC LIMIT 3;