import yaml

# Load data from external file
with open('/home/vsts/work/1/s/python/kubeconfig-data', 'r') as f:
    data = yaml.safe_load(f)

# Create kubeconfig dictionary
kubeconfig = {
    'apiVersion': 'v1',
    'kind': 'Config',
    'current-context': data['current-context'],
    'clusters': [
        {
            'cluster': {
                'certificate-authority-data': data['clusters'][0]['cluster']['certificate-authority-data'],
                'server': data['clusters'][0]['cluster']['server']
            },
            'name': data['clusters'][0]['name']
        }
    ],
    'contexts': [
        {
            'context': {
                'cluster': data['contexts'][0]['context']['cluster'],
                'user': data['contexts'][0]['context']['user']
            },
            'name': data['contexts'][0]['name']
        }
    ],
    'users': [
        {
            'name': data['users'][0]['name'],
            'user': {
                'token': data['users'][0]['user']['token']
            }
        }
    ]
}

# Write kubeconfig to file
with open('kubeconfig.yaml', 'w') as f:
    yaml.safe_dump(kubeconfig, f)
