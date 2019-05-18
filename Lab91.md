# Lab 91 - Improving Storage Resilience

## Goals

* Reconfigure the storage cluster to increase resilience

## Increase Storage

Increase the amount of available storage.
* Add a file store to node2 to utilize the boot disk for Ceph (cluster-master-only.yml)
* Increase the spec.repliated.size to 3 to better utilize available drives (cephblockpool.yaml)
* Change failureDomain to osd to better utilize available drives (cephblockpool.yaml).  See https://rook.io/docs/rook/v1.0/ceph-pool-crd.html

## Deploy Application

Deploy the Wordpress/MySQL application across this newly configured Rook cluster. Examine the deployment via the Ceph Web GUI and Toolbox.

## Next Steps

Once you're done, proceed to [Lab92](Lab92.md)
