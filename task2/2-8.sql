SELECT performer, sum(estimation) FROM tasks 
	WHERE (estimation >= (SELECT avg(estimation) FROM tasks)) AND (state != 'Закрыта') 
	GROUP BY performer;