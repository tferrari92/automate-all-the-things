import os
import json

# Get the absolute path of the script & root directory
script_path = os.path.abspath(__file__)
root_dir_path = os.path.dirname(os.path.dirname(os.path.dirname(script_path)))

def replace_keys_in_file(file_path, replacements):
    with open(file_path, 'r') as file:
        content = file.read()
    
    for key, value in replacements.items():
        content = content.replace(key, value)
    
    with open(file_path, 'w') as file:
        file.write(content)


# def search_and_replace(directory, replacements):
#     for root, _, files in os.walk(directory):
#         for file_name in files:
#             if file_name == 'info.json':
#                 continue  # Skip processing info.json file
#             file_path = os.path.join(root, file_name)
#             replace_keys_in_file(file_path, replacements)

def search_and_replace(directory, replacements):
    for root, _, files in os.walk(directory):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            if file_name in ['application.yaml',
                             'values.yaml',
                             'terraform.tfvars']:
                replace_keys_in_file(file_path, replacements)


def main():
    # Read the JSON file
    with open('info.json', 'r') as json_file:
        data = json.load(json_file)

    # Extract the replacements
    replacements = {key: str(value) for key, value in data.items()}

    # Specify the directory to search
    directory = root_dir_path  

    # Search and replace keys in files
    search_and_replace(directory, replacements)

    print('Replacement completed successfully!')


if __name__ == '__main__':
    main()

