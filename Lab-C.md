# Lab C - Allocating Storage

## Goals

* Deploy and configure a CephCluster with Rook

## Allocate Storage

On the *kube-master*, use `kubectl --namespace rook-ceph describe CephCluster` to read your Ceph Cluster config, and then `kubectl --namespace rook-ceph edit CephCluster` to edit your cluster config in your favorite `$EDITOR` (`vi` by default, `:q!` to exit :) )

Find the `useAllDevices: false` configuration entry and switch it to `true` in order to format all unformatted drives in the Kubernetes cluster.

Once the new Ceph Cluster configuration is saved use `kubectl --namespace rook-ceph get pod --output wide --watch` to watch what is happening:

1. Rook will discover available block devices on each node
2. Prepare the available block devices
3. Run 1 OSD container for each block device

TODO:
- Pin Ceph image
- hostNetwork: true?
- allowMultiplePerNode: false?
- useAllDevices or directories
- Ceph dashboard
- Prometheus

## Next Steps

Once you're done, proceed to [Lab-D](Lab-D.md)
