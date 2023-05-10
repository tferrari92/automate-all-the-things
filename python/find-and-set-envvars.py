import json
import os

script_path = os.path.abspath(__file__)
json_path = os.path.dirname(os.path.dirname(script_path)) + "/info.json"

os.environ["AATT_HOLA"] = "CHAU"


def set_environment_variables_from_json(json_path):
    with open(json_path, 'r') as file:
        data = json.load(file)
        
        for key, value in data.items():
            os.environ[key] = value

# json_path = 'info.json'
print("Setting environment variables from " + json_path)
set_environment_variables_from_json(json_path)
