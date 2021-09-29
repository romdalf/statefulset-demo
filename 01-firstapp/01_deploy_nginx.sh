echo "Deploying our first application!"
echo ""
echo "--> Sending the yaml definition to Kubernetes..."
echo "kubectl apply -f nginx.yaml"
kubectl apply -f nginx.yaml
echo "" 
echo "--> Checking the status of the statefulset"
echo "kubectl get all -n web"
kubectl get all -n web
echo ""
echo "--> Checking the creation of the PersistentVolumeClaim"
echo "kubectl get pvc -A"
kubectl get pvc -n web
echo "" 
echo "--> Checking the creation of the PersistentVolume"
echo "kubectl get pv"
kubectl get pv
echo ""
echo "--> Check the PersistentVolume from a StorageOS view"
echo "kubectl get pv"
kubectl exec -n kube-system -it cli -- storageos get volumes -n web
echo ""
echo "Simple like A, B, C!"
