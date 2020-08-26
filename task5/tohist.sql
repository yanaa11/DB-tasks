/*insert into thistory(id, project, title, priority, description, state, estimation, 
			spending, creator, performer, start_date, completion_date, modif_type, modif_time) values
(1, 'РТК', 'rtk1', 51, 'rtk1 description', 'Закрыта', 5.5, 15.5, 'sofia.petrova', 'vasilina.ivanova', '2016-04-11', '2017-01-12', 'INSERT', now()),
(2, 'РТК', 'rtk2', 67, 'rtk2 description', 'Выполняется', 100.0, NULL, 'aleksey.makenroy', 'petr.sidorov', '2016-08-22', NULL, 'INSERT', now()),
(3, 'Поддержка', 'support1', 105, 'support1 description', 'Закрыта', 35.0, 20.0, 'sofia.petrova', 'aleksey.berkut', '2016-12-01', '2017-11-05', 'INSERT', now()),
(4, 'РТК', 'rtk3', 0, NULL, 'Переоткрыта', 16.0, NULL, 'aleksey.makenroy', 'vasilina.ivanova', '2018-02-15', NULL, 'INSERT', now()),
(5, 'МВД-Онлайн', 'mvd1', 11, 'mvd1 description', 'Закрыта', 30.0, 27.5, 'aleksey.makenroy', 'artem.kasatkin', '2016-01-01', '2016-01-15', 'INSERT', now()),
(6, 'СС.Коннект', 'connect1', 26, NULL, 'Закрыта', 70.0, 35.0, 'sofia.petrova', 'artem.kasatkin', '2016-01-02', '2016-01-18', 'INSERT', now());*/


INSERT INTO Tasks (project, title, priority, description, state, estimation, spending, creator, performer, start_date, completion_date) VALUES
('РТК', 'rtk50', 51, 'rtk1 description', 'Закрыта', 5.5, 15.5, 'sofia.petrova', 'vasilina.ivanova', '2016-04-11', '2017-01-12');