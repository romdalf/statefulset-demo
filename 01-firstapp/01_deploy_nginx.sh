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
kubectl apply -f 01-firstapp/nginx_npv.yaml 1>/dev/null
echo -ne ".${GREEN}OK${NC}\n"
echo -e "   CLI: ${BLUE}kubectl apply -f 01-firstapp/nginx_npv.yaml${NC}"
echo -e "   Content of ${BLUE}nginx_npv.yaml${NC}
            ${YELLOW}---
            apiVersion: v1
            kind: Namespace
            metadata:
              name: web-npv
            ---
            apiVersion: v1
            kind: Service
            metadata:
              name: web-npv-service
              namespace: web-npv
              labels:
                app: nginx
            spec:
              type: ClusterIP
              ports:
              - port: 80
              selector:
                app: nginx
            ---
            apiVersion: apps/v1
            ${RED}kind: Deployment${YELLOW}
            metadata:
              name: web
              namespace: web-npv
            spec:
              selector:
                matchLabels:
                  app: nginx
              replicas: 1
              template:
                metadata:
                  labels:
                    app: nginx
                spec:
                  containers:
                    - name: nginx
                      image: k8s.gcr.io/nginx-slim:0.8
                      ports:
                        - containerPort: 80${NC}"

echo -ne "  Deploying web server with ${BLUE}Ondat${NC} persistent volume...................."
kubectl apply -f 01-firstapp/nginx_wepv.yaml 1>/dev/null
echo -ne ".${GREEN}OK${NC}\n"
echo -e "   CLI: ${BLUE}kubectl apply -f 01-firstapp/nginx_wpv.yaml${NC}"
echo -e "   Content of ${BLUE}nginx_wpv.yaml${NC}
            ${YELLOW}---
            apiVersion: v1
            kind: Namespace
            metadata:
              name: web-wpv
            ---
            apiVersion: v1
            kind: Service
            metadata:
              name: web-wpv-service
              namespace: web-wpv
              labels:
                app: nginx
            spec:
              type: ClusterIP
              ports:
              - port: 80
              selector:
                app: nginx
            ---
            apiVersion: apps/v1
            ${BLUE}kind: StatefulSet${YELLOW}
            metadata:
              name: web
              namespace: web-wpv
            spec:
              selector:
                matchLabels:
                  app: nginx
              serviceName: web-wpv-service
              replicas: 1
              template:
                metadata:
                  labels:
                    app: nginx
                spec:
                  terminationGracePeriodSeconds: 10
                  containers:
                    - name: nginx
                      image: k8s.gcr.io/nginx-slim:0.8
                      ports:
                        - containerPort: 80
                      ${BLUE}volumeMounts:
                        - name: nginx-pvc
                          mountPath: /usr/share/nginx/html
              volumeClaimTemplates:
                - metadata:
                    name: nginx-pvc
                  spec:
                    accessModes: ["ReadWriteOnce"]
                    storageClassName: "fast"
                    resources:
                      requests:
                        storage: 1Gi${NC}
"


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
