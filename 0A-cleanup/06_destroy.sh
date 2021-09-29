echo "" 
echo "--> delete namespace"
echo "kubectl delete namespace foodmag-app"
kubectl delete namespace foodmag-app
echo "" 
echo "--> application status"
echo "kubectl get pods -n foodmag-app"
kubectl get pods -n foodmag-app 
echo "" 
echo "--> check PVC"
echo "kubectl get pvc -A"
kubectl get pvc -A
echo "" 
echo "--> check PVs"
echo "kubectl get pv"
kubectl get pv
echo ""
echo "--> check PVs from storageOS view"
echo "kubectl get pv"
kubectl exec -n kube-system -it cli -- storageos get volumes -n foodmag-app
echo ""
