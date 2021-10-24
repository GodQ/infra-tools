#curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh -o install-k3s.sh

#INSTALL_K3S_MIRROR=cn INSTALL_K3S_EXEC="--docker --disable-agent --write-kubeconfig ~/.kube/config" bash install-k3s.sh


curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn INSTALL_K3S_EXEC="--docker --write-kubeconfig ~/.kube/config --tls-san 10.0.1.10 --tls-san aaa.com" sh - server
