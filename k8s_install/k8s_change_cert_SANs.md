
In kubeadm init, you can use parameter --apiserver-cert-extra-sans to add ip/url to cert like:
```
kubeadm init --apiserver-advertise-address=10.0.1.10 --apiserver-cert-extra-sans=10.0.1.10,10.110.125.10 --pod-network-cidr=10.244.0.0/16
```

After init, you should follow the steps:


https://blog.scottlowe.org/2019/07/30/adding-a-name-to-kubernetes-api-server-certificate/

1. get old config
```
kubectl -n kube-system get configmap kubeadm-config -o jsonpath='{.data.ClusterConfiguration}' > kubeadm.yaml
```

2. edit the apiServer.certSANs

3. move or delete old cert/key
```
mv /etc/kubernetes/pki/apiserver.{crt,key} ~
```

4. create new cert/key
```
kubeadm init phase certs apiserver --config kubeadm.yaml
```

5. restart api-server
```
docker ps | grep kube-apiserver | grep -v pause
docker kill <containerID>
```