import pprint

import jwt
from authlib.integrations.requests_client import OAuth2Session

CLIENT_ID = "tp4"
CLIENT_SECRET = "171da615-dc31-43d7-9c76-5d0f15bb2b4f"
TOKEN_ENDPOINT = "http://10.1.33.57:8888/auth/realms/r4dc10/protocol/openid-connect/token"

if __name__ == '__main__':
    session = OAuth2Session(CLIENT_ID, CLIENT_SECRET)
    token = session.fetch_token(TOKEN_ENDPOINT, username='bob', password='toto')

    pprint.pprint(token)
    r = session.get("http://127.0.0.1:5000/tasks",
                    headers={"X-API-KEY": "5ac3a5ba0a4b364d6638be6fd1c30eeef26e07ddf72922fcb8f29b30b2973391"})

    pprint(r.json())
