# Lab 14 - Creating a Volume via Rook

## Goals

* Dynamically create a volume via Rook

## Create a CephBlockPool and StorageClass

First we need a Ceph pool, and then a Kubernetes StorageClass.
```
kubectl apply -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/cephblockpool.yaml
kubectl apply -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/storageclass.yaml
```

Use `kubectl describe -n rook-ceph CephBlockPools` and `kubectl describe -n rook-ceph StorageClass` to inspect the configurations. Note that the pool is configured with 1 replica since it currently has only 1 OSD.

Then go in the toolbox container and verify that a ceph pool has been created:
```
rados lspools
```

## Create a PersistentVolume

```
kubectl apply -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/pvc.yml
```
Then verify that your PersistentVolumeClaim has been created with `kubectl get pvc --watch`, and wait for the volume to go into `Bound` status.

Finally go in the toolbox container and verify that a RBD volume has been created:
```
rbd ls -p replicapool
```

You can also verify in the Ceph dashboard that the newly created volume is visible

## Next Steps

Once you're done, proceed to [Lab15](Lab15.md)
