# Kubernetes_CICD_Architekturgilde_Nuernberg

1. Login to AWS

  Log into AWS using the Account, IAM user and credentials you were provided withhttps://eu-central-1.console.aws.amazon.com/console/home?region=eu-central-1# 
  You will be prompted to change your password after the initial login

  Switch the selected region to eu-central-1

  Navigate to the EC2 Dashboard by using the search bar
  ![image](https://user-images.githubusercontent.com/113344386/192960747-65e941c4-a91d-45bb-995d-f190a4c6d7c9.png)


2. Launch EC2 instance

  Click on Launch instance in the EC2 Dashboard
  Select a unique name for your instance, e.g. your name (it can be changed later, IF you know which instance is yours)
  Under Application and OS Images, go to My AMIs and select minikube-VM (available under “Owned by me”)
  Under Instance type, select t2.medium
  Create an own Key pair to connect to your instance, make sure to give it a unique name (e.g. <yourname>-ssh)
  Edit the Network settings, it should look like this:
  ![image](https://user-images.githubusercontent.com/113344386/192960858-7026e373-6f9f-4337-af12-142cb4df3041.png)

  Configure your storage to 8 GiB of gp2

3. Start MiniKube Cluster
  
  Connect to your instance via EC2 Instance Connect
  User name: root
  A SSH connection will be opened in a new tab
  
  Execute "service docker start"
  Execute "su ec2-user"
  Execute "minikube start"
  Execute "kubectl get namespaces" to see if everything works

4. Deploy your first container application
  
  kubectl run hello-world --image=gcr.io/google_containers/echoserver:1.4 --port=8080
  kubectl get pods -o wide
  kubectl exec -i -t hello-world -- /bin/bash
  curl <pod-ip-address>:8080
  
5. GitHub Actions
  
  In GitHub, got to "Actions", click on "Build image and push to ECR"
  Click on "Run workflow"
  
  
