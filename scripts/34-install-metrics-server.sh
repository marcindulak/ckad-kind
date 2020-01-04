if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

if ! test -d metrics-server;
then
    git clone https://github.com/kubernetes-sigs/metrics-server --branch v0.3.6 --single-branch
    mv metrics-server/deploy/1.8+ .
    rm -rf metrics-server
    mkdir -p metrics-server/deploy
    mv 1.8+ metrics-server/deploy
fi

kubectl apply -f metrics-server/deploy/1.8+
kubectl -n kube-system patch deployment metrics-server -p "$(cat metrics-server-patch.yaml)"
sleep 120
