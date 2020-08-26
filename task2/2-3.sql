--create view v23 as select performer, estimation, spending from tasks;

--create view dif as select performer, (estimation - spending) dif from v23 where spending is not null;

-- var 1

--create view spend_more as select performer, -1*sum(dif) more from dif where dif < 0 group by performer;

--create view spend_less as select performer, sum(dif) less from dif where dif > 0 group by performer;

select * from spend_more full join spend_less on (spend_more.performer = spend_less.performer);

-- var 2
select performer, 
(select sum(estimation - spending) from tasks inr1 
	where (estimation - spending) > 0 and inr1.performer = otr.performer group by inr1.performer) as spend_less,

(select -1*sum(estimation - spending) from tasks inr2
	where (estimation - spending) < 0 and inr2.performer = otr.performer group by inr2.performer) as spend_more
from tasks otr group by otr.performer;


-- var aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

select performer, 
    (sum(estimation - spending) + sum(abs(estimation - spending)))/2 as spend_less, 
    (sum(spending - estimation) + sum(abs(spending - estimation)))/2 as spend_more
    from tasks group by performer;

