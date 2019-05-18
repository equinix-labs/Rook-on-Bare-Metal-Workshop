# Lab 12 - Ceph Toolbox

## Goals

* Start up the Ceph Toolbox container
* Access and play with the Ceph Toolbox

## Deploy Ceph Toolbox

Rook deploys containers with minimal images, we will need a *toolbox* container to have familiars CLI tools like `ceph`, `rbd` and `rados` commonly used for testing and debugging:

```
#  Create toolbox
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/toolbox.yaml

# Wait for the toolbox to be Running
kubectl --namespace rook-ceph get pod -l app=rook-ceph-tools
```


## Use Ceph Toolbox

### Open a terminal on the toolbox
```
kubectl --namespace rook-ceph exec -it $(kubectl --namespace rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
```

### Execute toolbox commands within the toolbox
```
ceph status
ceph osd status
ceph df
rados df
```

### Exit out of the toolbox
```
exit
```

## Next Steps

Once you're done, proceed to [Lab14](Lab13.md)
