# Lab 40 - Growing your Storage Cluster

## Goals

* Add the second server to your cluster

## Scale up the Kubernetes cluster

On the lab master, start by inspecting the `[kube-node]` section of your `~/inventory.ini` file. You'll see that the second node is commented out and therefore hasn't joined our Kubernetes cluster. Uncomment the second node and join it to the cluster.

Now we need to run the `scale.yml` Ansible playbook to apply the changes, that operation takes 10~15 minutes.
```
ansible-playbook -i ~/inventory.ini ~/kubespray/scale.yml
```

## Allocate Storage

As soon as the new server joins the Kubernetes cluster, Rook will collect information about the block devices: size, type, availability, etc...
You can see this happening with the `kubectl --namespace rook-ceph get pods -l app=rook-discover -o wide`

On *node1*, use `kubectl --namespace rook-ceph edit CephCluster` to edit your cluster config in your favorite `$EDITOR` (`vi` by default, `:q!` to exit :) )

Find the `nodes:` section and add the following:

```
- name: node2
```

Once the new Ceph Cluster configuration is saved use `watch -n1 -d kubectl -n rook-ceph get pods,CephClusters,nodes -o wide` to watch what is happening. You'll see the following happen:

1. Prepare the available block devices
2. Run 1 OSD container for each block device

Use ctrl-c to exit the watch once your cluster is in `Created` state and `HEALTH_OK`.

## Increase replicas

Back in [Lab13](Lab13.md) we created a pool with replica size 1. Now that we have added a second server to the cluster it's time to increase the replica count. Use the `kubectl -n rook-ceph edit CephBlockPools` command to edit the size of the pool from `size: 1` to `size: 2`.

You can then do a `watch -n1 -d ceph status` in the Toolbox shell to wait for the rebalancing.

Use ctrl-c to exit the watch.

## Next Steps

Once you're done, proceed to [Lab50](Lab50.md)
