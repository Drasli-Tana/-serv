import jwt
from authlib.integrations.requests_client import OAuth2Session

API_KEY = "5ac3a5ba0a4b364d6638be6fd1c30eeef26e07ddf72922fcb8f29b30b2973391"
# secrets.token_hex(32)

def check_api_key(headers):
    return headers.get("X-API-KEY", "SovietUnion") == API_KEY


def check_jwt(right, header):
    acc_token_dec = jwt.decode(header.get("Authorization").split(" ")[1], options={"verify_signature": False})


    CLIENT_ID = "tp4"
    CLIENT_SECRET = "171da615-dc31-43d7-9c76-5d0f15bb2b4f"
    session = OAuth2Session(CLIENT_ID, CLIENT_SECRET)
    token = session.fetch_token( "http://10.1.33.57:8888/auth/realms/r4dc10/protocol/openid-connect/token", username='bob', password='toto')
