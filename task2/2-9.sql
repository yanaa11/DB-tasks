
create view v9 as
select 

	otr.performer, 

-- всего задач
	count(otr.id) as total_tasks,

-- задач в срок
	(select count(ontime.id) from 
		(select id, performer from tasks where (estimation - spending) > 0) 
		as ontime where ontime.performer = otr.performer group by ontime.performer) as on_time, 

--задач задержано
	(select count(late.id) from 
		(select id, performer from tasks where (estimation - spending) < 0) 
		as late where late.performer = otr.performer group by late.performer) as later,

--нет итогового времени выполнения *
	(select count(notfinised.id) from
		(select id, performer from tasks where spending is null)
		as notfinised where notfinised.performer = otr.performer group by notfinised.performer) as not_finised, 

--выполняется задач
	(select count(perf.id) from
		(select id, performer from tasks where state = 'Выполняется')
		as perf where perf.performer = otr.performer group by perf.performer) as performed,

-- открыто задач
	(select count(opened.id) from
		(select id, performer from tasks where state in ('Переоткрыта', 'Новая'))
		as opened where opened.performer = otr.performer group by opened.performer) as opened,
-- закрыто задач
	(select count(closed.id) from
		(select id, performer from tasks where state = 'Закрыта')
		as closed where closed.performer = otr.performer group by closed.performer) as closed,

--суммарное потраченное время
	(select sum(spend.spending) from
		(select spending, performer from tasks)
		as spend where spend.performer = otr.performer group by spend.performer) as spended, 

--недоработка 
	(select sum(spend_less.dif) from
		(select (estimation - spending) as dif, performer from tasks where (estimation - spending) > 0)
		as spend_less where spend_less.performer = otr.performer group by spend_less.performer) as hours_less,

--переработка
	(select sum(spend_more.dif) from
		(select -1*(estimation - spending) as dif, performer from tasks where (estimation - spending) < 0)
		as spend_more where spend_more.performer = otr.performer group by spend_more.performer) as hours_over,

--среднее время выполнения
	(select avg(spend.spending) from
		(select spending, performer from tasks where spending is not null)
		as spend where spend.performer = otr.performer group by spend.performer) as avg_time,

--средний приоритет
	(select avg(pr.priority) from
		(select priority, performer from tasks)
		as pr where pr.performer = otr.performer group by pr.performer) as avg_priority

from tasks otr group by otr.performer;