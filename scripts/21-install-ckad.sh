if [[ "$(basename $(pwd))" != "kind" ]];
then
    echo "error: this script must be run from the 'kind' directory"
    exit 1
fi

kind create cluster --name ckad --image kindest/node:v1.16.1 --config kind.config.yaml
