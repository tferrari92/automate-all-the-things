import time
import os


print('''                                                                                             \n                                                                         ▄                          \n      ╒█▄    ,¬▄█AA ▄▄▄ ¬█▄█▄ ██`▀▀█▀¬██▀▀     ▄▄  ▄    ▄      a▄N█▀▀▀█  █ █▀▀▀▀▀                   \n      █"█▄█═ █▌ █  ╒█ -█µ█▀▀█µ███  █. █&       ███▄▐▌   █         █   █▀╘█ ▐▌-                      \n      █▄███▌ █▌ ▀█ ▐█▄▄█"█  ▐▌█-▀ⁿ ▐⌐▐█▄;      ▀ ▀┐▐███,███▀"     █   ▀    ▐█A⌐                     \n      █⌐ └█▀██   ▀ⁿ  ¬¬     `▀└        `     ▀▀▀▀▀▀└`└└└└└`▀▀▀                                      \n                 ▄▄▄▄∩▌ j▌ ╓█  ╒▄,  ▄ ╒█    ▄Æ▄  ╒r                                 ,╓              \n              '▀▀█    █44█ ]█╖ ▐▌▀█ █ ▐▌ ▄▄ ▀▀R▄ █                    ▀█        ╓@╢▒╜               \n                 █    █  ▀  █▒▒▒▌  ▀█ ╘█,█▀▄▄▄▄▀ ▀   ╖               , ▌    ╓╥╢▒▒▒╢`                \n                 '           ╢▒▒▒▒@╖    ¬¬ ▀╢░   e  ╢▒           ╓╢╢╜` ▌,╥╢▒▒▒▒▒▒╜                  \n                             ╙▒▒▒▒▒▒╢╗╖    ║▒▒╖    ║▒▒▒       ╓╢╢▒▒╜,╓▐▒▒▒▒▒▒▒▒╢                    \n                              ║▒▒▒▒▒▒▒▒╢@╖ ║▒▒▒╢╖ j▒▒▒╢    ╓@╢▒▒▒▒▒╢▒▒█▒▒▒▒▒▒▒╜                     \n                               ╢▒▒▒▒▒▒▒▒▒▒╢╢▒▒▒▒▒▒▒▒▒▒▒░╓╢╢▒▒▒▒▒▒▒▒▒▒▒▌▒▒▒▒▒╣                       \n                  .╓           ╙▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀⌠!░░░░▀█▒▒▒▒▒█▀'╙Ñ▒▒▒▒▌▒▒▒▒╜                        \n                    ╙╢╢╗╖       ╙▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒W▄W╧²"╙▀'¬¬▐▌  ` ▒▒▒▒▒▒▒▒╜                         \n                     ▄▄▓@▒▒p╖    ╙▒▒▒▒▒▒▒▒▒▒▒▒▒╩█,     ▄∞M══▄▀▀∞²└▀▒▒▐▒▒▒░                          \n                  ,█╢╣▓▓▓╢█▒▒█▒@╖╖║▒▒▒▒▒▒▒▒▒▒▌⌐  ▐,≈M▀▄▄██████     ╙▒█▒▒░                           \n                 ╒╣▓▓▓▓▀▀█▒╢╢╢▒▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒╗▄∞█▀▄███████████     █▌▒▒                 ,,╓╥╢╜     \n           ▄▄▄▄▄,██▀██     █▒╢╢█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█ "▀████████████     █▒▒╓╖╥@╢╢╢╜     ,╓@╢╢▒║╜`       \n        ▄█▒╢╣╣█▀▒▒▒▒▒█▄, ╙▒▒████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄   ▀██████████▌    ▓▒▒▒▒▒▒╢`  ,╓╥╢╢▒▒▒╢╜`          \n       ▐▒╣╣╢▓╩▓▀▄▒▒▒▒▒█▀▒▒▒╢╢▒█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█    ████████▀L   █╢█▒▒▒╢▒╓╥╢╢▒▒▒▒▒╢╜              \n       ██▄██    ▐▒▒▄▒▄█▒╢╢╢▒█▀╙╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█   ██▀███▀▄▀   █╢╢╢▌▒▒▒▒▒▒▒▒▒▒╢╜                 \n       ▌▒▒╢█    ▐▒▒▒██▓▓█░▒╖╥@@╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▄   "▀▀└`    █▒║╢╢▓▒▒▒▒▒▒▒▒╨`                   \n       ▀▒╢╢╢▒█▓▒▒▒▒▒█╙▀▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█╦▄▄▄▄▄▄▄@▓▒╢╢╢╢╢╢█▒▒▒▒▒╜`                     \n        └▀╣▒▄█▒▒▒▒█▀╖╖╓,▀▓▓█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╢║╢║║╢╢╢╢╢╢╢╢╢╢╫▒▒▒▒╢╢╢╢╢╢╢╢╢╢╢@@@╗╥╖╓,     \n            -└▀▀╙▒▒▒▒▒▒▒▒▒▀▓▓█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢Ñ    \n                 └╢▒▒▒▒▒▒▒▒▒█▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█╣╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╜╜`      \n''')


