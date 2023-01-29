import ast
import requests
response=requests.get('https://dog-api.kinduff.com/api/facts')
from flask import *
app=Flask(__name__)

answer=response.json()
print(type(answer))
@app.route("/")
def facts():
    return render_template("facts.html",answer=answer)


app.run()