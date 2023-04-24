import json
import os

import pynats
import psycopg
import psycopg.rows


# Subscribe
def callback(msg):
    data = json.loads(msg.payload.decode("utf-8"))

    db = psycopg.connect(f"host='{os.getenv('DB_HOST', '10.1.33.57')}' dbname='{os.getenv('DB_NAME', 'tp6')}' user='{os.getenv('DB_USER', 'tp6')}' password='{os.getenv('DB_PASSWORD', 'tp6')}'") 
    cursor = db.cursor()
    try:
        cursor.execute("UPDATE account SET amount = amount + %(amount)s WHERE number = %(number)s", {"number": data["account"], "amount": data["amount"]}) 
    except psycopg.errors.InvalidTextRepresentation:
        pass
    
    else:
        db.commit()
    if cursor.rowcount == 1:
        print(f"Compte {data['account']} mis à jour")
    else:
        print(f"Compte {data['account']} pas mis à jour (n'existe pas)")

def wait_bank_message():
    with pynats.NATSClient("nats://10.1.33.57:4222") as client:
        # Connect
        client.connect()
        # Subscribe to a subject with the callback called when a message is received
        client.subscribe(
            subject="bank.deposit.*", callback=callback)

        client.wait()

if __name__ == "__main__":
    wait_bank_message()
