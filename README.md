
<br/>

<p align="center"> <img width="460" src="https://i.imgur.com/CnDPSpV.png"> </p>

<br/>



<br/>
<p align="center"> <img width="460" src="https://i.imgur.com/xSmJv0k.png"> </p>
<br/>



CREAR ORGANIZACION DE 0!!!!!!!!!!!!!!!!!https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops

# (Optional) CREATE A SELF HOSTED-AGENT ON YOUR MACHINE
***If you have Free Parallelism or a paid Azure subscription, skip this step.***<br/>

If you don't have Free Parallelism activated on Azure DevOps, or don't have paid Azure subscriptions, you will have to run the pipeline in a self-hosted agent. 
This means you'll install an Azure DevOps Agent on your local machine, which will recieve and execute the pipeline jobs.

## In Azure DevOps:

1. Navigate inside your project and open the tab “Project Settings”

2. Click on the “Agent pools” tab

3. Add pool

4. Select “Self-hosted”, give a name and create it.

5. Navigate into the new Agent Pool and click “New agent”

6. Select “Linux” and copy the “Download the agent” link.

<br/>

You need also to create a PAT (Personal Access Token) in order to be able to authenticate the VM. To do so:
1. In the Azure DevOps portal, click on the “User settings” (the icon in the top right corner)

2. Select “Personal Access Token”

3. Create a new token with the Full access” permission. Copy the value of the token, it will be needed in the next step.

<br/>

## On your machine:
1. Create the agent
```bash
mkdir myagent && cd myagent
tar zxvf ~/Downloads/vsts-agent-linux-x64-3.220.0.tar.gz
```

2. Configure the agent
```bash
./config.sh
```

3. It will prompt you asking the DevOps Server URL, that is: https://dev.azure.com/<organization-name>.

4. After that it will ask you the authentication key, paste here you PAT token.

5. Finally insert the name of the agent pool created in the previous step and a name for the new agent.

6. Complete the installation running the following command:
```bash
./run.sh
```

  
[SOURCE](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser#install)


# CREATE PIPELINE

Sign in Azure DevOps:

1. Install [Terraform Tasks plugin]( https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform) for Azure Pipelines

2. Create new project

3. Create pipelie: Pipelines -> Pipelines -> Create pipeline -> Github -> Give access to repo -> Existing Azure Pipelines YAML file

4. Crear Service Connection a Github EXPLICAR!!!

5. Agregar variable para GitPassword: Variables -> New variable -> Name: GitPassword, Value: 

   ??? Repos-> Import (You'll need to use an Access Token)

6. Might ask you for permission, go to Job and click permit

  

1. Create Bucket on AWS for tfstate storage.

  
  
  
  

ESCONDER LLAVES

MANDAR BACKEND A BUCKET

CAMBIAR KEYS DE AWS PORQ YA ESTAN EN GITHUB!!!
  

GITIGNORE

DOCKER BEST PRACTICES

TF BEST PRACTICES

12 FACTOR APP
PASAR TODO A PYTHON SCRIPT

  
  

Link de infra de la foto:

https://mylearn.oracle.com/ou/component/-/108432/165507
<p align="center"> <img width="460" src="https://i.imgur.com/dz0RdX5.png"> </p>



DESCARTADO

# (Optional) GET GITHUB PERSONAL ACCESS TOKEN
***If the repo you are using is public skip this step.***<br/>

In your Github account:
1. In the upper-right corner of any page, click your profile photo, then click Settings.
2. In the left sidebar, click  Developer settings.
3. In the left sidebar, click Personal access tokens.
4. Click Generate new token.
5. In the "Note" field, give your token a descriptive name.
6. To give your token an expiration, select Expiration, then choose a default option or click Custom to enter a date.
7. Select the scopes you'd like to grant this token. To use your token to access repositories from the command line, select repo. A token with no assigned scopes can only access public information. For more information, see "Scopes for OAuth Apps".
8. Click Generate token.
9. Copy the new token to your clipboard, click.

Set as environment variable
```bash
export AZURE_DEVOPS_EXT_GITHUB_PAT=<your-github-pat>
```

# 1. CREATE PIPELINE

## 1.1 Azure CLI

a. Install [azure cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
```bash
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

b. Sign in:
```bash
az login 
```

## 1.2 Azure DevOps CLI 

a. Add the [Azure DevOps extension](https://learn.microsoft.com/en-us/azure/devops/cli/?view=azure-devops)

```bash
az extension add --name azure-devops
```


## 1.3 Project & Pipeline 
a. Create project
```bash
az devops project create --name automate-all-the-things --org https://dev.azure.com/tomasferrari --verbose
```

b. Set organization and project as defaults
```bash
az devops configure --defaults  organization=https://dev.azure.com/tomasferrari project=automate-all-the-things 
```

c. Create service-connection to github
```bash
az devops service-endpoint github create --name github-sc --github-url https://github.com/tferrari92/automate-all-the-things.git
```

d. Create pipeline
```bash
az pipelines create --name create-bucket --repository https://github.com/tferrari92/automate-all-the-things.git --branch main --yml-path azure-devops/deploy-aws-resources.yml --service-connection github-sc
```

<br/>
<p align="center"> <img width="460" src="https://i.imgur.com/E0s8TW6.png"> </p>
<br/>