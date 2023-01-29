from flask import *
app=Flask(__name__)
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="reddy@1620",
  database = "temp"

)

mycursor = mydb.cursor()

mycursor.execute("create flask_project")
mycursor.execute("use flask_project")

mycursor.execute(''' create table employee(emp_id int)''')

# mycursor.execute('''  commit ''') 
l=[]
for i in mycursor:
    l.append(i)

@app.route("/Test_project")
def my1():
    return render_template('test.html',u=l)


app.run()