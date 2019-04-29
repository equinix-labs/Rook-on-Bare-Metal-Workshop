# Lab A - Logging In

## Lab Assignment & Credentials

On the whiteboard/projector, there will be a link to an etherpad listing all the available lab environments along with the default password. Follow the link and write your name alongside a lab number (i.e. lab03 - John Doe).

Take note of the name of the "lab master" server on the whiteboard/projector. This will be the jump server from where you will access

If you ever need a new lab environment, return to this page and simply assign yourself a new one. Mark any old/broken lab environments as "broken/recycle" and it will be rebuilt.


## Background

We've taken the liberty of spinning up some bare metal infrastructure for you to use in this lab.
Each student has been allocated a number of bare metal hosts with Kubernetes already installed.
In this first lab, you'll be verifying that you can log into all the physical bare metal, the
Kubernetes environment, and the Rook/Ceph management interface.


## Layout

```
                                     +--------------------+
                                     |                    |
                                     |                    |
+----------------------+   SSH       |                 +--v-----------------------+
|                      +-------------+                 |                          |
| Lab Master           |                               | lab05-k8s-master-1       |
| Terraform            |                               | Kubernetes master+worker |
| shared by students   |                               | login: root              |
| login: labXX         +---v                           | student dedicated        |
+----------------------+   |                           +--------------------------+
                           |
                           |                           +----------------------+
                           |                           |                      |
                           |                           | lab05-k8s-node-1     |
                           |                           | Kubernetes worker    |
                           +-------------------------->+ login: root          |
                                    SSH                | student dedicated    |
                                                       +----------------------+
```


## Lab Master Access

With your assigned lab username (i.e. lab03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Logging In

```
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

## Access to Kubernetes dashboard

TODO: Install kubectl locally and use kubectl proxy/port-forward

## Next Steps

Once you're done, proceed to [Lab-B](Lab-B.md)
