# Lab 10 - Deploying Rook

## Goals

* Deploy and verify that the the Rook operator is installed
* Use the Rook Toolbox container

## Deploying Rook

SSH into the kube-master and deploy the Rook operator.

```
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/common.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/operator.yaml
```

## Verify that all the Rook pods start up
```
kubectl --namespace rook-ceph get pods --watch
```
Once all the pods are "Running", ctrl-c out of the watch to continue.

## Verify that the deployment is stood up
```
kubectl get deployments --namespace rook-ceph
```
The rook-ceph-operator deployment should be listed.

## Next Steps

Once you're done, proceed to [Lab11](Lab11.md)
