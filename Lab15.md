# Lab 15 - Access the dashboard

## Goals

* Access the Ceph dashboard

## Enable external access

By default the Ceph dashboard service is available only from within the Kubernetes cluster. Therefore we need to expose this service to the outside world:
```
kubectl -n rook-ceph expose svc rook-ceph-mgr-dashboard --name ceph-dashboard-external --type NodePort
```
The `--type NodePort` will pick a random available external port number to expose the service to.

Then you need to find the address of the cluster and the port associated with the dashboard:

```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-ceph get svc ceph-dashboard-external -o jsonpath='{.spec.ports[].nodePort}')
echo "Your dashboard is available at: https://$IP:$PORT/"
```

## Access the Ceph dashboard

Login with the `admin` user and its password can be decoded by the following command:
```
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode | sed 's/$/\n/'
```

## Next Steps

Once you're done, proceed to [Lab20](Lab20.md)
