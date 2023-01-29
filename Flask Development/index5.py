# looping in html

from flask import *
app=Flask(__name__)


@app.route("/")
def home():
    lang=['cSharp','java','Python','Ruby','Perl']
    return render_template('index5.html',languages=lang)

app.run()