import os

# Set the environment variable
os.environ['MY_VARIABLE'] = 'my_value'

# Access the environment variable
value = os.environ['MY_VARIABLE']
print(value)  # Output: my_value
