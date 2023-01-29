# from flask import Flask
# from flask_mysqldb import MySQL
 
# app = Flask(__name__)
 
# app.config['MYSQL_HOST'] = 'localhost'
# app.config['MYSQL_USER'] = 'root'
# app.config['MYSQL_PASSWORD'] = 'reddy@1620'
# app.config['MYSQL_DB'] = 'temp'
 
# mysql = MySQL(app)
# val=('1000','Student')
# conn = mysql.connection
# cur = conn.cursor()
# cur.execute(stmt)
# # @app.route('/connection')
# # def connection():
# #     conn = mysql.connection
# #     cur = conn.cursor()
# #     cur.execute(stmt)
# #     # output = cur.fetchall()
# #     # return str(output)

# app.run()


# # cursor = mysql.connection.cursor()
# # if cursor!=None:
# #     cursor.execute("INSERT INTO departments VALUES('1000','Student'))")
# #     cursor.close()


# from flask import *
# import mysql.connector
# conn = mysql.connector.connect(
#   host="localhost",
#   user="root",
#   password="reddy@1620",
#   database="employees"
# )

# mycursor = conn.cursor()

# sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
# val = ("John", "Highway 21")
# mycursor.execute(sql, val)

# conn.commit()

# print(mycursor.rowcount, "record inserted.")

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="reddy@1620",
  database="employees"
)
stmt="CREATE TABLE users(fullName varchar(255),userName varchar(255) primary key,password varchar(255))"
cursor=mydb.cursor()
cursor.execute(stmt)
cursor.close()