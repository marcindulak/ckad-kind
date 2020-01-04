if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

if ! test -r calico.yaml;
then
   curl -sLO https://docs.projectcalico.org/v3.11/manifests/calico.yaml
   kubectl apply -f calico.yaml
   sleep 300
   kubectl get nodes | grep -v NotReady
fi
