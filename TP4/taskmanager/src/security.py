#import secrets

API_KEY = "5ac3a5ba0a4b364d6638be6fd1c30eeef26e07ddf72922fcb8f29b30b2973391"
# secrets.token_hex(32)

def check_api_key(headers):
    return headers.get("X-API-KEY", "SovietUnion") == API_KEY
