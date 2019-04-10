# Lab A - Logging In

## Background

We've taken the liberty of spinning up some bare metal infrastructure for you to use in this lab.
Each student has been allocated a number of bare metal hosts with Kubernetes already installed.
In this first lab, you'll be verifying that you can log into all the physical bare metal, the
Kubernetes environment, and the Rook/Ceph management interface.

## Logging In

```
#  SSH into the jumphost
ssh rook{01-40}@labs.packetlabs.tech
ls -lh

# Then into the kubernetes master node
ssh kube-master

# List all nodes
kubectl get nodes

# List all namespaces
kubectl get namespaces

# List pods in the default namespace
kubectl get pods

# List pods in all namespaces
kubectl get pods --all-namespaces
```

## Next Steps

Once you're done, proceed to [Lab-B](Lab-B.md)
