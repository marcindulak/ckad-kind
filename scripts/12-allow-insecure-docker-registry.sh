sudo sh -c 'echo "{ \"insecure-registries\" : [ \"localhost:5000\" ] }" >> /etc/docker/daemon.json'
sudo systemctl restart docker
