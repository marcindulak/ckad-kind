if [[ "$(basename $(pwd))" != "kind-registry" ]];
then
    echo "error: this script must be run from the 'kind-registry' directory"
    exit 1
fi

env | sort | grep KUBECONFIG
KIND_CLUSTER_NAME=ckad-registry bash kind-with-registry.sh
ls -al .kube
kubectl cluster-info
kubectl get nodes

ip_fmt='{{.NetworkSettings.IPAddress}}'
cmd="echo $(docker inspect -f "${ip_fmt}" "kind-registry") registry >> /etc/hosts"
for node in $(kind get nodes --name ckad); do
  docker exec "${node}" sh -c "${cmd}"
done
