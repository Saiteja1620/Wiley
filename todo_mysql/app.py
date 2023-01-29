from dis import dis
from queue import Full
from flask import *
from datetime import datetime
app=Flask(__name__)

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="reddy@1620",
  database="app"
)
# stmt="CREATE TABLE users(fullName varchar(255),userName varchar(255) primary key,password varchar(255))"

app.secret_key='sessionCreated'

@app.route("/")
def home():
    return render_template("home.html")


@app.route("/login")
def login():
    return render_template("login.html")


@app.route("/register")
def register():
    return render_template("register.html")

@app.route("/registerUser",methods=["POST"])
def registerUser():
    data=dict(request.form)
    # FullName=(data['fullName',validators.Required()])
    FullName=data['fullName']
    # deadline = (data['fullName'],[validators.Required()])
    UserName=data['userName']
    Email=data['email']
    Password=data['password']
    CPassword=data['confirmPassword']
    if(len(data)<5):
        register='registration.html'
        return render_template('error.html',name=register)
    Created=datetime.now()
    if(Password==CPassword):
        stmt='INSERT INTO USERS VALUES(%s,%s,%s,%s,%s)'
        val=(FullName,UserName,Email,Password,Created,)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        mydb.commit()
        cursor.close()
    else:
        return "Registration Failed...Password Didn't Match"
    return render_template('login.html')

@app.route('/verifyLogin',methods=["POST"])
def verify():
    data=dict(request.form)
    userName=data['userName']
    password=data['password']
    stmt='select userName,passwd from users'
    cursor=mydb.cursor()
    cursor.execute(stmt)
    result=cursor.fetchall()
    cursor.close()
    for i in result:
        if(i[0]==userName and i[1]==password):
            print(i[0],i[1])
            session['name']=userName
            stmt='select Activity from todo where UserName=(%s) and TodoStatus=0'
            val=(userName,)
            cursor=mydb.cursor()
            cursor.execute(stmt,val)
            result=cursor.fetchall()
            print(result)
            cursor.close()
            stmt='select Activity from todo where UserName=(%s) and TodoStatus=1'
            val=(userName,)
            cursor=mydb.cursor()
            cursor.execute(stmt,val)
            result1=cursor.fetchall()
            print(result1)
            cursor.close()
            return render_template('dashboard.html',todo=result,count=len(result),name=userName,incomplete=result1,icount=len(result1))
            # display(userName)
    else:
        return render_template('error.html')
@app.route("/add",methods=["POST"])
def add():
    if(session['name']):
        userName=session['name']
        item=dict(request.form)
        stmt='insert todo(UserName,Activity,TodoTimeStamp) values(%s,%s,%s)'
        val=(userName,item['item'],datetime.now(),)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        mydb.commit()
        cursor.close()
        cursor=mydb.cursor()
        stmt='select Activity from todo where UserName=(%s) and TodoStatus=1'
        val=(userName,)
        cursor.execute(stmt,val)
        result=cursor.fetchall()
        cursor.close()
        stmt='select Activity from todo where UserName=(%s) and TodoStatus=1'
        val=(userName,)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        result1=cursor.fetchall()
        cursor.close()
        return render_template('dashboard.html',count=len(result),todo=result,name=userName,incomplete=result1,icount=len(result1))
        # display(userName)

@app.route("/setStatus/<name>/<item>",methods=["POST"])
def status(name,item):
    stmt="update todo set TodoStatus=1 where Activity=(%s) and UserName=(%s)"
    val=(item,name)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    # display(name)
    cursor=mydb.cursor()
    stmt1='select Activity from todo where UserName=(%s) and TodoStatus=0'
    val1=(name,)
    cursor.execute(stmt1,val1)
    result=cursor.fetchall()
    cursor.close()
    stmt2='select Activity from todo where UserName=(%s) and TodoStatus=1'
    val2=(name,)
    cursor=mydb.cursor()
    cursor.execute(stmt2,val2)
    result1=cursor.fetchall()
    cursor.close()
    return render_template('dashboard.html',count=len(result),todo=result,name=name,incomplete=result1,icount=len(result1))

@app.route("/remove/<name>/<item>",methods=["POST"])
def remove(name,item):
    stmt='delete from todo where UserName=(%s) and Activity=(%s)'
    val=(name,item,)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    stmt='select Activity from todo where UserName=(%s) and TodoStatus=0 order by TodoTimeStamp desc'
    val=(name,)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    cursor.close()
    stmt='select Activity from todo where UserName=(%s) and TodoStatus=1 order by TodoTimeStamp desc'
    val=(name,)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    result1=cursor.fetchall()
    cursor.close()
    return render_template('dashboard.html',count=len(result),todo=result,name=name,incomplete=result1,icount=len(result1))
    # display(name)


def display(name):
    stmt='select Activity from todo where UserName=(%s) and TodoStatus=0 order by TodoTimeStamp desc'
    val=(name,)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    cursor.close()
    stmt='select Activity from todo where UserName=(%s) and TodoStatus=1 order by TodoTimeStamp desc'
    val=(name,)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    result1=cursor.fetchall()
    cursor.close()
    return render_template('dashboard.html',count=len(result),todo=result,name=name,incomplete=result1,icount=len(result1))

app.run()
