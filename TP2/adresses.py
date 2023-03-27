import urllib.parse as parse

import requests


def recherche_adresse(adresse: str, code_postal: str):
    request = requests.get(
        "https://api-adresse.data.gouv.fr/search/",
        params={"q": parse.quote_plus(" ".join([adresse, code_postal]))})

    if request.status_code == 200:
        r = requests.get(
            f"https://geo.api.gouv.fr/communes/{request.json()['features'][0]['properties']['citycode']}",
            params={"fields": "population"}
        )

        return [
            request.json()['features'][0]['geometry']['coordinates'],
            request.json()['features'][0]['properties']['city'],
            r.json()['population'] if r.status_code == 200 else 0]


print(recherche_adresse("151 rue de la papeterie", "38610"))
