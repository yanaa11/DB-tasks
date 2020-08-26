
CREATE TABLE A (

	id int PRIMARY KEY,
	data varchar
);

CREATE TABLE B (

	id int PRIMARY KEY,
	data int CHECK (B.data < 1000),
	aid int REFERENCES A(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE C (

	id int PRIMARY KEY,
	data varchar,
	aid int REFERENCES A(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO A (id, data) VALUES
(1, 'aaa'),
(2, 'bbb'),
(3, 'ccc'),
(4, 'ddd'),
(5, 'eee');

INSERT INTO B (id, data, aid) VALUES
(10, 115, 1),
(20, 215, 2);

INSERT INTO C (id, data, aid) VALUES
(100, 'Caaa', 1),
(200, 'Cbbb', 2);