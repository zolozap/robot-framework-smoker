from robot.api.deco import keyword
import random
import string

@keyword
def generate_random_text(length):
    characters = string.ascii_letters
    return ''.join(random.choice(characters) for _ in range(int(length)))
