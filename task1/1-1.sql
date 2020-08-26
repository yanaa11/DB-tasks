-- 1-1) Create tables: Users, Projects, Tasks

CREATE TABLE Users (

	name varchar(50) NOT NULL,
	login varchar(50) PRIMARY KEY, 
	email varchar(50) NOT NULL, 
	department varchar(50) CHECK (department IN ('Производство', 'Поддержка пользователей', 'Бухгалтерия', 'Администрация'))
 );

CREATE TABLE Projects (

	title varchar(50) PRIMARY KEY,
	description text, 
	start_date date NOT NULL,
	completion_date date
);

-- изначально было CHECK (completion_date >= start_date) но сравнение даты с NULL???

CREATE TABLE Tasks (

	id serial PRIMARY KEY,
	project varchar(50) REFERENCES Projects (title) ON DELETE CASCADE,
	title varchar(50) NOT NULL,
	priority smallint NOT NULL CHECK (priority >= 0), 
	description text,
	state varchar(20) CHECK (state IN ('Новая', 'Переоткрыта', 'Выполняется', 'Закрыта')),
	estimation real NOT NULL CHECK (estimation > 0),
	spending real CHECK (spending > 0), 
	creator varchar(50) REFERENCES Users (login) ON DELETE SET NULL,
	performer varchar(50) REFERENCES Users (login) ON DELETE SET NULL,
	start_date date NOT NULL, 
	completion_date date
);

