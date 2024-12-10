curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker $USER

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo chmod +x /usr/local/bin/k3d

k3d cluster create iot --api-port 6443 -p 8080:80@loadbalancer --agents 2 --wait

sudo kubectl create namespace argocd
sudo kubectl create namespace dev

sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl apply -f k3s-configMap-serverInsecureFix.yaml -n argocd

sudo kubectl apply -f application.yaml
sudo kubectl apply -f appProject.yaml
sudo kubectl apply -f rbac.yaml


sudo kubectl rollout restart -n argocd deployment argocd-server
sudo kubectl rollout restart -n argocd statefulset argocd-application-controller


