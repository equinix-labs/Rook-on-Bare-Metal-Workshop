# Lab 40 - Rolling upgrade of Ceph

## Goals

* Upgrade from Ceph Mimic to Ceph Luminous


## Upgrade Ceph

In [Lab11](Lab11.md) we deployed Ceph Mimic (v13.2.5) and now we will upgrade to Ceph Nautilus.
To do that we need to change the image used by our Ceph cluster from `image: ceph/ceph:v13.2.5-20190410` to `image: ceph/ceph:v14....`

```
kubectl -n rook-ceph edit CephCluster rook-ceph
```

Then we can watch Rook work
```
watch -n 1 -d kubectl -n rook-ceph get CephClusters,deployments,pods
```

## Next Steps

Once you're done, proceed to [Lab60](Lab60.md)
