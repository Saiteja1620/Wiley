from flask import Flask

app=Flask(__name__)

@app.route("/")
def home():
    return "<h1>This is my first code</h1>"
@app.route("/about")
def aboutUs():
    return "<h3>Hi! this is dragon master<h3>"

@app.route("/services")
def services():
    return "<h3>This is my first service...<hr>Feel free to contact us for any help</h3>"

@app.route("/save")
def writeInFile():
    with open("C:/Users/nomul/OneDrive/Desktop/test.txt",'w') as myfile:
        myfile.write("content is written using flask")
    return 'file saved successfully'

with open("C:/Users/nomul/OneDrive/Desktop/akka.txt") as f:
    print(f.read())
app.run()