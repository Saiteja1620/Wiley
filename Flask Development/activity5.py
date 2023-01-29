import ast
from re import A
from flask import *
app=Flask(__name__)

@app.route("/")
def home():
    json={
            "users": [
        {
            "userId": 1,
            "firstName": "Krish",
            "lastName": "Lee",
            "phoneNumber": "123456",
            "emailAddress": "krish.lee@learningcontainer.com"
        },
        {
            "userId": 2,
            "firstName": "racks",
            "lastName": "jacson",
            "phoneNumber": "123456",
            "emailAddress": "racks.jacson@learningcontainer.com"
        },
        {
            "userId": 3,
            "firstName": "denial",
            "lastName": "roast",
            "phoneNumber": "33333333",
            "emailAddress": "denial.roast@learningcontainer.com"
        },
        {
            "userId": 4,
            "firstName": "devid",
            "lastName": "neo",
            "phoneNumber": "222222222",
            "emailAddress": "devid.neo@learningcontainer.com"
        },
        {
            "userId": 5,
            "firstName": "jone",
            "lastName": "mac",
            "phoneNumber": "111111111",
            "emailAddress": "jone.mac@learningcontainer.com"
        }
        ]
    }   
    mylist=json['users']

    return render_template('activity4.html',answer=mylist)
@app.route("/report")
def getReport():
    empData= open('/Users/nomul/OneDrive/Desktop/employees.txt').read()
    empRecords=ast.literal_eval(empData)
    return render_template('activity5.html',employees=empRecords['users'])

app.run()