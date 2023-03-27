import json

import requests

URL = "http://127.0.0.1:5000"


def get_tasks():
    """
    Récupère (toute) la liste des tâches.

    :return: la liste des tâches au format :

        [
          {
            "id": "tache-1",
            "description": "Preparer le TP microservices"
          },
          {
            "id": "tache-2",
            "description": "Preparer l'examen du module microservices"
          }
        ]

    """
    return requests.get(f"{URL}/tasks").json()


def get_task(task_id):
    """
    Récupère la tâche identifiée par `task_id`.

    :param task_id: l'identifiant de la tâche (par exemple `tache-1`)
    :return: la tâche au format

          {
            "id": "tache-2",
            "description": "Preparer l'examen du module microservices"
          }

          ou `None` si la tâche n'existe pas
    """
    r = requests.get(f"{URL}/tasks/{task_id}")
    return r.json() if r.status_code == 200 else None

def delete_task(task_id):
    """
    Supprime la tâche identifiée par task_id.

    :param task_id: l'identifiant de la tâche (par exemple `tache-1`)
    :return: True si la tâche a été supprimée
    """
    return requests.delete(f"{URL}/tasks/{task_id}").status_code == 200

def update_task(task):
    """
    Met à jour la tâche donnée en paramètre.

    :param task: la tâche au format

          {
            "id": "tache-2",
            "description": "Preparer l'examen du module microservices"
          }

    :return: `True` si la tâche a été mise à jour, `False` sinon
    """
    return requests.put(f"{URL}/tasks/{task['id']}", data=json.dumps(task), headers={"Content-Type": "application/json"}).status_code==200

def add_task(task):
    """
    Met à jour la tâche donnée en paramètre.

    :param task: la tâche au format

          {
            "description": "Preparer l'examen du module microservices"
          }

    :return: True si la tâche a été mise à jour
    """
    return requests.post(f"{URL}/tasks", data=json.dumps(task), headers={"Content-Type": "application/json"}).status_code == 200
