# Lab 21 - Failure Handling

## Goals

* Simulate failures and examine how Rook handles them

## Terminate OSD instance

Open two terminal windows on `node1`, in the first one run `watch -n1 -d kubectl -n rook-ceph get pods` to monitor your cluster, then in the second one, run `pkill -9 ceph-osd` to kill the OSD.

Rook will restart the OSD and your cluster will be back to healthy.

## Terminate MySQL instance

In the first window now run `watch -n1 -d kubectl get pods` to monitor your wordpress setup, and in the second window run `kubectl delete pod -l tier=mysql` to delete the mysql pod.
Kubernetes will detect that and rectify.

## Next Steps

Once you're done, proceed to [Lab22](Lab22.md)
