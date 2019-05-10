# Lab 15 - Access the dashboard

## Goals

* Access the Ceph dashboard

## Access the Ceph dashboard

First you need to find the address of the cluster:
```
IP=$(kubectl get nodes -o jsonpath ...)
echo "Your dashboard is available at: http://$IP/ceph-dashboard"
```

Login with the `admin` user and its password can be decoded by the following command:
```
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode | sed 's/$/\n/'
```

## Next Steps

Once you're done, proceed to [Lab20](Lab20.md)
