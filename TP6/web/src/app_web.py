import json
import os

import flask
import flask_wtf.csrf as csrf
import pynats

app = flask.Flask(__name__)
app.config['SECRET_KEY'] = '08ead3fa939edb04acca31e043d63a0636deb946e5addc396a65f8ef4126d0b4'
csrf.CSRFProtect(app)

ACCOUNTS = ['59229', '94641', '44702', '93375']
NATS_HOST = os.getenv("NATS_HOST", "10.1.33.57")


@app.route('/')
def home():
    """Affichage de toutes les tâches"""
    return flask.render_template('home.html', accounts=ACCOUNTS)

@app.route("/envoi", methods=["POST"])
def envoi():
    data = dict(flask.request.form)
    flask.flash("Dépôt demandé")

    with pynats.NATSClient(f"nats://{NATS_HOST}:4222") as client:
        client.connect()
        client.publish(
            subject=f"bank.deposit.{data.get('account')}",
            payload=json.dumps({key: data[key] for key in ["account", "amount"]}).encode("utf-8"))

    return flask.redirect(flask.url_for("home"))

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
