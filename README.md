## 1. Create a Self-Hosted Agent on your machine 
In Azure DevOps:
1. Navigate inside your project and open the tab “Project Settings”
2. Click on the “Agent pools” tab
3. Add pool
4. Select “Self-hosted”, give a name and create it.
5. Navigate into the new Agent Pool and click “New agent”
6. Select “Linux” and copy the “Download the agent” link.

You need also to create a PAT (Personal Access Token) in order to be able to authenticate the VM. To do so:
1. In the Azure DevOps portal, click on the “User settings” (the icon in the top right corner)
2. Select “Personal Access Token”
3. Create a new token with the Full access” permission. Copy the value of the token, it will be needed in the next step.

On your machine:
1. Create the agent
```mkdir myagent && cd myagent```
 ```tar zxvf ~/Downloads/vsts-agent-linux-x64-3.220.0.tar.gz```
2. Configure the agent
```./config.sh```
3. It will prompt you asking the DevOps Server URL, that is: https://dev.azure.com/<organization name>.
4. After that it will ask you the authentication key, paste here you PAT token.
5. Finally insert the name of the agent pool created in the previous step and a name for the new agent.
6. Complete the installation running the following command:
```./run.sh```

SOURCE: https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser#install


# 2. Create pipeline
Sign in Azure DevOps:
1. Install Terraform Tasks plugin for Azure Pipelines https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform
2. Create new project
    Pipleines -> Pipelines -> Create pipeline -> Github -> Give access to repo
     Existing Azure Pipelines YAML file
Crear Service Connection a Github
     Agregar variable para GitPassword
   ??? Repos-> Import (You'll need to use an Access Token) 

1. Create Bucket on AWS for tfstate storage.




ESCONDER LLAVES
MANDAR BACKEND A BUCKET

GITIGNORE
DOCKER BEST PRACTICES
TF BEST PRACTICES
12 FACTOR APP


Link de infra de la foto:
https://mylearn.oracle.com/ou/component/-/108432/165507
