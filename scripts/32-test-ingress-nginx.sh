if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

if ! test -r usage.yaml;
then
   curl -sLO https://github.com/kubernetes-sigs/kind/raw/2ded0ec1a195a3259b8dfe9b92f523ddf53a4a0d/site/static/examples/ingress/usage.yaml
   kubectl apply -f usage.yaml
   sleep 10
   curl -v -k https://localhost | 404
   curl localhost/foo | grep foo
   curl localhost/bar | grep bar
   kubectl delete -f usage.yaml
fi
