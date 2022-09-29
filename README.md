# Kubernetes_CICD_Architekturgilde_Nuernberg

## Login to AWS

  Log into AWS using the Account, IAM user and credentials you were provided withhttps://eu-central-1.console.aws.amazon.com/console/home?region=eu-central-1# 
  You will be prompted to change your password after the initial login

  Switch the selected region to eu-central-1

  Navigate to the EC2 Dashboard by using the search bar


## Launch EC2 instance

  Click on Launch instance in the EC2 Dashboard
  
  Select a unique name for your instance, e.g. your name (it can be changed later, IF you know which instance is yours)
  
  Under Application and OS Images, go to My AMIs and select minikube-VM (available under “Owned by me”)
  
  Under Instance type, select t2.medium
  
  Create an own Key pair to connect to your instance, make sure to give it a unique name (e.g. <yourname>-ssh)
  
  Edit the Network settings:
  
  ![image](https://user-images.githubusercontent.com/113344386/192980055-acb8cc7c-793a-487a-980c-bee7631a0598.png)


  Configure your storage to 8 GiB of gp2

## Start MiniKube Cluster
  
  Connect to your instance via EC2 Instance Connect
  
  User name: root
  
  A SSH connection will be opened in a new tab
  
  Run `service docker start`
  
  Run `su ec2-user`
  
  Run `minikube start`
  
  Run `kubectl get namespaces` to see if everything works

## Deploy your first container application
  
  Run `kubectl run hello-world --image=gcr.io/google_containers/echoserver:1.4 --port=8080`
  
  Run `kubectl get pods -o wide`
  
  Run `kubectl exec -i -t hello-world -- /bin/bash`
  
  Run `curl <pod-ip-address>:8080`
  
## Configure GitHub with your AWS credentials
  
  Fork the repo Kubernetes_CICD_Architekturgilde_Nuernberg
  
  In your GitHub repository, go to Settings -> Secrets (under Security) -> Actions
  
  Create new repository secrets:
  
  Key: AWS_ACCESS_KEY_ID    Value: <your aws access key>
  
  Key: AWS_SECRET_ACCESS_KEY    Value: <your aws secret access key>
  
## GitHub Actions
  
  In GitHub, got to "Actions", click on "Build image and push to ECR"
  
  Click on "Run workflow"
  
  The workflow should automatically build a basic nginx docker image and replace the index.html file with the one in our repo under app/index.html.
  The image will then be pushed onto the configured ECR (Elastic Container Registry) in AWS with a predefined tag.
  
## Install FluxCD on your K8s cluster
  
  In GitHub, create a personal access token (PAT): Click on your account (top right) -> Settings -> Developer Settings -> Personal access tokens -> Generate new token
  
  Grant repository access:
  
  ![image](https://user-images.githubusercontent.com/113344386/192984686-cb9baf0b-13e7-4c63-bb7e-588261d5fa10.png)
  
  Save the key somewhere!
  
  
  SSH into your EC2 instance as ec2-user
  
  Run `cd .. `
  
  Run `curl -s https://fluxcd.io/install.sh | sudo bash`
  
  Run `. <(flux completion bash)`
  
  Run `export GITHUB_TOKEN=<your github token>`
  
  Run `flux bootstrap github --owner=<your-github-account> --repository=Kubernetes_CICD_Architekturgilde_Nuernberg --path=flux-integration/flux-system --personal`
  
  Run `flux create source git my-flux-source --url=https://github.com/ChristopherDankertCap/Kubernetes_CICD_Architekturgilde_Nuernberg --branch=main --interval=30s`
  
  Run `flux create kustomization my-kustomization --target-namespace=default --source=my-flux-source --path="./infra" --prune=true --interval=5m`
  
  Flux should now automatically create a deployment in your default namespace in Kubernetes:
  
  Run `kubectl get deployment`
