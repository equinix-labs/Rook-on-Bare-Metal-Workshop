# Lab 40 - Growing your Storage Cluster

## Goals

* Add the second server to your cluster

## Background

The current Kubernetes cluster consists of a single physical host with a single SSD drive. A second physical host is available as part of your lab environment for you to use. This second physical host has several SSD drives which will allow Rook and Ceph to grow out the clusters storage capabilities.

## Scale up the Kubernetes cluster

On the lab master, start by inspecting the `[kube-node]` section of your `~/inventory.ini` file. You'll see that the second node (node2) is commented out and wasn't added to the Kubernetes cluster when the Ansible playbooks were run.

Uncomment the second node (node2) in the `~/inventory.ini`
```
vi ~/inventory.ini
```

Now we need to run the `scale.yml` Ansible playbook to apply the changes, that operation takes 10~15 minutes. Leave this running and start up a new terminal.
```
ansible-playbook -i ~/inventory.ini ~/kubespray/scale.yml
```

## Examine Bare Metal Storage

In a new terminal session on the lab master, we're going to look deeper at the available storage on the provided bare metal infrastructure.

We can list out all the SSD drives available on node2.
```
ssh node2 fdisk -l | egrep "^Disk /dev/sd"
```
You'll see that there are a number of drives available for use. One of those drives is allocated as a boot drive (with a file system) and the rest are unallocated and available for use by Rook and Ceph.

You can compare this to the existing node we've been using. As you can see, node1 just has a single drive (boot drive).
```
ssh node1 fdisk -l | egrep "^Disk /dev/sd"
```

## Allocate Storage

As soon as the new server joins the Kubernetes cluster, Rook will collect information about the block devices: size, type, availability, etc...
You can see this happening with the `kubectl --namespace rook-ceph get pods -l app=rook-discover -o wide`

On *node1*, use `kubectl --namespace rook-ceph edit CephCluster` to edit your cluster config in your favorite `$EDITOR` (`vi` by default, `:wq` to save and exit :) )

Find the `nodes:` section and add the following right under the line `name: node1` in spec.storage.nodes.

```
- name: node2
```

Once the new Ceph Cluster configuration is saved use `watch -n1 -d kubectl -n rook-ceph get pods,CephClusters,nodes -o wide` to watch what is happening. You'll see the following happen:

1. Prepare the available block devices
2. Run 1 OSD container for each block device

Use ctrl-c to exit the watch once your cluster is in `Created` state.

You might notice that the cluster is now in `HEALTH_WARN`, a `ceph status` should show that 1/4 mons is down. Indeed Rook used the second server to spread mons, but didn't cleanup the old mon just yet. Let's do that in the Toobox container with `ceph mon remove a`.
 Now your Ceph cluster should report `HEALTH_OK`.

## Increase replicas

Our environment is currently set with replica size 1 since we only had a single node. Now that we have added a second server to the cluster it's time to increase the replica count. Use the `kubectl -n rook-ceph edit CephBlockPools` command to edit the size of the pool from `size: 1` to `size: 2`.

You can then do a `watch -n1 -d ceph status` in the Toolbox shell to wait for the rebalancing.

Use ctrl-c to exit the watch.

## Next Steps

Once you're done, proceed to [Lab60](Lab60.md)
