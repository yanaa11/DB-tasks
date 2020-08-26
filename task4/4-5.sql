select p.title, t.title from tasks as t, projects as p;

select p.title project, t.title task from projects p cross join tasks t;