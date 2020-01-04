if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

if ! test -r mandatory.yaml;
then
   curl -sLO https://github.com/kubernetes/ingress-nginx/raw/aba58d67f23ffe84570ce3d993fde1b051391f2f/deploy/static/mandatory.yaml
   kubectl apply -f mandatory.yaml
   kubectl -n ingress-nginx patch deployment nginx-ingress-controller -p "$(cat nginx-ingress-controller-patch.yaml)"
   sleep 600
   kubectl -n ingress-nginx get pod -l "app.kubernetes.io/name=ingress-nginx" | grep Running
fi
