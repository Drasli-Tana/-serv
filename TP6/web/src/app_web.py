import json

import flask
import pynats

app = flask.Flask(__name__)

ACCOUNTS = ['59229', '94641', '44702', '93375']
NATS_HOST = "nats://10.1.33.57:4222"


@app.route('/')
def home():
    """Affichage de toutes les tâches"""
    return flask.render_template('home.html', accounts=ACCOUNTS)

@app.route("/envoi", methods=["POST"])
def envoi():
    data = dict(flask.request.form)

    with pynats.NATSClient(NATS_HOST) as client:
        client.connect()
        client.publish(
            subject=f"bank.deposit.{data.get('account')}",
            payload=json.dumps(data).encode("utf-8"))

    return flask.redirect(flask.url_for("home"))

if __name__ == '__main__':
    app.run(debug=True, port=5000)
