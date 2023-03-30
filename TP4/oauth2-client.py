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

    acc_token = token["access_token"]
    print("Jeton JWT d'acces:")
    print(acc_token)
    print()

    acc_token_dec = jwt.decode(acc_token, options={"verify_signature": False})
    pprint.pprint(acc_token_dec)
