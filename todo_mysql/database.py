import mysql.connector
mydb=mysql.connector.connect(
    host='localhost',
    password='reddy@1620',
    user='root',
    database='employees'
)

cursor=mydb.cursor()
stmt='CREATE TABLE TODOS(name varchar(255),item varchar(255),foreign key (name) references users(userName))'
cursor.execute(stmt)
mydb.commit()
cursor.close()