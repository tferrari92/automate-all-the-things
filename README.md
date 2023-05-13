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

<p title="All The Things" align="center"> <img src="https://i.imgur.com/BbBEFEE.jpg"> </p>

# **INDEX**

-   [Introduction](#introduction)
    -   [Prerequisites](#prerequisites)
    -   [What we'll be doing](#what-well-be-doing)
    -   [Tools we'll be using](#tools-well-be-using)
    -   [Disclaimer](#disclaimer)
-   [Local Setup](#local-setup)
-   [Azure DevOps Setup](#azure-devops-setup)
    -   [Create project](#create-project)
    -   [Install Required Plugins](#install-required-plugins)
    -   [Get Your AWS Keys](#get-your-aws-keys)
    -   [Create AWS Service Connection](#create-aws-service-connection)
    -   [Create An Azure Self-Hosted Agent](#optional-create-an-azure-self-hosted-agent)
-   [Pipelines](#pipelines)
    -   [Terraform Backend Deployment Pipeline](#terraform-backend-deployment-pipeline)
    -   [EKS Deployment Pipeline](#eks-deployment-pipeline)
         -   [Create K8S Service Connection](#create-k8s-service-connection)
    -   [ArgoCD Deployment Pipeline](#argocd-deployment-pipeline)
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
- [Python3 installed on your machine](https://www.python.org/downloads/)
- [AWS CLI installed on your machine](https://aws.amazon.com/cli/)
- [Active DockerHub account](https://hub.docker.com/)
- [Active AWS account](https://aws.amazon.com/)
- [Active Azure DevOps account](https://azure.microsoft.com/en-us/free/)

<br/>

## What we'll be doing
The purpose of this repo is not to guive you an in depth explanation of the tools we are using, but to demonstrate how easy it can be to deploy a whole infra and how the tools can interact with each other to make them as efficient as posible. To show good practices and how to provide your devs, ops, and devops teams with guides on how to perfmmorm their specific. tasks . Demonstrate the power of infrastructure as code (IaC) and CI/CD (cont interg cont deplo)

<br/>

## Tools we'll be using

For each step of the process, I’ve chosen to use the best tool in its field.<br>
And yeah... you might be thinking, "best" is a subjective term, right? Well... not here. This is MY repo! My opinions here are TRUTHS!!
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

# **LOCAL SETUP**
In order to turn this whole deployment into your own thing, we need to do some initial setup:
1. Fork this repo.
1. Clone the repo from your fork:
```bash
git clone https://github.com/<your-username>/automate-all-the-things.git
```
2. Move into the directory:
```bash
cd automate-all-the-things
```
2. Run the initial setup script. Come back when you are done:
```bash
python3 python/local/00-initial-setup.py
``` 
4. Hope you enjoyed the welcome script! Now push the customized repo to GitHub:
```bash
git add .
git commit -m "customized repo"
git push
```
5. Awesome! You can now proceed with the Azure DevOps setup.

<br/>
<p title="Automation Everywhere" align="center"> <img width="460" src="https://i.imgur.com/xSmJv0k.png"> </p>
<br/>

# **AZURE DEVOPS SETUP**

Before creating our pipelines we need to get a few things set up:<br>

## Create project
1. Sign in [Azure DevOps](https://dev.azure.com/).
2. Go to "New project" on the top-right.
3. Write the name for your project and under "Visibility" select "Private".
4. Click "Create".

<br/>

## Install Required Plugins
These plugins are required for the pipelines we'll be creating. Click on "Get it free" and then "Install".
1. Install [Terraform Tasks plugin](https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform) for Azure Pipelines
1. Install [AWS Toolkit plugin](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-vsts-tools) for Azure Pipelines 

<br/>

## Get Your AWS Keys
These will be required for Azure DevOps to connect to your AWS account.

1. Open the IAM console at https://console.aws.amazon.com/iam/.
2. On the search bar look up "IAM".
3. On the IAM dashboard, select "Users" on the left side menu. *If you are root user and haven't created any users, you'll find the "Create access key" option on IAM > My security credentials. You should know that ***creating Access Keys for the root user is a bad security practice***. If you choose to proceed anyway, click on "Create access key" and skip to point 6*.
4. Choose your IAM user name (not the check box).
5. Open the Security credentials tab, and then choose "Create access key".
6. To see the new access key, choose Show. Your credentials resemble the following:<br>
- Access key ID: AKIAIOSFODNN7EXAMPLE<br>
- Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
7. Copy and save these somewhere safe.

<br/>

## Create AWS Service Connections
This service connection is required for our Azure DevOps pipelines to interact with other AWS.

1. Go back to Azure DevOps and open your project.
2. Go to Project settings on the left side menu (bottom-left corner).
3. On the left side menu, under "Pipelines", select "Service connections".
4. Click on "Create service connection".
5. Select AWS.
6. Paste your Access Key ID and Secret Access Key.
7. Under "Service connection name", write "aws".
8. Select the "Grant access permission to all pipelines" option.
9. Save.

## Create DockerHub Service Connections
This service connection is required for our Azure DevOps pipelines to interact with other AWS.

1. Go back to Azure DevOps and open your project.
2. Go to Project settings on the left side menu (bottom-left corner).
3. On the left side menu, under "Pipelines", select "Service connections".
4. Click on "Create service connection".
5. Select "Docker Registry".
6. Under "Registry type" select "Docker Hub".
7. Input your Docker ID and Password.
7. Under "Service connection name", write "dockerhub".
8. Select the "Grant access permission to all pipelines" option.
9. Click on "Verify and save".

<!-- ## Create AWS-Keys Variable Group
These are needed for Terraform to be able to deploy our AWS infrastructure.
1. On the left side menu under "Pipelines" go to "Library"
2. Click on "+ Variable group".
3. Under "Variable group name" write "aws-keys".
4. Add the following variables pasting on each the same keys you used to create the AWS service connection:
- aws_access_key_id 
- aws_secret_access_key
5. Click on the lock icon on each variable.
6. Save. -->

<!-- NO HACE FALTA PORQ SE CREA SOLA CON EL NOMBRE DE USERNEAME DE GITHUB -->
<!-- ### GitHub
4. On the Service connectionlick on "New service connection" .
5. Select AWS.
6. Paste your Access Key ID and Secret Access Key.
7. Under "Service connection name", write "aws".
8. Select the "Grant access permission to all pipelines" option.
9. Save. -->

<br/>

## (OPTIONAL) Create An Azure Self-Hosted Agent
***If you have a hosted parallelism, you can skip this step.***<br/>

A hosted parallelism basically means that Azure will spin up a server in which to run your pipelines. You can purchase one or you can request a free parallelism by filling out [this form](https://aka.ms/azpipelines-parallelism-request).<br/>

If you don't have a hosted parallelism, you will have to run the pipeline in a **self-hosted agent**. 
This means you'll install an Azure DevOps Agent on your local machine, which will recieve and execute the pipeline jobs.<br/>

To install a self-hosted agent on your machine, you can follow the official documentation [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser#install).



<br/>
<p title="We Are Not The Same" align="center"> <img width="460" src="https://i.imgur.com/E0s8TW6.png"> </p>
<br/>


* * *


<br/>

# **PIPELINES**

## Terraform Backend Deployment Pipeline

Before deploying our whole infrastructure, we will create an Amazon S3 Bucket and DynamoDB table on AWS with Terraform. These two resources will allow us to store our terraform state remotely and lock it.<br/>

Why do we need to store our tf state remotely and locking it? Well, this is probably not necessary for this excercise but it's a best practice when working on a team.<br>
Storing it remotely means that everyone on the team can access the same state file, and locking it means that only one person can access it at a time, this prevents state conflicts.

1. On your Azure DevOps project, go to Pipelines on the left side menu.
2. Select Pipelines under Pipelines on the left side menu.
3. Click on "Create Pipeline".
4. Select "Github".
5. You might need to go through the GitHub authorization process, go ahead and click the green button.
6. Select the repo, it should be "<your-github-username>/automate-all-the-things"
7. You might need to click more green buttons to allow Azure DevOps to interact with GitHub, go ahead.
8. Select "Existing Azure Pipelines YAML file".
9. Under "Branch" select "main" and under "Path" select "/azure-devops/00-deploy-backend.yml". Click "Continue".
10. If you have hosted parallelism skip to point 11. **If you DON'T have a hosted parallelism**, you need to tell Azure DevOps to use your [**self-hosted agent**](#optional-create-an-azure-self-hosted-agent). In order to do this, you'll need to go to the repo and modify the azure-devops/00-deploy-backend.yml file.<br>
Under "pool" you need to edit it so that it looks like this:
```yaml
pool:
  # vmImage: 'ubuntu-latest'
  name: <agent-pool-name> # Insert here the name of the agent pool you created
  demands:
    - agent.name -equals <agent-name> # Insert here the name of the agent you created
```
11. Click on "Run".
12. You might get a warning saying "This pipeline needs permission to access a resource before this run can continue". Click on "View" and "Permit".
<!-- 13. Rename the pipeline to "deploy-backend". On the Pipelines screen, click on the three-dot menu to see the Rename/move option. -->
14. The terraform state file will be exported as an artifact. You'll find it in the pipeline run screen. Download it and save it. We'll use it to destroy the backend later.

<br/>
<p title="Guide" align="center"> <img width="700" src="https://i.imgur.com/UtZyCCe.png"> </p>
<br/>


<br/>

## EKS Deployment Pipeline

2. Go to "Pipelines" under "Pipelines" on the left side menu.
3. Click on "New pipeline".
4. Select "GitHub".
6. Select the repo, it should be "<your-github-username>/automate-all-the-things"
6. Select "Existing Azure Pipelines YAML file".
9. Under "Branch" select "main" and under "Path" select "/azure-devops/01-deploy-eks.yml". Click "Continue".
11. Click on "Run".
<!-- 9. Rename the pipeline to "deploy-eks". On the Pipelines screen, click on the three-dot menu to see the Rename/move option. -->
<!-- 10. When it's finished, the KubeConfig file will be exported as an artifact. You'll find it in the pipeline run screen. Download it, NO PARA SERVICE CONNECTION PERO SI PARA TOCAR KUBECTL A MANO DESDE LOCAL we'll need it to create the Kubernetes service connection. -->

<br>

#### Configure AWS CLI and EKS Cluster
To check that everything went OK we will connect to our cluster from our local machine. Use the following commands, you'll need to input your AWS info. When prompted for "Default output format" just press enter.
```bash
aws configure
aws eks update-kubeconfig --name <your-app-name>-cluster --region <your-aws-region>
```
**REMEMBER**: This is only to SEE our resources. Creating or deleting resources is strictly prohibited. We're not some cavemen using kubectl create/delete. We are gentlemen, we modify our infrastrucure with **GitOps**. 

To visualize our resource we can now use:
```bash
kubectl get all --all-namespaces
```

INSTERT WINNIE POOH MEME
<br>


#### Create AWS-Keys Variable Group
These are needed for Helm to be able to connect to our EKS Cluster and deploy ArgoCD.

1. On the left side menu under "Pipelines" go to "Library"
2. Click on "+ Variable group".
3. Under "Variable group name" write "aws-keys".
4. Add the following variables pasting on each the same keys you used to create the AWS service connection:
- aws_access_key_id 
- aws_secret_access_key
5. Click on the lock icon on each variable so that they are treated as secrets.
6. Save.


<!-- #### Create K8S Service Connection

1. Go to "Project settings" on the left side menu (bottom-left corner).
2. On the left side menu, under "Pipelines", select "Service connections".
3. Click on "New service connection" (top-right).
4. Select "Kubernetes" and click "Next".
5. Under "Authentication method" select "KubeConfig".
6. Paste the contents of the kubeconfig previously downloaded inside the box.
7. Select "Accept untrusted certificates".
7. Under "Service connection name", write "k8s".
8. Select "Grant access permission to all pipelines".
8. Click on "Verify and save". -->
  
<br/>

## ArgoCD Deployment Pipeline

2. Go to "Pipelines" under "Pipelines" on the left side menu.
3. Click on "New pipeline".
4. Select "GitHub".
6. Select the repo, it should be "<your-github-username>/automate-all-the-things"
6. Select "Existing Azure Pipelines YAML file".
9. Under "Branch" select "main" and under "Path" select "/azure-devops/02-deploy-argocd.yml". Click "Continue".
11. Click on "Run".
12. You might get a warning saying "This pipeline needs permission to access a resource before this run can continue". Click on "View" and "Permit".
<!-- 9. Rename the pipeline to "deploy-argocd". On the Pipelines screen, click on the three-dot menu to see the Rename/move option. -->


<br/>
<p title="Gitops Chills" align="center"> <img width="460" src="https://i.imgur.com/kGQUUTw.jpg"> </p>
<br/>

## Application Build Pipeline
2. Go to "Pipelines" under "Pipelines" on the left side menu.
3. Click on "New pipeline".
4. Select "GitHub".
6. Select the repo, it should be "<your-github-username>/automate-all-the-things"
6. Select "Existing Azure Pipelines YAML file".
9. Under "Branch" select "main" and under "Path" select "/azure-devops/03-application-build.yml". Click "Continue".
11. Click on "Run".

## Create ArgoCD Application
Ok this is the only command 


## Application Deployment Pipeline
2. Go to "Pipelines" under "Pipelines" on the left side menu.
3. Click on "New pipeline".
4. Select "GitHub".
6. Select the repo, it should be "<your-github-username>/automate-all-the-things"
6. Select "Existing Azure Pipelines YAML file".
9. Under "Branch" select "main" and under "Path" select "/azure-devops/04-application-deploy.yml". Click "Continue".
11. Click on "Run".

CONFIGURAR REPO PRIVADO EN ARGOCD??

CREAR INGRESS PARA ARGOCD. IP PUBLICA TAMBIEN!!!!!

CAMBIAR KEYS DE AWS!!!

DOCKER BEST PRACTICES

TF BEST PRACTICES

AGREGAR CHEKEO DE Q INPUTS EN PYTHON SCRIPT SEAN VALIDOS, SOLO TEXTO, NROS y - y _

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
