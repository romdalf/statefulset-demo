#!/bin/bash
#############################################################################
# Script Name  :   01_deploy_nginx.sh                                                                                           
# Description  :   Deploy two flavor of a web server based on NGINX                                                                              
# Args         :   
# Issues       :   Issues&PR https://github.com/rovandep/statefulset-demo.git
#############################################################################

set -euo pipefail

# Define some colours for later
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# Checking for an existing Ondat cluster on the kubernetes target
echo -ne "  Checking for exiting ${BLUE}Ondat${NC} cluster...................."
if kubectl get storageoscluster --all-namespaces -o name &>/dev/null;
then
    echo -ne ".${GREEN}YES${NC}\n"

else 
    echo -ne "${RED}NO${NC}\n"
    echo -e "  ${RED}/!\ ${NC}${BLUE}Ondat${NC} cluster${RED} is not deployed on this Kubernetes cluster."
    echo
    exit
fi
echo -e "   CLI: ${BLUE}kubectl get storageoscluster --all-namespaces -o name${NC}"
 
echo -ne "  Deploying web server without ${BLUE}Ondat${NC} persistent volume...................."
kubectl apply -f 01-firstapp/nginx_npv.yaml
echo -ne ".${GREEN}OK${NC}\n"
echo -e "   CLI: ${BLUE}kubectl apply -f 01-firstapp/nginx_npv.yaml${NC}"


echo -ne "  Deploying web server with ${BLUE}Ondat${NC} persistent volume...................."


# echo -e "Deploying our first application!"
# echo ""
# echo -e "${RED}web application without persistent volume${NC}"
# echo ""
# echo -e "--> Sending nginx_npv.yaml to Kubernetes..."
# echo -e "${BLUE}kubectl apply -f 01-firstapp/nginx_npv.yaml${NC}"
# kubectl apply -f 01-firstapp/nginx_npv.yaml
# echo ""
# echo -e "--> waiting 10 seconds..."
# sleep 15
# echo ""
# echo -e "--> Checking the status of the statefulset..."
# echo -e "${BLUE}kubectl get all -n web-npv${NC}"
# kubectl get all -n web-npv 
# echo ""
# echo -e "${RED}---------------------------------------------------${NC}"
# echo ""
# echo -e "${RED}web application with persistent volume${NC}"
# echo ""
# echo -e "--> Sending nginx_wpv.yaml to Kubernetes..."
# echo -e "${BLUE}kubectl apply -f 01-firstapp/nginx_wpv.yaml${NC}"
# kubectl apply -f 01-firstapp/nginx_wpv.yaml
# echo ""
# echo -e "--> waiting 10 seconds..."
# sleep 15
# echo ""
# echo -e "--> Checking the status of the statefulset..."
# echo -e "${BLUE}kubectl get all -n web-npv${NC}"
# kubectl get all -n web-wpv 



# echo -e "--> Checking the status of the statefulset"
# echo -e "${BLUE}kubectl get all -n web${NC}"
# kubectl get all -n web
# echo ""
# echo -e "--> Checking the creation of the PersistentVolumeClaim"
# echo -e "${BLUE}kubectl get pvc -A${NC}"
# kubectl get pvc -n web
# echo "" 
# echo -e "--> Checking the creation of the PersistentVolume"
# echo -e "${BLUE}kubectl get pv${NC}"
# kubectl get pv
# echo ""
# echo -e "--> Check the PersistentVolume from a StorageOS view"
# echo -e "${BLUE}kubectl get pv${NC}"
# kubectl exec -n kube-system -it cli -- storageos get volumes -n web
# echo ""
# echo -e "${BLUE}Simple like A, B, C!${NC}"
