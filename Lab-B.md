# Lab B - Deploying Rook

## Background



## Deploying Rook

First lets download Rook's latest stable version on the *kube-master*
```
git clone https://github.com/rook/rook.git
cd rook
git checkout v0.9.3
cd cluster/examples/kubernetes/ceph
```

Then we're ready to install Rook
```
# Install the Rook Kubernetes Operator
kubectl create -f operator.yaml

kubectl --namespace rook-ceph-system get pods
# Check that all Pods are 'Running 1/1'
```

Now that Rook is installed we can go ahead and create a Ceph cluster.

```
wget .../ceph-cluster.yaml
kubectl apply -f ceph-cluster.yaml

# Watch Rook creating pods and initializing your cluster (ctrl+c to exit once mon-a, mon-b and mon-c are Running)
kubectl --namespace rook-ceph get pod --watch
```

Rook deploys containers with minimal images, we will need a *toolbox* container to have familiars CLI tools like `ceph`, `rbd` and `rados` commonly used for testing and debugging:

```
#  Create toolbox
kubectl apply -f toolbox.yaml

# Wait for the toolbox to be Running
kubectl --namespace rook-ceph get pod -l app=rook-ceph-tools

# Open a terminal on the toolbox
kubectl --namespace rook-ceph exec -it $(kubectl --namespace rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
ceph status
```


## Next Steps

Once you're done, proceed to [Lab-C](Lab-C.md)
