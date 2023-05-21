import os

script_path = os.path.abspath(__file__)
root_dir_path = os.path.dirname(os.path.dirname(os.path.dirname(script_path)))
values_path = root_dir_path + '/helm/my-app/values.yaml'

def replace_tag(file_path):
    # Create a temporary file for writing
    temp_file_path = file_path + '.tmp'
    with open(file_path, 'r') as input_file, open(temp_file_path, 'w') as output_file:
        for line in input_file:
            # Check if the line starts with 'tag: '
            if line.startswith('  tag:'):
                # Replace the line with 'tag: 2'
                line = '  tag: 2\n'
            # Write the modified line to the temporary file
            output_file.write(line)

    # Replace the original file with the temporary file
    os.replace(temp_file_path, file_path)

# # Specify the file path
# values_path = 'path/to/your/file.txt'

# Call the function to replace the line
replace_tag(values_path)
