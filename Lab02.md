# Lab 02 - Verifying Kubernetes

## Goals

* Verify that Kubernetes is properly setup and running
* Deploy an application without any storage

## Verify your Kubernetes Cluster

```
kubectl apply -f https://k8s.io/examples/application/deployment.yaml
kubectl get pods --watch
```

When the pods are all started, escape with a ctrl-c.

```
kubectl delete deployment nginx-deployment
```

Verify that all the pods shut down OK.
```
kubectl get pods
```

If all spins up and destroy OK, proceed to the next lab.


## Next Steps

Once you're done, proceed to [Lab10](Lab10.md)
