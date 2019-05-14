# Lab 11 - Small Ceph Cluster Setup

## Goals

* Start up a Ceph cluster using Rook
* Examine cluster configuration and deployed artifacts

## Deploying a Ceph Cluster

Now that Rook is installed we can go ahead and create a Ceph cluster.

Take a look at the ["master-only" cluster configuration](configs/cluster-master-only.yml). Take note of:
* spec.storage.node.names
* spec.storage.node.names.path

Start up the single node cluster using this configuration file. This will configure a small cluster using the single node and the single data directory.
```
kubectl create -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/cluster-master-only.yml
```

Watch Rook creating pods and initializing your cluster.
```
watch -n 1 -d kubectl get CephClusters,deployments,pods --all-namespaces
```

Press ctrl-c to exit once you see that your cluster is `Created` state and in `HEALTH_OK`.

## Examine Cluster

Take a look in the Rook data directory on the file system and see that Rook files are in place.

```
kubectl get CephClusters --namespace rook-ceph
ls /var/lib/rook
```

## Next Steps

Once you're done, proceed to [Lab12](Lab12.md)
