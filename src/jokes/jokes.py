from random import choice
from typing import TypedDict

import requests

JOKES_FILE_URL = "https://gist.githubusercontent.com/FrancescoSaverioZuppichini/8e7614da3b156ccaa29d50211b790146/raw/79b00cdaa023903629052426b24cdee7212229c3/jokes.txt"


class Joke(TypedDict):
    preambula: str
    punchline: str


def get_joke() -> Joke:
    res = requests.get(JOKES_FILE_URL)
    content = res.text
    jokes = content.strip().split("\n")
    joke = choice(jokes)
    joke_splitted = joke.split("<>")
    return Joke(preambula=joke_splitted[0], punchline=joke_splitted[1])
