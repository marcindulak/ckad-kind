if [[ "$(basename $(pwd))" != "kind" ]];
then
    echo "error: this script must be run from the 'kind' directory"
    exit 1
fi

env | sort | grep KUBECONFIG
readlink -f $KUBECONFIG
kind create cluster --name ckad --image kindest/node:v1.16.3 --config kind.config.yaml
test -r $KUBECONFIG
kubectl cluster-info
kubectl get nodes --no-headers | grep -v " Ready"
