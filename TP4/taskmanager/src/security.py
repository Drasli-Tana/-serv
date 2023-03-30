import jwt

API_KEY = "5ac3a5ba0a4b364d6638be6fd1c30eeef26e07ddf72922fcb8f29b30b2973391"

def check_api_key(headers):
    return headers.get("X-API-KEY", "SovietUnion") == API_KEY


def check_jwt(right, header):
    return right in jwt.decode(header.get("Authorization").split(" ")[1], options={"verify_signature": False}).get('resource_access', dict()).get('tp4', dict()).get("roles", list()) if "Authorization" in header else False