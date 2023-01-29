from urllib import response
from flask import *
app=Flask(__name__)

app.secret_key='abc'

@app.route("/")
def home():
    session['secret']="this is mars one way trip"
    return render_template("forms.html")

@app.route("/register")
def register():
    if 'secret' in session:
        data=session['secret']
    return render_template('register.html',msg=data)


@app.route("/login")
def login():
    if 'secret' in session:
        data=session['secret']
    return render_template('login.html',msg=data)


@app.route("/save",methods=['POST'])
def save():
    print(dict(request.form))
    response=dict(request.form)
    # return 'Data Saved Successfully'
    return render_template('confirmation.html',response=response)

@app.route('/auth',methods=['POST'])
def auth():
    response=dict(request.form)
    if(response['userName']=='admin' and response['password']=='admin123'):
        return render_template('dashboard.html',response=response)
    else:
        return render_template('error.html')
app.run()