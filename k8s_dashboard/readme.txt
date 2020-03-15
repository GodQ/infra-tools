
https://www.jianshu.com/p/be2a12a8bc0b
https://www.jianshu.com/p/c6d560d12d50
https://github.com/kubernetes/dashboard


1. use the local yaml file or change official yaml

curl https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc6/aio/deploy/recommended.yaml -O
Changes:
a. The official yaml uses a smallest service account. You can create a new cluster-admin service account to control everything
b. change the service account name to the new one
c. delete secret kubernetes-dashboard-certs (will use a new one)
d. change service type to NodePort and set nodePort: 30001 


2. create cert file and key file (to fix the browser issue)

openssl genrsa -out dashboard.key 2048
openssl req -new -out dashboard.csr -key dashboard.key -subj '/CN=192.168.246.200'
openssl x509 -req -in dashboard.csr -signkey dashboard.key -out dashboard.crt 
openssl x509 -in dashboard.crt -text -noout

Get the cert and key file


3.create dashboard

kubectl create namespace kubernetes-dashboard
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt -n kubernetes-dashboard
kubectl apply -f recommended.yaml


4.check status

kubectl get pods -n kubernetes-dashboard
 Browser URL:  https://localhost:30001/#/login

5.get token

kubectl describe secret -n kubernetes-dashboard $(kubectl get secret -n kubernetes-dashboard | grep dashboard-admin | awk '{print $1}')







