
Create a pod to run hellp-app
```
kubectl run web --image=godq/hello-app --port=8080
```

Create a service to expose nodeport
```
kubectl expose pod web --target-port=8080 --type=NodePort
```

Get the service port
```
kubectl get service web
```

Test if the pod works well
```
curl <k8s node ip>:<port from service>
```
Hello, world!
Version: 1.0.0
Hostname: web