# Get the absolute path of the script
script_path = os.path.abspath(__file__)
root_dir_path = os.path.dirname(os.path.dirname(os.path.dirname(script_path)))


# Functions to print text gradually
def print_gradually(text):
    for char in text:
        print(char, end='', flush=True)
        time.sleep(0.03)


def print_gradually_fast(text):
    for char in text:
        print(char, end='', flush=True)
        time.sleep(0.005)


# Prompt the user for their full name character by character
print_gradually("Please enter your full name: ")
full_name = input()

# Extract the first name from the full name
first_name = full_name.split()[0]


def prompt_with_options(message, options):
    # Print the message and options
    print_gradually(message + "\n")
    for i, option in enumerate(options):
        print(f"{i+1}. {option}")

    # Keep asking for input until a valid option is chosen
    while True:
        print_gradually("Enter your choice: ")
        choice = input()

        # Validate the input
        if choice.isdigit() and 1 <= int(choice) <= len(options):
            return options[int(choice)-1]

        print("Invalid input. Please enter the number corresponding to your choice.")


# Define the message and options
message = "Thank you, " + first_name + \
    "! Welcome to Automate All The Things! Are you exited?"
options = ['Yes', 'YEEEAAAAHHHHHH!!!!!']

# Prompt the user and get their choice
user_choice = prompt_with_options(message, options)

# Process the user's choice
if user_choice == 'Yes':
    print_gradually("That's great!\n")
else:
    print_gradually("WOOOOHOOOOOOOO!!!! DAMN RIGHT!!\n")


# Function to check that input is only alphanumeric + "-" + "_"
def check_if_valid(input_string):
    while not input_string.replace("-", "").replace("_", "").isalnum():
        print_gradually(
            "This value can only contain alphanumeric characters, hyphens(-) and underscores(_).\nPlease provide a valid name: ")
        input_string = input()
    return input_string


print_gradually(
    "Alright, let's get the necessary details. What will be the name of your app?: ")
app_name = check_if_valid(input())

# print_gradually(
#     "Great name! What's the name of your Azure DevOps Organization?: ")
# az_devops_org = input()

print_gradually(
    "Great name! Sounds professional! What's your GitHub username?: ")
github_username = input()

print_gradually(
    "Got it! In what AWS region will you be deploying your resources? (e.g. 'us-east-2'): ")
aws_region = input()

print_gradually("Good choice! Last thing... What's your DockerHub username?: ")
dockerhub_username = input()

print_gradually("Give me a sec... ")

# Create a dictionary with the variable names and their values
data = {
    # "AATT_FULL_NAME": full_name,
    "AATT_APP_NAME": app_name,
    "AATT_GITHUB_USERNAME": github_username,
    "AATT_AWS_REGION": aws_region,
    "AATT_DOCKERHUB_USERNAME": dockerhub_username,
    # "AATT_AZ_DEVOPS_ORG": az_devops_org,
}


def replace_keys_in_file(file_path, replacements):
    with open(file_path, 'r') as file:
        content = file.read()

    for key, value in replacements.items():
        content = content.replace(key, value)

    with open(file_path, 'w') as file:
        file.write(content)


def search_and_replace(directory, replacements):
    for root, _, files in os.walk(directory):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            if file_name in ['application.yaml',
                             '00-deploy-infra.yml',
                             '01-deploy-argocd.yml',
                             '02-build-and-deploy-app.yml',
                             '03-destroy-all-the-things.yml',
                             'values.yaml',
                             'terraform.tfvars',
                             'provider.tf']:
                replace_keys_in_file(file_path, replacements)


def main():
    # Extract the replacements
    replacements = {key: str(value) for key, value in data.items()}

    # Specify the directory to search
    directory = root_dir_path

    # Search and replace keys in files
    search_and_replace(directory, replacements)


main()


print_gradually(
    "That's it! All necessary files were updated with the info you provided.\nYou can go back to the README and carry on with the guide.\n\n")

print_gradually_fast(" _   _    _    ____  ______   __     _   _   _ _____ ___  __  __    _  _____ ___ _   _  ____ _ _ _ \n| | | |  / \  |  _ \|  _ \ \ / /    / \ | | | |_   _/ _ \|  \/  |  / \|_   _|_ _| \ | |/ ___| | | |\n| |_| | / _ \ | |_) | |_) \ V /    / _ \| | | | | || | | | |\/| | / _ \ | |  | ||  \| | |  _| | | |\n|  _  |/ ___ \|  __/|  __/ | |    / ___ \ |_| | | || |_| | |  | |/ ___ \| |  | || |\  | |_| |_|_|_|\n|_| |_/_/   \_\_|   |_|    |_|   /_/   \_\___/  |_| \___/|_|  |_/_/   \_\_| |___|_| \_|\____(_|_|_)\n\n")
