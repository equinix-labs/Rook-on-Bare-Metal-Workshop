# Lab 11 - Ceph Cluster and Toolbox

## Goals

* Deploy the Rook operator
* Use the Rook Toolbox container

## Deploying Rook


Now that Rook is installed we can go ahead and create a Ceph cluster.

```
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/cluster.yaml

# Watch Rook creating pods and initializing your cluster (ctrl+c to exit once mon-a, mon-b and mon-c are Running)
kubectl --namespace rook-ceph get pod --output wide --watch
```

Rook deploys containers with minimal images, we will need a *toolbox* container to have familiars CLI tools like `ceph`, `rbd` and `rados` commonly used for testing and debugging:

```
#  Create toolbox
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/toolbox.yaml

# Wait for the toolbox to be Running
kubectl --namespace rook-ceph get pod -l app=rook-ceph-tools

# Open a terminal on the toolbox
kubectl --namespace rook-ceph exec -it $(kubectl --namespace rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
ceph status

# You can run your usual ceph commands from this container
```


## Next Steps

Once you're done, proceed to [Lab12](Lab12.md)
