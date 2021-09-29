

# Define some colours for later
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo ""
echo -e "--> what's in the box?"
echo -e "${BLUE}kubectl get nodes${NC}"
kubectl get nodes
echo ""
echo -e "--> any storageOS in?"
echo -e "${BLUE}kubectl get all -A |grep storageos${NC}"
kubectl get all -A |grep storageos
echo ""