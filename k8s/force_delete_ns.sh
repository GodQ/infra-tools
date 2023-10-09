#kubectl create ns test

ns="test"

kubectl get ns $ns -o json > tmp.json

echo "Please 1. delete finalizers in file tmp.json"
echo "       2. run 'kubectl proxy --port=8081' in another terminal "
echo "       3. press Enter"

read -r a

curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json http://127.0.0.1:8001/api/v1/namespaces/$ns/finalize

rm tmp.json

kubectl get ns
