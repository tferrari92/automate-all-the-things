import base64
import json

# Load the JSON input from a file
with open('outputs.json', 'r') as f:
    input_json = f.read()
input_dict = json.loads(input_json)

# Extract the values from the input dictionary
cluster_ca_cert = input_dict['cluster_ca_certificate']['value']
cluster_endpoint = input_dict['cluster_endpoint']['value']
cluster_name = input_dict['cluster_name']['value']

# Generate the kubeconfig YAML string
kubeconfig = f'''apiVersion: v1
kind: Config
clusters:
- name: {cluster_name}
  cluster:
    certificate-authority-data: {cluster_ca_cert}
    server: {cluster_endpoint}
contexts:
- name: {cluster_name}-context
  context:
    cluster: {cluster_name}
    user: default
users:
- name: default
  user:
    token:
current-context: {cluster_name}-context
'''

# Write the kubeconfig to a file
with open('kubeconfig.yaml', 'w') as f:
    f.write(kubeconfig)
