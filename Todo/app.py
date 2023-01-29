from flask import *
app=Flask(__name__)

todos=['IFM','ITIL','SQL','PYTHON','CLOUD','AGILE','SDLC','LINUX']

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
    details=''
    for i in data:
        details+=data[i]+','
    with open('c:/Users/nomul/OneDrive/Desktop/registrationDetails.txt','a') as myfile:
        myfile.write(str(details[:-1])+'\n')
    return render_template('login.html')

@app.route('/verifyLogin',methods=["POST"])
def verify():
    data=dict(request.form)
    with open('c:/Users/nomul/OneDrive/Desktop/registrationDetails.txt','r') as myfile:
        user_data=myfile.readlines()
        for i in user_data:
            user=i.split(',')
            fullName=user[0]
            userName=user[1]
            password=user[2][:-1]
            if(data['userName']==userName and data['password']==password):
                # with open("C:/Users/nomul/OneDrive/Desktop/todos.txt",'r+') as myfile:
                #     data=myfile.read()
                #     data=data.split(',')
                #     print(data)
                return render_template('dashboard.html',name=fullName,count=len(todos),todo=todos)
        else:
            return render_template('error.html')

@app.route("/add",methods=["POST"])
def add():
    item=dict(request.form)
    print(item)
    todos.append(item['item'])
    # with open("C:/Users/nomul/OneDrive/Desktop/todos.txt",'r+') as myfile:
    #     myfile.write(item['item']+',')
    return render_template('dashboard.html',count=len(todos),todo=todos[::-1])


@app.route("/remove/<index>",methods=["POST"])
def remove(index):
    todos.remove(todos[int(index)])
    return render_template('dashboard.html',count=len(todos),todo=todos)


app.run()
