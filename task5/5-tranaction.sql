
begin transaction;
	INSERT INTO A (id, data) VALUES
	(5, 'eee');

	INSERT INTO A (id, data) VALUES
	(1, 'aaa'); -- тут должно все сломаться и транзакция не пройдет 

commit;


begin transaction;
	INSERT INTO A (id, data) VALUES
	(5, 'eee'); -- не должно сохраниться

	rollback;


begin transaction;
	INSERT INTO A (id, data) VALUES
	(5, 'eee'); -- это должно сохраниться

	savepoint sp;

	INSERT INTO A (id, data) VALUES
	(7, 'ggg'); -- это откатится и не сохранится

	rollback to sp;

commit;