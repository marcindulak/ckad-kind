if [[ "$(basename $(pwd))" != "kind-registry" ]];
then
    echo "error: this script must be run from the 'kind-registry' directory"
    exit 1
fi

kind delete cluster --name ckad-registry
