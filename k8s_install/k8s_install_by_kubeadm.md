
# Install Steps
1. clean up extra disks
2. change host name and add 3 nodes to /etc/hosts
```bash
vi /etc/hostname
vi /etc/hosts
```

3. mount the extra disks to /var/lib/docker
```bash
mkdir /var/lib/docker
vi /etc/fstab   ==> #swap item and change sdb item to /var/lib/docker
```

4. install docker
follow docker doc : https://docs.docker.com/install/linux/docker-ce/centos/
If dependency failed, run "yum versionlock clear" and then retry yum install
Don't forget to run
```bash
systemctl enable docker.service
```

5. add docker proxy to pull k8s images:
```bash
mkdir /etc/systemd/system/docker.service.d
vi /etc/systemd/system/docker.service.d/http-proxy.conf
```
http-proxy.conf:
```yaml
[Service]
Environment="HTTPS_PROXY=xxxxxx" "HTTP_PROXY=xxxxxx"
```
```bash
systemctl daemon-reload
systemctl show docker --property Environment
systemctl restart docker
```

6. install kubeadm kubelet kubectl
```
export http_proxy="xxxxx"  # to install rpm needs proxy
export https_proxy="xxxx"
```
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

7. master kubeadm init --cidr (flannel)
```shell
kubeadm init  --pod-network-cidr=10.244.0.0/16
```
Or in order to use the private network ip 10.0.1.10, you should use:
```shell
kubeadm init --apiserver-advertise-address=10.0.1.10 --apiserver-cert-extra-sans=10.0.1.10,10.110.125.10 --pod-network-cidr=10.244.0.0/16
```

Get the join command and token like 
  "kubeadm join <master-ip> --token <token> --discovery-token-ca-cert-hash <hash>"
copy config file to .kube folder to enable kubectl
Note: the kubeadm join command must keep in record.

```shell
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

8. install k8s network plugin flannel
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network
```shell
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
```

9. nodes join
```shell
kubeadm join xxxx --token xxxx --discovery-token-ca-cert-hash xxxx
```
To copy the config file to every node can enable kubectl in nodes
Copy the config file to your own mac/windows and you can access k8s remotely by kubectl.
