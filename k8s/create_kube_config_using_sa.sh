# your server name goes here
server=https://10.110.126.11:6443
# the name of the secret containing the service account token goes here
name=default
kubectl_cmd="kubectl --kubeconfig /Users/chuanhaoq/Desktop/bugbash/sh-config.yaml "

ca=$($kubectl_cmd get secret/$name -o jsonpath='{.data.ca\.crt}')
echo $ca
token=$($kubectl_cmd get secret/$name -o jsonpath='{.data.token}' | base64 --decode)
echo $token
namespace=$($kubectl_cmd get secret/$name -o jsonpath='{.data.namespace}' | base64 --decode)
echo $namespace

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > sa_kubeconfig