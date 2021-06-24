echo "--> what's in the box?"
echo "kubectl get nodes -o wide"
kubectl get nodes -o wide 

echo "--> any storageOS in?"
echo "kubectl get pods -A |grep storageos"
kubectl get pods -A |grep storageos