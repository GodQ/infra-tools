vi  /etc/kubernetes/manifests/kube-apiserver.yaml
add "- --service-node-port-range=70-65000"  in command list

```yaml
spec:
  containers:
  - command:
    - kube-apiserver
    - --service-node-port-range=70-65000
    - --advertise-address=10.0.1.20
```

service kubelet restart


