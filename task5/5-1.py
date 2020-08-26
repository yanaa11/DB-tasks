import psycopg2 as pg 
import time

conn = pg.connect(dbname = 'firstdb', user = 'yanadb', password = '171007', host = 'localhost')
cursor = conn.cursor()
cursor.execute("select * from A")
records = cursor.fetchall()
print(records)
cursor.close()
conn.close()
