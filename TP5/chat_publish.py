import pynats
import re

NATS_HOST = "10.1.33.57"


def send_chat_message(msg):
    send_chat_group_message("all", msg)


def send_chat_group_message(group: str, msg):
    valide = re.match("^B(\d)G(\d|\w)$", group)
    with pynats.NATSClient(f"nats://{NATS_HOST}:4222") as client:
        client.connect()
        if group == "all":
            subject = "chat"
        elif group.upper().startswith("BUT"):
            subject = f"chat.{group.upper()}"
        elif valide: # si group vérifie l'expression régulière
            (annee, groupe) = valide.groups()
            subject = f"chat.BUT{annee}.{group.upper()}"

        client.publish(subject=subject, payload=msg.encode("utf-8"))


if __name__ == "__main__":
    send_chat_message("Travaille, Alan")
    send_chat_group_message("B2GA", "42")
