
# Define some colours for later
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "Deploying our first application!"
echo ""
echo -e "--> Sending the yaml definition to Kubernetes..."
echo -e "${BLUE}kubectl apply -f 01-firstapp/nginx.yaml${NC}"
kubectl apply -f nginx.yaml
echo "" 
sleep 10
echo -e "--> Checking the status of the statefulset"
echo -e "${BLUE}kubectl get all -n web${NC}"
kubectl get all -n web
echo ""
echo -e "--> Checking the creation of the PersistentVolumeClaim"
echo -e "${BLUE}kubectl get pvc -A${NC}"
kubectl get pvc -n web
echo "" 
echo -e "--> Checking the creation of the PersistentVolume"
echo -e "${BLUE}kubectl get pv${NC}"
kubectl get pv
echo ""
echo -e "--> Check the PersistentVolume from a StorageOS view"
echo -e "${BLUE}kubectl get pv${NC}"
kubectl exec -n kube-system -it cli -- storageos get volumes -n web
echo ""
echo -e "${BLUE}Simple like A, B, C!${NC}"
