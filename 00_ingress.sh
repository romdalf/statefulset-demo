echo "Preparing the cluster with Ingress for TLS endpoint"
echo "" 
echo "--> add helm repo for ingress-nginx"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
echo "--> install nginx-ingress"
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
echo "--> get ingress LB cluster IP"
kubectl get services -A -w |grep ingress
echo "--> install cert-manager"
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0 --set installCRDs=true
echo "--> deploy certmanager"
kubectl apply -f gke_certmanager_issuer.yaml 
echo "" 

