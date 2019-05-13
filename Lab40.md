# Lab 40 - Growing your Storage Cluster

## Goals

* Add the second server to your cluster

## Scale the Kubernetes cluster
On the kab master, start by inspecting the `[kube-node]` section of your `~/inventory.ini` file, you should see that the second node is commented out, and therefore doesn't participate in our Kubernetes cluster. Let's fix that by uncommenting the second node.

Now we need to run the `scale.yml` Ansible playbook to apply the changes, that operation takes 10~15 minutes.
```
ansible-playbook -i ~/inventory.ini ~/kubespray/scale.yml
```

## Allocate Storage

As soon as the new server joins the Kubernetes cluster, Rook will collect information about the block devices: size, type, availability, etc...
You can see this happening with the `kubectl --namespace rook-ceph get pods -l app=rook-discover -o wide`

On the *node1*, use `kubectl --namespace rook-ceph edit CephCluster` to edit your cluster config in your favorite `$EDITOR` (`vi` by default, `:q!` to exit :) )

Find the `nodes:` section and add the following:

```
- name: node2
```

Once the new Ceph Cluster configuration is saved use `watch -n1 -d kubectl -n rook-ceph get pods,CephClusters,nodes -o wide` to watch what is happening:

1. Prepare the available block devices
2. Run 1 OSD container for each block device


## Next Steps

Once you're done, proceed to [Lab50](Lab50.md)
