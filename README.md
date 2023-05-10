
<br/>

<p title="All The Things" align="center"> <img src="https://i.imgur.com/s55uj2b.jpg"> </p>

<a href="https://www.instagram.com/ttomasferrari/">
    <img align="right" alt="Abhishek's Instagram" width="22px" src="https://raw.githubusercontent.com/hussainweb/hussainweb/main/icons/instagram.png" />
</a>
<a href="https://twitter.com/tomasferrari">
    <img align="right" alt="Abhishek Naidu | Twitter" width="22px" src="https://raw.githubusercontent.com/peterthehan/peterthehan/master/assets/twitter.svg" />
</a>
<a href="https://www.linkedin.com/in/tomas-ferrari-devops/">
    <img align="right" alt="Abhishek's LinkedIN" width="22px" src="https://raw.githubusercontent.com/peterthehan/peterthehan/master/assets/linkedin.svg" />
</a>
<p align="right">
    <a  href="/docs/readme_es.md">Versión en Español</a>
</p>

# **INDEX**

-   [Introduction](#introduction)
    -   [Prerequisites](#prerequisites)
    -   [What we'll be doing](#what-well-be-doing)
    -   [Tools we'll be using](#tools-well-be-using)
    -   [Disclaimer](#disclaimer)
-   [Create Azure Account & Organization](#CREATE-AZURE-ACCOUNT-&-ORGANIZATION)
-   [Create a Self-Hosted Agent On Your Machine](#create-a-self-hosted-agent-on-your-machine-optional)
-   [Wakatime Week Stats](#wakatime-week-stats)
-   [Themes](#themes)
-   [Customization](#customization)
    -   [Common Options](#common-options)
    -   [Stats Card Exclusive Options](#stats-card-exclusive-options)
    -   [Repo Card Exclusive Options](#repo-card-exclusive-options)
    -   [Language Card Exclusive Options](#language-card-exclusive-options)
    -   [Wakatime Card Exclusive Option](#wakatime-card-exclusive-options)
-   [Deploy Yourself](#deploy-on-your-own)
    -   [On Vercel](#on-vercel)
    -   [On other platforms](#on-other-platforms)
    -   [Keep your fork up to date](#keep-your-fork-up-to-date)
<br/>


<br/>

# **INTRODUCTION**

I believe in a world where all that's required of me is to enjoy life, lay on the couch, play COD and have exitential crises.
<br/>
If I could, I'd automate cooking, cleaning, working, doing taxes, making friends, dating, writing READMEs... Hell, I'd even automate playing with my stupid kids if I could.
<br/>

But technology hasn't quite catched up to my level of laziness yet, so I've taken some inspiration from Thanos and said ["Fine... I'll do it myself"](https://www.youtube.com/watch?v=EzWNBmjyv7Y).
<br/>

Here's my attempt at making the world a better place. People in the future will look back at heros like me and enjoy their time playing video games and fighting the war against AI, in peace.

<br/>

## Prerequisites
- [Python3 installed](https://www.python.org/downloads/)
- [Active DockerHub account](https://hub.docker.com/)
- [Active AWS account](https://aws.amazon.com/)
- [Active Azure DevOps account](https://azure.microsoft.com/en-us/free/)

<br/>

## What we'll be doing
Fkdjfksdgnslfgk

<br/>

## Tools we'll be using

For each step of the process, I’ve chosen to use the best tool in its field.<br>
And yeah... you might be thinking, "best" is a subjective term, right? Well... not here. This is MY repo! My opinions here are TRUTHS!! GOT IT???
<br/>

Ok, now that that's out of the way...

- Code Versioning -> Git
- Source Code Managment -> GitHub
- Cloud Infrastructure -> Amazon Web Services
- Infrastructure as Code -> Terraform
- Containerization -> Docker
- Container Orchestration -> Kubernetes
- Continuous Integration -> Azure DevOps
- Continuous Deployment -> Helm & ArgoCD
- Scripting -> Python
<br/>

<p title="Logos Banner" align="center"> <img  src="https://i.imgur.com/Jd0Jve8.png"> </p>

## **Disclaimer**

Some things could have been further automatized but I prioritized the separation of concerns.<br>
For example, the EKS cluster could have been deployed with ArgoCD installed in one go, but I wanted to have them separated so that each module is focused on it's specific task, increasing it's recyclability.

Let's begin...

<br/>

* * *

<br/>

# **CUSTOM SETUP**
In order to turn this whole deployment into your own thing, we need to do some initial setup:
1. Clone this repo
```bash
git clone https://github.com/tferrari92/automate-all-the-things.git
```
2. Move into the directory.
```bash
cd automate-all-the-things
```
2. Run the initial setup script. Come back when you are done.
```bash
python3 python/initial-setup.py
``` 

<br/>
<p title="Automation Everywhere" align="center"> <img width="460" src="https://i.imgur.com/xSmJv0k.png"> </p>
<br/>

# **CREATE AZURE ACCOUNT & ORGANIZATION**

CREAR ORGANIZACION DE 0!!!!!!!!!!!!!!!!!https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops

# **CREATE AN AZURE SELF HOSTED-AGENT** (OPTIONAL)
***If you have Free Parallelism or a paid Azure subscription, skip this step.***<br/>

If you don't have Free Parallelism activated on Azure DevOps, or don't have paid Azure subscriptions, you will have to run the pipeline in a self-hosted agent. 
This means you'll install an Azure DevOps Agent on your local machine, which will recieve and execute the pipeline jobs.

## In Azure DevOps

1. Navigate inside your project and open the tab “Project Settings”.
2. Click on the “Agent pools” tab.
3. Add pool.
4. Select “Self-hosted”, give a name and create it.
5. Navigate into the new Agent Pool and click “New agent”.
6. Select “Linux” and copy the “Download the agent” link.

<br/>

You need also to create a PAT (Personal Access Token) in order to be able to authenticate the VM. To do so:
1. In the Azure DevOps portal, click on the “User settings” (the icon in the top right corner).
2. Select “Personal Access Token”.
3. Create a new token with the Full access” permission. Copy the value of the token, it will be needed in the next step.

<br/>

## On Your Machine
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

<br/>
<p title="We Are Not The Same" align="center"> <img width="460" src="https://i.imgur.com/E0s8TW6.png"> </p>
<br/>
  
[SOURCE](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser#install)


# **SETUP AZURE DEVOPS**

Before creating our pipelines we need to get a few things set up.<br>
Sign in [Azure DevOps](https://dev.azure.com/).


## Install Required Plugins
These plugins are required for the pipelines we'll be creating.
1. Install [Terraform Tasks plugin](https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform) for Azure Pipelines
1. Install [AWS Toolkit plugin](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-vsts-tools) for Azure Pipelines 

<br/>

## Get Your AWS Keys
These will be required for Azure DevOps to connect to your AWS account.

1. Open the IAM console at https://console.aws.amazon.com/iam/.
2. On the navigation menu, choose Users. *If you are root user and haven't created any users, you'll find the option on the IAM dashboard*
3. Choose your IAM user name (not the check box).
4. Open the Security credentials tab, and then choose Create access key.
5. To see the new access key, choose Show. Your credentials resemble the following:<br>
- Access key ID: AKIAIOSFODNN7EXAMPLE<br>
- Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
6. Copy and paste these somewhere safe.

<br/>

## Create AWS Service Connection
These are required service connections for the pipelines we'll be creating.

1. Open your project on Azure DevOps.
2. Go to Project settings on the left side menu (bottom-left corner).
3. On the left side menu, under Pipelines, select Service connections.
4. Click on New service connection (top-right).
5. Select AWS.
6. Paste your Access Key ID and Secret Access Key.
7. Under Service connection name, write "aws".
8. Save.

HACE FALTA HACER LA SERVICE CONNECTIONS GITHUB O SE HACE SOA EN EL SETIP DE LA PIPELINE?????

<br/>

* * *

<br/>

# **PIPELINES**

## Terraform Backend Deployment Pipeline

Before deploying our whole infrastructure, we will create an Amazon S3 Bucket and DynamoDB table on aws with Terraform.<br>
These two resources will allow us to store our terraform state remotely and for state locking.

1. Go to Pipelines on the left side menu
2. Select Pipelines under Pipelines on the left side menu
3. Click on Create/New pipeline
4. Select Github
5. Give access to repo if it's the first time connecting to GitHub. Else select the repository.
6. Select Existing Azure Pipelines YAML file
7. Select Branch and Path to the pipeline YAML file and click Continue
8. Click on Save & Run
9. Rename the pipeline to "deploy-backend". On the Pipelines screen, click on the three-dot menu to see the Rename/move option.
10. The terraform state file will be exported as an artifact. You'll find it in the pipeline run screen. You can download it and save it in case you need to destroy the backend later.

<br/>
<p title="Guide" align="center"> <img width="700" src="https://i.imgur.com/UtZyCCe.png"> </p>
<br/>


<br/>

## EKS Deployment Pipeline

1. Go to Pipelines
2. Select Pipelines on the left side menu
3. Click on Create/New pipeline
4. Select Github
5. Give access to repo if it's the first time connecting to GitHub. Else select the repository.
6. Select Existing Azure Pipelines YAML file
7. Select Branch and Path to the pipeline YAML file and click Continue
8. Click on Save & Run
9. Rename the pipeline to "deploy-eks". On the Pipelines screen, click on the three-dot menu to see the Rename/move option.
10. The KubeConfig file will be exported as an artifact. You'll find it in the pipeline run screen. Download it, you'll need it to create the Kubernetes service connection.


### Create K8S Service Connection
For the next step to work, we need to create a K8S service connection with the KubeConfig we've just downloaded.

1. Go to Project settings on the left side menu (bottom-left corner).
2. On the left side menu, under Pipelines, select Service connections.
3. Click on New service connection (top-right).
4. Select Kubernetes.
5. Under "Authentication method" select KubeConfig.
6. Paste the contents of the kubeconfig previously downloaded inside the box.
7. Under Service connection name, write "k8s".
8. Verify and save.
  
<br/>

## ArgoCD Deployment Pipeline

1. Go to Pipelines
2. Select Pipelines on the left side menu
3. Click on Create/New pipeline
4. Select Github
5. Give access to repo if it's the first time connecting to GitHub. Else select the repository.
6. Select Existing Azure Pipelines YAML file
7. Select Branch and Path to the pipeline YAML file and click Continue
8. Click on Save & Run
9. Rename the pipeline to "deploy-argocd". On the Pipelines screen, click on the three-dot menu to see the Rename/move option.
10. The kubeconfig file will be exported as an artifact. You'll find it in the pipeline run screen. Download it, you'll need it to create the Kubernetes service connection.

<br/>
<p title="Gitops Chills" align="center"> <img width="460" src="https://i.imgur.com/kGQUUTw.jpg"> </p>
<br/>

ESCONDER LLAVES, Agregar tfvars a gitignore

CAMBIAR KEYS DE AWS PORQ YA ESTAN EN GITHUB!!!

GITIGNORE

DOCKER BEST PRACTICES

TF BEST PRACTICES

12 FACTOR APP
PASAR TODO A PYTHON SCRIPT

EXPLICAR PORQ USAMOS REMOTE BACKEDN PARA TFSTATE.

EL NOMBRE DEL BACKEND S3 y DYNAMODB ESTAN HARDCODEADOS EN EL BACKEND DE aws-resources, HAY Q GUARDARLOS EN VARIABLE DE ALGUNA FORMA
  

https://mylearn.oracle.com/ou/component/-/108432/165507
<br/>
<p title="Anakin" align="center"> <img width="460" src="https://i.imgur.com/tup8Ocu.jpg"> </p>
<br/>
<br/>
<p title="Scroll Of Truth" align="center"> <img width="460" src="https://i.imgur.com/yjpOvlM.jpg"> </p>
<br/>
<br/>
<p title="Guy Behind Tree" align="center"> <img width="460" src="https://i.imgur.com/y3I39FA.jpg"> </p>
<br/>
<br/>
<p title="Thinking About Another Woman" align="center"> <img width="460" src="https://i.imgur.com/akNhnrh.jpg"> </p>
<br/>
<br/>
<p title="Momoa & Cavill" align="center"> <img width="460" src="https://i.imgur.com/2lJ6xLl.jpg"> </p>
<br/>
<br/>
<p title="Wolverine & Nana" align="center"> <img width="460" src="https://i.imgur.com/dz0RdX5.png"> </p>
<br/>



DESCARTADO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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

<a href="https://www.youtube.com/watch?v=EzWNBmjyv7Y" target="_blank">"Fine... I'll do it myself"</a>.
