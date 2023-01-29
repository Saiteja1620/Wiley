from flask import *
app=Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")


@app.route("/services")
def services():
    return render_template('services.html')

@app.route("/contact")
def contact():
    return render_template('contact.html')


@app.route("/profile/<name>")
def getProfile(name):
    return render_template('profile.html',userName=name)




app.run()