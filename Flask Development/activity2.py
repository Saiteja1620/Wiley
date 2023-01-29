from flask import *
app=Flask(__name__)

@app.route('/filter/<string>')
def print(string):
    result=[]
    for i in str(string):
        if(i.isdigit()):
            result.append(i)
    result=result[::-1]
    result='<br>'.join(result)
    return render_template('raw.html',answer=result)

app.run()