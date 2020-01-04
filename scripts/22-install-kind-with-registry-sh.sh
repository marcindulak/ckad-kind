if [[ "$(basename $(pwd))" != "kind-registry" ]];
then
    echo "error: this script must be run from the 'kind-registry' directory"
    exit 1
fi

if ! test -r kind-with-registry.sh;
then
    curl -sLO https://github.com/kubernetes-sigs/kind/raw/2ded0ec1a195a3259b8dfe9b92f523ddf53a4a0d/site/static/examples/kind-with-registry.sh
fi
