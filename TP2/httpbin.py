import json

import requests
import pprint

r = requests.get('http://httpbin.org/get')
print("Code de retour", r.status_code)
print("Headers:")
pprint.pprint(r.headers)
contenu = r.json()
print("Contenu json")
pprint.pprint(contenu)

payload = {'some': 'data'}
chaine = json.dumps(payload)
r = requests.post('http://httpbin.org/post', data=chaine, headers={"Content-Type": "application/json"})
print("Code de retour", r.status_code)
print("Headers:")
pprint.pprint(r.headers)

contenu = r.json()
print("Contenu json")
pprint.pprint(contenu)