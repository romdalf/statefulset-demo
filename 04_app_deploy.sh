echo "" 
echo "--> create namespace"
echo "kubectl apply -f foodmag-namespace.yaml"
kubectl apply -f foodmag-namespace.yaml
echo "" 
echo "--> deploy back-end DB"
echo "kubectl apply -f foodmag-db-statefulset.yaml"
kubectl apply -f foodmag-db-statefulset.yaml
echo "" 
echo "--> deploy front-end CRM"
echo "kubectl apply -f foodmag-fe-statefulset.yaml"
kubectl apply -f foodmag-fe-statefulset.yaml
echo "" 
echo "--> deploy TLS ingress for CRM"
echo "kubectl apply -f foodmag-fe-statefulset.yaml"
kubectl apply -f foodmag-fe-ingress.yaml