https://kubernetes.github.io/ingress-nginx/deploy/#provider-specific-steps

# Using Helm：

```
kubectl create ns ingress-nginx
helm install ingress-nginx  nginx-stable/nginx-ingress --namespace ingress-nginx
```

Wait for deploy finish
```
kubectl get pods --all-namespaces -l app=ingress-nginx-nginx-ingress --watch
```

```
kubectl -n ingress-nginx get svc
```
After installation, you will found the service is unavailable and EXTERNAL-IP status is pending.
This issue is caused by the loadbalance service, so you should set a EXTERNAL-IP manually:
```
kubectl -n ingress-nginx patch svc ingress-nginx-nginx-ingress -p '{"spec":{"externalIPs":["10.110.125.10","10.0.1.10"], "externalTrafficPolicy": "Cluster"}}'
```

 uninstall:
```
helm uninstall ingress-nginx --namespace ingress-nginx
kubectl delete ns ingress-nginx
```

# Using kubectl apply （bare-metal）：
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/baremetal/service-nodeport.yaml
```

Wait for deploy finish
```
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx --watch
```

# Access Port:
```
kubectl -n ingress-nginx get svc
```
The ingress port can be found in kubectl get service. Or you can change service node port manually:
```
kubectl -n ingress-nginx patch svc <service-name> -p '{"spec":{"ports":[{"name": "http","protocol": "TCP","port": 80,"targetPort": 80,"nodePort": 30080},{"name": "https","protocol": "TCP","port": 443,"targetPort": 443,"nodePort": 30443}]}}'
```

# Demo 
```
kubectl apply -f demo.yaml
```
Add "<node-ip> godq.k8s.io" to your /etc/hosts
```
curl godq.k8s.io:30080/hello
```
or you can use without changing /etc/hosts:
```
curl 10.110.125.10:30080/hello -H "Host: demo.k8s.io"
```





