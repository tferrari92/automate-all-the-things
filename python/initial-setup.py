import sys
import time
import os

# Get the absolute path of the script
script_path = os.path.abspath(__file__)
root_dir_path = os.path.dirname(os.path.dirname(script_path))

# Function to print text gradually
def print_gradually(text):
    for char in text:
        print(char, end='', flush=True)
        time.sleep(0.05)  

# Prompt the user for their full name character by character
print_gradually("Please enter your full name: ")
full_name = input()

# Extract the first name from the full name
first_name = full_name.split()[0]


# Prompt the user for their favorite food, addressing them by their first name
# print_gradually("Thank you, " + first_name + "! Welcome to Automate All The Things! Are you exited?: ")
# favorite_food = input()


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
message = "Thank you, " + first_name + "! Welcome to Automate All The Things! Are you exited?"
options = ['Yes', 'YEEEAAAAHHHHHH!!!!!']

# Prompt the user and get their choice
user_choice = prompt_with_options(message, options)

# Process the user's choice
if user_choice == 'Yes':
    print_gradually("That's great! I appreciate your excitement!\n")
else:
    print_gradually("WOOOOHOOOOOOOO!!!! DAMN RIGHT!!\n")


print_gradually("Alright, let's get the necessary details. What will be the name of your app?: ")
app_name = input()


print_gradually("Great name! I'm gonna need you to get your aws key?: ")
app_name = input()



print_gradually("That's it! All the info you provided has been saved in an 'info.json' file on root directory.\nDon't worry, this file is specified in the .gitignore so it won't be pushed if you decide to upload this.\nIf you need to modify any of this info, you can just edit the info.json file.\nHAPPY AUTOMATING!!!")

# # Save the variables in a new file
output_file = root_dir_path + "/info.json"
with open(output_file, "w") as file:
    file.write("Full Name: " + full_name + "\n")
    file.write("Script Path: " + script_path + "\n")

# Print the entered name and the script's absolute path
# print("\nYour full name is:", full_name)
# print("\nYour app name is:", app_name)
# print("Rootdir  path:", root_dir_path)
# print("Variables saved in:", output_file)
