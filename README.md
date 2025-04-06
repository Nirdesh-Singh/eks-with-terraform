# Please follow the below get the Cluster up and running. Then deploy the Application via Helm as well as Logging through Loki

## High-Level Architecture Design (AWS Deployment)

![eks-cloud drawio (1)](https://github.com/user-attachments/assets/c20234d6-0a11-48fe-8de1-b43c323fe7f3)

## Install the AWS CLI and then open the terminal

Run the command : aws configure

Provide the access key id and secret key id

Provide the region : ap-south-1

## Change directory to terraform-eks

Run the command : terraform apply

When prompted to approve the creation, type 'yes' and press Enter.

![image](https://github.com/user-attachments/assets/18de9490-a134-4eca-90db-6fdd6211f4b4)

Wait for few approx. 20 - 25 mins. The infrastructure will be created.

Total 38 aws resources will be created - VPC, Subnets, NAT Gateway, EKS Cluster, IAM roles, Route tables, Security groups, etc.

![image](https://github.com/user-attachments/assets/10ec9c9a-327b-4642-a436-6634a8a05123)

## Update the kubeconfig context in the terminal by running the following command:

aws eks update-kubeconfig --region ap-south-1 --name cheap-eks-cluster

Now, verify if you are able to connect to the Cluster from you local terminal using following commands :

kubectl get nodes

kubectl get po -A

![image](https://github.com/user-attachments/assets/2291cc1c-fe1e-4704-bbf3-e6e04038b49e)

You should get a similar output.

## Create the Ingress Resource

First of all, create the namespace test where our application is going to be deployed

kubectl create ns test

Create the internet-facing application load balancer

kubectl apply -f ingress.yaml -n test

Then, run the following command to check if the ingress got created:

kubectl get ingress -n test

![image](https://github.com/user-attachments/assets/5d3163a1-baa8-41f3-ac46-ade33dd4c60c)

If the dns is coming, it means the alb got created successfully.

Now, go to your GitHub Account and create a PAT token.

Now, open Git Bash and run the following command to authenticate with GitHub Container registry

echo <YOUR_PAT> | docker login ghcr.io -u <YOUR_GITHUB_USERNAME> --password-stdin

## Change to Spring Boot Project directory

Run the following commands:

Build the jar : ./gradlew clean bootJar

Build the docker image : docker build -t backend .

Tag the docker image : docker tag backend:latest ghcr.io/<your-username>/backend:latest

Push the docker image to ghcr.io : docker push ghcr.io/<your-username>/backend:latest

Change to backend helm chart : cd backend-chart

Make following changes in values.yaml file

image:

  repository: ghcr.io/<your-username>/backend
  
  tag: latest
  
  pullPolicy: IfNotPresent

config:

  corsAllowedOrigins: <ALB_DNS> --> http://age-calculator-ingress-abc.ap-south-1.elb.amazonaws.com

Change to mariadb directory : cd mariadb

Change to mariadb helm chart : cd mariadb-chart

Deploy the mariadb helm chart in test namespace : helm install mariadb-container . -n test

Change back to backend helm chart : cd ../../backend-chart

Authorize the GitHub Container Registry : kubectl create secret docker-registry ghcr-secret --docker-server=ghcr.io --docker-username=<your-github-username> --docker-password=<your-pat-token> --docker-email=<your-email> -n test 

Deploy the helm chart in test namespace : helm install backend . -n test

Check if both the backend and mariadb containers are running fine

![image](https://github.com/user-attachments/assets/4903f738-150f-429e-992e-678270853c7f)

## Change to user-age-app directory (Frontend)

Create an .env file

Put REACT_APP_API_BASE_URL=<ALB_DNS> --> append http:// before DNS

Go to default.conf file

Put the dns value at line 3 and 13

server_name <ALB_DNS>;

proxy_pass <ALB_DNS> --> Append http:// before DNS;

Build the react project : npm run build

Build the frontend docker image : docker build -t frontend .

Tag the frontend docker image : docker tag backend:latest ghcr.io/<your-username>/frontend:latest

Push the frontend docker image to ghcr.io : docker push ghcr.io/<your-username>/frontend:latest

Make following changes in values.yaml file

image:

  repository: ghcr.io/<your-username>/frontend
  
  tag: latest
  
  pullPolicy: IfNotPresent

env:

  REACT_APP_API_BASE_URL: http://<put-alb-dns-here> # http://age-calculator-ingress-abc.ap-south-1.elb.amazonaws.com

Change to frontend helm chart : cd frontend-chart

Deploy the frontend helm chart in test namespace : helm install frontend . -n test

Access the dns over the browser

The frontend should come up

![image](https://github.com/user-attachments/assets/639ed56d-0590-4fbc-a4bd-e5c59421b45f)

Now, let install Grafana and Loki for Logging

## Change to Grafana Loki directory

Run the following commands :

Create grafana namespace : kubectl create ns grafana

Deploy the grafna, promtail and loki in grafana namespace using following commands :

helm repo add grafana https://grafana.github.io/helm-charts 

helm repo update

kubectl apply -f grafana-deployment.yaml

helm upgrade --install promtail grafana/promtail -n grafana --create-namespace -f promtail-values.yaml

helm upgrade --install loki grafana/loki -n grafana --create-namespace -f loki-values.yaml --set loki.auth_enabled=false

Put the dns of grafana ingress into browerser to access to Grafana UI

![image](https://github.com/user-attachments/assets/2d711313-040c-4295-b49a-8c3944a60c3e)

Use credentials

Username : admin

Password : admin

And login to Grafana

Add Loki Datasource

![image](https://github.com/user-attachments/assets/b040982d-3a3c-47a2-936e-a0fc1610fb49)

![image](https://github.com/user-attachments/assets/7aaca60c-267f-40a0-85a8-c0c3b5d46bcd)

![image](https://github.com/user-attachments/assets/706318bd-1531-4de8-81dd-b75c18f507a4)

![image](https://github.com/user-attachments/assets/1926d60d-aea3-4220-9f25-85ce41b6f2bd)

![image](https://github.com/user-attachments/assets/b1f6fb88-ee12-41e8-9177-824ca19326ae)


So, our end-to-end setup is completed !

Finally, do not forget to run 

terraform destroy

![image](https://github.com/user-attachments/assets/b500c2eb-c982-4f8c-b8bf-78f6845f00b4)
