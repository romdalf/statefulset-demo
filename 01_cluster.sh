echo "--> what's in the box?"
echo "kubectl get nodes"
kubectl get nodes 

echo "--> any storageOS in?"
echo "kubectl get pods -A |grep storageos"
kubectl get pods -A |grep storageos