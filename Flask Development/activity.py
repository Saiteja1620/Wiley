from flask import *
app=Flask(__name__)

@app.route('/get/<file_name>')
def display(file_name):
    # with open('C:/Users/nomul/OneDrive/Desktop/'+file_name,'r') as myfile:
    with open(file_name,'r') as myfile:
        data=myfile.readlines()
        result=''
        for i in data:
            result+=i
            result+='<br>'
    return 'content of the file is '+ result
app.run()