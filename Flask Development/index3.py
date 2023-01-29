# dynamic routes using flask

from flask import *
app=Flask(__name__)

@app.route("/Sales")
def salesTeam():
    return "<h3>Welcome to Sales Team</h3>"

@app.route("/finance")
def financeTeam():
    return "<h3>Welcome to Finance Team</h3>"


@app.route("/product")
def productTeam():
    return "<h3>Welcome to Product Team</h3>"

@app.route("/select/<team>")
def sendTo(team):
    if team=='sales':
        return redirect(url_for('salesTeam'))
    elif team=='finance':
        return redirect(url_for("financeTeam"))
    elif team=='product':
        return redirect(url_for("productTeam"))
    else:
        return "<h3 style='color:red'>Invalid Team</h3>"
@app.route("/htmlPage")
def display():
    answer='''
                <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
            </head>
            <body>
                <table border="1">
                    <th>Header 1</th>
                    <th>Header 2</th>
                    <tr>
                        <td>First </td>
                        <td>Second </td>
                    </tr>
                    <tr>
                        <td>Third </td>
                        <td>
                            Fourth
                        </td>
                    </tr>
                    <tr>
                        <td>Fifith</td>
                    </tr>
                </table>
            </body>
            </html>
    '''
    return render_template('index4.html',answer=answer)
app.run()