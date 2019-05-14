# Lab 90 - Rolling upgrade of Ceph

## Goals

* Upgrade from Ceph Mimic to Ceph Luminous


## Upgrade Ceph

In [Lab11](Lab11.md) we deployed Ceph Mimic (v13.2.5), we will upgrade to Ceph Nautilus.
To do that we need to change the image used by our Ceph cluster from `image: ceph/ceph:v13.2.5-20190410` to `image: ceph/ceph:v14.2.1-20190430`

```
kubectl -n rook-ceph edit CephCluster rook-ceph
```

Then we can watch Rook work, wait until your cluster goes from `Updating` to `Created` state.
```
watch -n 1 -d kubectl -n rook-ceph get CephClusters,deployments,pods -o wide
```

Rook will upgrade Ceph mons one at a time, then Ceph mgrs, then Ceph OSDs.

## Verify the cluster health

Run a `ceph status` in the toolbox to verify that the cluster is healthy and upgraded.

## Next Steps

Congratulations you are done with the workshop.
