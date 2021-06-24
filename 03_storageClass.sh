echo "--> current storageclass"
echo "kubectl get nodes"
kubectl get storageclass 
echo "" 
echo "--> deploy storageOS storageClass / 0 replica / encryption off"
echo "kubectl apply -f storageClass_basic.yml"
kubectl apply -f storageClass_basic.yml
echo "" 
echo "--> deploy storageOS storageClass / 1 replica / encryption on"
echo "kubectl apply -f storageClass_basic.yml"
kubectl apply -f storageClass_rep1_encryption.yml