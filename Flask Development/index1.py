from flask import Flask
app=Flask(__name__)


#passing parameters to the function from the url  
@app.route("/emp/<name>")
def sayHello(name):
    return "Hello "+name

app.run()