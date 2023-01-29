from flask import *
app=Flask(__name__)

@app.route("/")
def home():
    lang=['CSharp','Java','Python','Ruby','Perl']
    return render_template('index6.html',languages=lang)
app.run()