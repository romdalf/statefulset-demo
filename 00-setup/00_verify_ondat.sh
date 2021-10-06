#!/bin/bash
#############################################################################
# Script Name  :   00_verify_ondat.sh                                                                                           
# Description  :   Provide a view of the Kubernetes environment                                                                              
# Args         :   
# Author       :   Ondat
# Issues       :   Issues&PR https://github.com/rovandep/statefulset-demo.git
#############################################################################

set -euo pipefail

# Define some colours for later
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# spin the wheel to avoid nervous breakdown during waiting time
sp="/-\|"
spin() {
    printf '\b%.1s' "$sp"
    sp=${sp#?}${sp%???}
}
endspin() {
    echo -ne '\b \b'
}

echo 
echo -e "${NC}Verify Kubernetes environment to deploy ${BLUE}Ondat${NC} data plane."
# Checking for the minimum node count (3)
echo -ne "  Checking node count (minimum 3)......................."
NODECOUNT=`kubectl get nodes -o name | wc -l`
if [ ${NODECOUNT} -lt 3 ]
then 
    echo -ne "${RED}NOK${NC}\n" 
    exit
fi 
echo -ne ".${GREEN}OK${NC} (${RED}${NODECOUNT}${NC})\n"

# Checking for the k8s version
echo -ne "  Checking Kubernetes version..........................."
NODEVERSION=`kubectl get nodes -o jsonpath='{.items[]..kubeletVersion}'`
if [[ ${NODEVERSION} =~ "22" ]]
then 
    echo -ne "${RED}NOK${NC} - k8s ${RED}${NODEVERSION}${NC} requires Ondat 2.5\n" 
    exit
fi 
echo -ne ".${GREEN}OK${NC} (${RED}${NODEVERSION}${NC})\n"
echo -e "   CLI: ${BLUE}kubectl get nodes${NC}"

# Checking for an existing Ondat cluster on the kubernetes target
echo -ne "  Checking for exiting ${BLUE}Ondat${NC} cluster...................."
if kubectl get storageoscluster --all-namespaces -o name &>/dev/null;
then
    echo -ne "${RED}YES${NC}\n"
    echo -e "  ${RED}/!\ ${NC}${BLUE}Ondat${NC} cluster${RED} already deployed on this Kubernetes cluster."
    echo
    exit
    # todo: include a clean-up option from this breaking point
else 
    echo -ne ".${GREEN}NO${NC}\n"
fi
echo -e "   CLI: ${BLUE}kubectl get storageoscluster --all-namespaces -o name${NC}"

