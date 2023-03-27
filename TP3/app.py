import flask
import flask_restx

app = flask.Flask(__name__)
api = flask_restx.Api(app=app)

@api.route('/hello')
class Hello(flask_restx.Resource):
    """Ressource hello"""
    def get(self):
        """Réponse aux requêtes HTTP GET"""
        return {
            "message": "Hello world!"
        }, 200
@api.route('/hello2/<string:name>')
class Hello2(flask_restx.Resource):
    """Ressource hello2"""

    def get(self, name):
        """Réponse aux requêtes HTTP GET s'adaptant au `name` fournie dans la requête"""
        return {
            "message": f"Hello {name}"
        }, 200

@api.route('/sayhello')
class SayHello(flask_restx.Resource):
    def post(self):
        h = flask.request.headers['Content-Type']
        if h == 'application/json':
            json_data = flask.request.get_json()
            msg = json_data.get("message")
            print(msg)

        elif h == 'text/plain':
            print(flask.request.data.decode("utf-8"))

        else:
            flask_restx.abort(406, "Format incorrect")


if __name__ == '__main__':
    app.run(debug=True, port=5000)