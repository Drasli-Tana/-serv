import flask
import flask_restx

import security

TACHES = {
    "tache-1": "Préparer le TP microservices",
    "tache-2": "Préparer l'examen du module microservices"
}

app = flask.Flask(__name__)
api = flask_restx.Api(app=app)


def generation_tache_id():
    tache_id = int(max(TACHES.keys()).lstrip('tache-')) + 1
    return f"tache-{tache_id}"


@api.route('/tasks')
class Tasks(flask_restx.Resource):
    def get(self):
        """Réponse aux requêtes HTTP GET s'adaptant au `name` fournie dans la requête"""
        if not security.check_api_key(flask.request.headers):
            flask_restx.abort(403, "Forbidden")
        return [{"id": tache, "description": TACHES[tache]} for tache in TACHES], 200

    def post(self):
        if flask.request.headers['Content-Type'] == 'application/json':
            tid = generation_tache_id()
            TACHES[tid] = flask.request.get_json().get("description")

            return {"task": tid}, 201

        else:
            flask_restx.abort(406, "Format incorrect")


@api.route('/tasks/<tid>')
class Task(flask_restx.Resource):
    def get(self, tid):
        """Réponse aux requêtes HTTP GET s'adaptant au `name` fournie dans la requête"""
        if not security.check_api_key(flask.request.headers):
            flask_restx.abort(403, message="Forbidden")

        if tid not in TACHES:
            flask_restx.abort(404, message="Task not found")
        return {"id": tid, "description": TACHES[tid]}, 200


    def delete(self, tid):
        if tid not in TACHES:
            flask_restx.abort(404, message="Tache n'existe pas")

        del TACHES[tid]
        return {"message": "La tâche '<tid>' a été supprimée"}, 200

    def put(self, tid):
        if tid not in TACHES:
            flask_restx.abort(404, "Not found")

        elif flask.request.headers['Content-Type'] == 'application/json':
            TACHES[tid] = flask.request.get_json().get("description", TACHES[tid])
            return {"message": f"La tâche {tid} a été mise à jour"}, 200

        else:
            flask_restx.abort(406, "Format incorrect")


if __name__ == '__main__':
    app.run(debug=True, port=5000)
