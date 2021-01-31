course: Software Containerization
date : Sun Jan 31 23:49:15 UTC 2021

readme for flask api and postgresql kubernetes project in google cloud

Group:
group 4
Bojana Arsovska
Nienke Noort
Folkert van Verseveld

github project: https://github.com/BojanaArsovska/Software-Containerization


--- compute engine ---


create google cloud compute engine:
8gb ram
zone europe-west-4


download the softwarecontainerization project (note to us: this should be the zipped github project)
copy the zip file to the compute engine
unzip

navigate to root folder

# kubernetes and postgres database service setup

microk8s enable registry dashboard dns
kubectl get endpoints

kubectl port-forward -n kube-system service/kubernetes-dashboard --address KUBERNETES_ENDPOINT 10443:443

replace KUBERNETES_ENDPOINT with the endpoint shown in 'kubectl get endpoints' (in our case: 10.164.0.4)

configure the firewall in the GCP to make it accessible to the world wide web:

- navigate to the GCP
- search for 'firewall' in the top search bar and select 'firewall insights / network intelligence'
- click enable to the right hand side of the warning sign
- create firewall rule:
  - direction of traffic: ingress
  - action on match: allow
  - targets: all instances in the network
  - specified protocols and ports: tcp: 10443,30002

next, open a new terminal (or create a new one in e.g. tmux) configure the postgres-service (in ~/Software-Containerization/postgres/):

kubectl apply -f postgres-config.yaml

next, apply the secret and configuration files:

kubectl apply -f postgres-secret.yaml

sudo mkdir -p /opt/postgre/data
kubectl apply -f postgres-storage.yaml

finally, deploy the postgres db:

kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml

in the kubernetes dashboard, the database service should appear.

# blog-api service setup

build and tag the image

sudo docker build .
sudo docker tag <id> blog-api
sudo docker tag blog-api localhost:32000/blog-api
sudo docker push localhost:32000/blog-api

configure and start the blog REST api webservice in kubernetes:

kubectl apply -f blog-api-deployment.yaml
kubectl apply -f blog-api-service.yaml

in the kubernetes dashboard, the webservice should appear.

using curl, we can confirm the webservice is reachable:

kubectl get svc
curl -k https://BLOG_API_CLUSTER_IP:8081/

replace BLOG_API_CLUSTER_IP with the cluster ip printed by 'kubectl get svc'.
it should print:

Congratulations! Your part 2 endpoint is working

next, check you can add user and retrieve a jwt token:

curl -H "Content-Type: application/json" -X POST -d '{"email":"user@example.com","name":"admin","password":"admin"}' -k https://10.152.183.2:8081/api/v1/users/

the output should be something like the following json output:

{
"jwt_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTIxODA1NzMsImlhdCI6MTYxMjA5NDE3Mywic3ViIjoxM30.L4-AOm4PBQoZd_GlCAA3eqB-OKLkxEvUZ9mtQmsfefU"
}


next, configure the ingress port and update the hosts file to listen to my-blog.com

echo '127.0.0.1 my-blog.com' | sudo tee -a /etc/hosts
kubectl apply -f blog-api-ingress.yaml

confirm with curl that my-blog.com responds:

curl -k https://my-blog.com:30002/

it should print:

Congratulations! Your part 2 endpoint is working

finally, update the firewall rule in GCP to add port 30002

note that the rest api can also be tested using postman.

unfortunately, rollout and canary deployment were not working as expected.
we have executed the same steps provided in the lesson and replacing nginx with blog-api

in the video, we explain how to force rebuild the docker image and deploy it to the kubernetes engine.


--- optionals ---

our projects runs in a GCP in a compute engine

navigate to blog-api/
helm install blog-api-chart ./

we used this project to setup helm in postgres:
https://github.com/BojanaArsovska/Software-Containerization
