curl -Lo ketch https://github.com/shipa-corp/ketch/releases/download/v0.2.1/ketch-linux-amd64

chmod +x ketch

kubectl apply --filename https://github.com/jetstack/cert-manager/releases/download/v1.0.3/cert-manager.yaml --validate=false

kubectl --namespace cert-manager rollout status deployment cert-manager

kubectl --namespace cert-manager rollout status deployment cert-manager-webhook

kubectl --namespace cert-manager rollout status deployment cert-manager-cainjector

echo "apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: le 
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: my-account-key
    solvers:
    - http01:
       ingress:
         class: traefik" | kubectl apply --filename -

kubectl apply --filename https://github.com/shipa-corp/ketch/releases/download/v0.2.0/ketch-controller.yaml

kubectl --namespace ketch-system rollout status deployment ketch-controller-manager

sleep 3
