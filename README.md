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
  
## GitHub Actions
  
  In GitHub, got to "Actions", click on "Build image and push to ECR"
  
  Click on "Run workflow"
  
  
