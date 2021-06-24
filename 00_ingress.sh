echo "--> add helm repo for ingress-nginx"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
echo "--> install nginx-ingress"
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
echo "--> get ingress LB cluster IP"
kubectl get services -A -w |grep ingress
echo "--> deploy certmanager"
kubectl apply -f gke_certmanager_issuer.yaml 

