import json
import os

import requests

URL = os.environ.get("TASKSMANAGER_URL", "http://127.0.0.1:5000")
API_KEY = "5ac3a5ba0a4b364d6638be6fd1c30eeef26e07ddf72922fcb8f29b30b2973391"


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
    r = requests.get(f"{URL}/tasks", headers={"X-API-KEY": API_KEY})
    return r.json() if r.status_code == 200 else dict()


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
    r = requests.get(f"{URL}/tasks/{task_id}", headers={"X-API-KEY": API_KEY})
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
    return requests.put(f"{URL}/tasks/{task['id']}", data=json.dumps(task), headers={"Content-Type": "application/json"}).status_code == 200

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
