if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

kubectl top node | grep -E 'CPU|ckad'
