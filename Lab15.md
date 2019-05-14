# Lab 15 - The Ceph Dashboard

## Goals

* Enable and Access the Ceph dashboard

## Enable external access

By default the Ceph dashboard service is available only from within the Kubernetes cluster. We can expose this service to the outside world:
```
kubectl -n rook-ceph expose svc rook-ceph-mgr-dashboard --name ceph-dashboard-external --type NodePort
```
The `--type NodePort` will pick a random available external port number to expose the service.

The public IP address of the node and the associated dashboard service port on the node can be extracted from Kubernetes.

```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-ceph get svc ceph-dashboard-external -o jsonpath='{.spec.ports[].nodePort}')
echo "Your dashboard is available at: https://$IP:$PORT/"
```

## Access the Ceph dashboard

The default username is `admin`. The `admin` password can be extracted from the secrets store.

```
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode | sed 's/$/\n/'
```

## Using the Ceph dashboard

Using your laptops web browser, connect to the dashboard URL and login with the admin username and password. The SSL warning can be safely ignored for now.

Click through the dashboard taking note of the available node(s), mon(s), and OSD(s). Keep the dashboard open for the remainder of the workshop.


## Next Steps

Once you're done, proceed to [Lab20](Lab20.md)
