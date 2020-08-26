
INSERT INTO A (id, data) VALUES (3, 'yyy'); -- primary key

INSERT INTO B (id, data, aid) VALUES (30, 1099, 3); -- check 

INSERT INTO B (id, data, aid) VALUES (60, 99, 6); -- foreign key 

INSERT INTO C (id, data, aid) VALUES (700, 'Cddd', 7); -- foreign key 

UPDATE A SET id = 10 WHERE id = 1; -- B restrict

INSERT INTO C (id, data, aid) VALUES (400, 'Cjjj', 4); 

UPDATE A SET id = 40 WHERE id = 4; -- OK (C cascade)

DELETE FROM A WHERE id = 1; -- B restrict

DELETE FROM A where id = 40; -- OK (C cascade)

UPDATE B SET id = 20 WHERE id = 10; -- primary key 

UPDATE B SET data = 2000 WHERE id = 10; -- check