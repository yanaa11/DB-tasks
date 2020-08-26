--1-6) 

--a) Создана, но не назначена на исполнение: creator есть, а performer NULL
--b) У каждой должен быть автор - ограничение на столбец creator NOT NULL (А что в таком случае с ON DELETE делать??????)

--1) 

--('Демо-Сибирь', '2015-05-11', '2015-01-31'),

INSERT INTO Tasks (project, title, priority, description, state, estimation, 
	spending, creator, performer, start_date, completion_date) VALUES
('Демо-Сибирь', 'demo1', 5, NULL, 'Закрыта', 10.0, NULL, 'vera.belova', NULL, '2015-06-06', '2015-01-01'),
('Демо-Сибирь', 'demo2', 20, NULL, 'Закрыта', 10.0, 11.5, 'vera.belova', NULL, '2015-06-06', '2015-01-01'),
('Демо-Сибирь', 'demo3', 49, NULL, 'Закрыта', 10.0, 12.5, 'vera.belova', NULL, '2015-06-06', '2015-01-01');

--2)

SELECT title, performer FROM Tasks WHERE (performer IS NULL);

--3)

UPDATE Tasks SET performer='sofia.petrova' WHERE(performer IS NULL);
SELECT title, performer FROM Tasks WHERE (performer = 'sofia.petrova');

