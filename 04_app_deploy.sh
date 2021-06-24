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
echo ""
echo "--> application status"
echo "kubectl get pods -n foodmag-app"
kubectl get pods -n foodmag-app -w
echo ""
echo "--> check PVC"
echo "kubectl get pvc -A"
kubectl get pvc -A
echo "" 
echo "--> check PVs"
echo "kubectl get pv"
kubectl get pv
echo ""