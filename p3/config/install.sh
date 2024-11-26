sudo apt-get update
sudo apt-get upgrade

curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker $USER

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo chmod +x /usr/local/bin/k3d
k3d cluster create iot --api-port 6443 -p 8080:80@loadbalancer

echo "alias k ='kubectl'" >> /home/fcody/.bashrc

k create namespace argocd
k create namespace dev

k apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
k apply -f k3s-configMap-serverInsecureFix.yaml -n argocd

k rollout restart -n argocd deployment argocd-server
k rollout restart -n argocd statefulset argocd-application-controller


