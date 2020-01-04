if [[ "$(basename $(pwd))" != "manifests" ]];
then
    echo "error: this script must be run from the 'manifests' directory"
    exit 1
fi

kubectl run nginx-on-nodeport --image=nginx --restart=Never --port=80 --labels="app=nginx-on-nodeport"
kubectl create service nodeport nginx-on-nodeport --tcp=80:80 --node-port=31080
sleep 120
docker exec -it ckad-control-plane sh -c "curl localhost:31080" | grep nginx
kubectl delete service nginx-on-nodeport
kubectl delete pod nginx-on-nodeport
