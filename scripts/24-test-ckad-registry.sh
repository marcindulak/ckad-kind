if [[ "$(basename $(pwd))" != "kind-registry" ]];
then
    echo "error: this script must be run from the 'kind-registry' directory"
    exit 1
fi

docker pull gcr.io/google-samples/hello-app:1.0
docker tag gcr.io/google-samples/hello-app:1.0 localhost:5000/hello-app:1.0
docker push localhost:5000/hello-app:1.0
docker exec -it ckad-registry-control-plane bash -c "cat /etc/containerd/config.toml"
docker exec -it ckad-registry-control-plane bash -c "containerd -v"
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-registry
docker exec -it ckad-registry-control-plane bash -c "cat /etc/hosts | grep registry"
docker exec -it ckad-registry-control-plane bash -c "ctr image pull registry:5000/hello-app:1.0"
