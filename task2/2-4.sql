SELECT p1.creator, p1.performer FROM v1 p1 LEFT JOIN v1 p2 ON 
	p1.creator = p2.performer AND p1.performer = p2.creator 
	WHERE p1.creator < p2.creator OR p2.creator IS NULL;

(select creator a, performer b from tasks where creator > performer) union 
	(select performer a, creator b from tasks where creator < performer);
