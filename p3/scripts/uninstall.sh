sudo kubectl delete pods --all -n argocd
sudo kubectl delete deployments --all -n argocd
sudo kubectl delete services --all -n argocd
sudo k3d cluster delete --all

sudo rm /usr/local/bin/k3d

dpkg -l | grep -i docker
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /var/lib/containerd
sudo rm -r ~/.docker
sudo rm -rf /usr/local/bin/docker-compose
