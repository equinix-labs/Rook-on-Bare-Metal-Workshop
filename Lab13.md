# Lab 12 - Creating a Volume via Rook

## Goals

* Dynamically create a volume via Rook

## Create a CephBlockPool and StorageClass

First we need a Ceph pool, and then a Kubernetes StorageClass.
```
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/cephblockpool.yaml
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/storageclass.yaml
```

Then go in the toolbox container and verify that a ceph pool has been created:
```
rados lspools
```

## Create a PersistentVolume

```
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/pvc.yaml
```
Then verify that your PersistentVolumeClaim has been created with `kubectl get pvc --all-namespaces`

Finally go in the toolbox container and verify that and RBD volume has been created:
```
rbd ls -p replicapool
```
## Next Steps

Once you're done, proceed to [Lab20](Lab20.md)
