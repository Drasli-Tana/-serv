import json

import requests

request = requests.post(
    "http://127.0.0.1:5000/sayhello",
    data=json.dumps({"message": "This doesn't work"}),
    headers={"Content-Type": "text/plain"})
print(request.headers)