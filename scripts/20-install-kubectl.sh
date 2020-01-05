if ! test -x ./kubectl;
then
    curl -sLO https://storage.googleapis.com/kubernetes-release/release/v1.16.3/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo cp -p ./kubectl /usr/local/bin/kubectl
    kubectl config view
fi
