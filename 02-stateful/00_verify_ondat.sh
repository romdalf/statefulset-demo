

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
echo -e "--> any ${BLUE}Ondat${NC} in?"
echo -e "${BLUE}kubectl get all -A |grep storageos${NC}"
kubectl get all -A |grep storageos
echo ""

string="web-npv is not using Ondat for persistent data"
if curl -s http://localhost:8001/api/v1/namespaces/web-npv/services/http:web-npv-service:/proxy/ | grep -q "$string"; then
        echo -e "${BLUE}All good for web-npv!${NC}"
        exit
else
        fail-message "${RED}The web-npv string is not present. Review the steps to fix the web message.${NC}"
fi

string="web-wpv is using Ondat for persistent data"
if curl -s http://localhost:8001/api/v1/namespaces/web-wpv/services/http:web-wpv-service:/proxy/ | grep -q "$string"; then
        echo -e "${BLUE}All good for web-npv!${NC}"
        exit
else
        fail-message "${RED}The web-wpv string is not present. Review the steps to fix the web message.${NC}"
fi