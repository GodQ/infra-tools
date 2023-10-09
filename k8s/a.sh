# The script returns a kubeconfig for the service account given
# you need to have kubectl on PATH with the context set to the cluster you want to create the config for

# Cosmetics for the created config
clusterName=a
# your server address goes here get it via `kubectl cluster-info`
server=https://10.89.99.102:6443
# the Namespace and ServiceAccount name that is used for the config
namespace=kube-system
serviceAccount=my-admin-service-account

######################
# actual script starts
set -o errexit

# Create a clusteradmin sa
echo "

apiVersion: v1
kind: ServiceAccount
metadata:
  name: $serviceAccount
  namespace: $namespace
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: my-admin-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: $serviceAccount
  namespace: $namespace

" > sa.yaml
kubectl apply -f sa.yaml
echo "cluster-admin sa($serviceAccount) created"

echo "kubectl --namespace $namespace get sa $serviceAccount -o jsonpath='{.secrets[0].name}'"
secretName=$(kubectl --namespace $namespace get sa $serviceAccount -o jsonpath='{.secrets[0].name}')
echo "$secretName"
ca=$(kubectl --namespace $namespace get secret/$secretName -o jsonpath='{.data.ca\.crt}')
token=$(kubectl --namespace $namespace get secret/$secretName -o jsonpath='{.data.token}' | base64 --decode)
echo "Token:"
echo "$token"

echo "
---
apiVersion: v1
kind: Config
clusters:
  - name: ${clusterName}
    cluster:
      certificate-authority-data: ${ca}
      server: ${server}
contexts:
  - name: ${serviceAccount}@${clusterName}
    context:
      cluster: ${clusterName}
      namespace: ${namespace}
      user: ${serviceAccount}
users:
  - name: ${serviceAccount}
    user:
      token: ${token}
current-context: ${serviceAccount}@${clusterName}
" > $clusterName.txt
