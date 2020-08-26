SELECT login, length(login) FROM users WHERE 
length(login) = (SELECT max(length(login)) FROM users);