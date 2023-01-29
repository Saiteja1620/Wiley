from flask import *

app=Flask(__name__)

@app.route("/decode/<string>")
def printTable(string):
    answer='''
    <html>
        <body>
            <table border='1'>
                <th>Key</th>
                <th>Ascii Value</th>
    '''
    for i in string:
        answer+='<tr><td>'+str(i)+'</td><td>'+str(ord(i))+'</td></tr>'
    answer+='''
    </table>
    </body>
    </html>
    '''
    return render_template('index4.html',answer=answer)
app.run()