
-- pg_column_size(column) - Число байт, необходимых для хранения заданного значения

CREATE TABLE sizes (
	c_col char(50), 
	vc_col varchar(50)
);

INSERT INTO sizes (c_col, vc_col) VALUES
('abcd', 'abcd'),
('loooooooooong string', 'loooooooooong string'),
('a', 'a');

SELECT pg_column_size(c_col), pg_column_size(vc_col) FROM sizes; 