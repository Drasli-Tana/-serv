import flask
from flask_wtf.csrf import CSRFProtect

import service

app = flask.Flask(__name__)
app.config['SECRET_KEY'] = '08ead3fa939edb04acca31e043d63a0636deb946e5addc396a65f8ef4126d0b4'
CSRFProtect(app)


@app.route('/')
def home():
    """Affichage de toutes les tâches"""
    return flask.render_template('home.html', tasks=service.get_tasks())


@app.route('/del/<task_id>', methods=['GET', 'POST'])
def task_del(task_id):
    """Suppression de la tâche dont l'identifiant est fournie dans l'URL paramètrée"""
    if flask.request.method == 'GET':
        return flask.render_template('task_del.html', task_id=task_id)
    else:  # request.method == 'POST'
        if not service.delete_task(task_id):
            app.logger.error(f"La tâche '{task_id}' n'existe pas")
            flask.flash(f"La tâche '{task_id}' n'existe pas")
        return flask.redirect(flask.url_for('home'))


@app.route('/add', methods=['GET', 'POST'])
def task_add():
    """Ajout d'une tâche dont la description est fournie dans le corps de la requête"""
    if flask.request.method == 'GET':
        return flask.render_template('task_add.html')
    else:  # request.method == 'POST'
        task = {
            'description': flask.request.form.get('description')
        }
        service.add_task(task)
        return flask.redirect(flask.url_for('home'))


@app.route('/edit/<task_id>')
def task_edit(task_id):
    """Affichage d'une tâche"""
    task = service.get_task(task_id)
    if task is None:
        flask.flash(f"Impossible d'éditer {task_id} : tâche inexistant")
        return flask.redirect(flask.url_for('home'))
    return flask.render_template('task_edit.html', task=task)


@app.route('/update/<task_id>', methods=['POST'])
def task_update(task_id):
    """Mise à jour d'une tâche"""
    task = {
        'id': task_id,
        'description': flask.request.form.get('description'),
    }
    ajour = service.update_task(task)
    if not ajour:
        flask.flash(f"Erreur dans la mise à jour de la tache {task_id}")
    else:
        flask.flash(f"Mise à jour de la tache {task_id} effectuée")
    return flask.redirect(flask.url_for('home'))


if __name__ == '__main__':
    app.run(debug=True, port=5001)
