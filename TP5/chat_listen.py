import pynats
import re


# Subscribe
def callback(msg):
    print(f"Message reçu de {msg.subject}:\n{msg.payload.decode('utf-8')}")

def wait_chat_group_message(group):
    with pynats.NATSClient("nats://10.1.33.57:4222") as client:
        # Connect
        client.connect()
        valide = re.match("^B(\d)G(\d|\w)$", group)
        if valide:
            (annee, groupe) = valide.groups()
            subject = f"chat.BUT{annee}"
        # Subscribe to a subject with the callback called when a message is received
        client.subscribe(subject="chat", callback=callback)
        client.subscribe(subject=subject, callback=callback)
        client.subscribe(subject=f"{subject}.{group.upper()}", callback=callback)

        # wait for 1 message
        client.wait(count=10)


if __name__ == "__main__":
    wait_chat_group_message("B2GA")
