-- 1-2) Fiil tables

INSERT INTO Users (name, login, email, department) VALUES 
('Касаткин Артём', 'artem.kasatkin', 'artem.kasatkin@pochta.ru', 'Администрация'),
('Петрова София', 'sofia.petrova', 'sofia.petrova@pochta.ru', 'Бухгалтерия'),
('Дроздов Федр', 'fedr.drozdov', 'fedr.drozdov@pochta.ru', 'Поддержка пользователей'),
('Иванова Василина', 'vasilina.ivanova', 'vasilina.ivanova@pochta.ru', 'Бухгалтерия'),
('Беркут Алексей', 'aleksey.berkut', 'aleksey.berkut@pochta.ru', 'Производство'),
('Белова Вера', 'vera.belova', 'vera.belova@pochta.ru', 'Поддержка пользователей'),
('Макенрой Алексей', 'aleksey.makenroy', 'aleksey.makenroy@pochta.ru', 'Производство'),
('Сидоров Петр', 'petr.sidorov', 'petr.sidorov@pochta.ru', 'Производство'); 

INSERT INTO Projects (title, start_date, completion_date) VALUES
('РТК', '2016-01-31', NULL),
('СС.Коннект', '2015-02-23', '2016-12-31'),
('Демо-Сибирь', '2015-05-11', '2015-01-31'),
('МВД-Онлайн', '2015-05-22', '2016-01-31'),
('Поддержка', '2016-06-07', NULL);

INSERT INTO Tasks (project, title, priority, description, state, estimation, spending, creator, performer, start_date, completion_date) VALUES
('РТК', 'rtk1', 51, 'rtk1 description', 'Закрыта', 5.5, 15.5, 'sofia.petrova', 'vasilina.ivanova', '2016-04-11', '2017-01-12'),
('РТК', 'rtk2', 67, 'rtk2 description', 'Выполняется', 100.0, NULL, 'aleksey.makenroy', 'petr.sidorov', '2016-08-22', NULL),
('Поддержка', 'support1', 105, 'support1 description', 'Закрыта', 35.0, 20.0, 'sofia.petrova', 'aleksey.berkut', '2016-12-01', '2017-11-05'),
('РТК', 'rtk3', 0, NULL, 'Переоткрыта', 16.0, NULL, 'aleksey.makenroy', 'vasilina.ivanova', '2018-02-15', NULL),
('МВД-Онлайн', 'mvd1', 11, 'mvd1 description', 'Закрыта', 30.0, 27.5, 'aleksey.makenroy', 'artem.kasatkin', '2016-01-01', '2016-01-15'),
('СС.Коннект', 'connect1', 26, NULL, 'Закрыта', 70.0, 35.0, 'sofia.petrova', 'artem.kasatkin', '2016-01-02', '2016-01-18'),
('СС.Коннект', 'connect2', 7, 'connect2 description', 'Закрыта', 2.5, 4.0, 'sofia.petrova', 'artem.kasatkin', '2016-01-03', '2016-08-01'),
('Поддержка', 'support2', 9, NULL, 'Выполняется', 300.0, NULL, 'aleksey.makenroy', 'aleksey.berkut', '2016-12-12', NULL),
('МВД-Онлайн', 'mvd2', 93, 'mvd2 description', 'Закрыта', 20.0, 30.0, 'aleksey.makenroy', 'artem.kasatkin', '2015-11-02', '2015-12-19'),
('Поддержка', 'support3', 19, 'support3 description', 'Закрыта', 60.0, 52.5, 'artem.kasatkin', 'sofia.petrova', '2017-05-05', '2018-08-08'),
('Поддержка', 'support4', 34, NULL, 'Новая', 11.0, NULL, 'vasilina.ivanova', 'sofia.petrova', '2018-01-01', NULL),
('Поддержка', 'support5', 0, 'support5 description', 'Закрыта', 60.0, NULL, 'aleksey.makenroy', 'sofia.petrova', '2016-11-04', '2017-05-02'),
('МВД-Онлайн', 'mvd3', 4, NULL, 'Закрыта', 80.0, NULL, 'fedr.drozdov', 'sofia.petrova', '2015-07-11', '2016-01-11');
