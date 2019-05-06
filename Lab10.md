# Lab 10 - Deploying Rook

## Goals

* Deploy the Rook operator
* Use the Rook Toolbox container

## Deploying Rook

SSH into the kube-master and install Rook
```
# Install the Rook Kubernetes Operator
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/common.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/operator.yaml


kubectl --namespace rook-ceph get pods --watch
# Check that all Pods are 'Running 1/1'
```


## Next Steps

Once you're done, proceed to [Lab11](Lab11.md)
