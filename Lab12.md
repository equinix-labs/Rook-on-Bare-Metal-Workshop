# Lab 12 - Ceph Toolbox

## Goals

* Start up the Ceph Toolbox container
* Access and play with the Ceph Toolbox

## Start a New Terminal Session

Start a new terminal (SSH) session and connect to your Kubernetes master via the lab master. This new terminal window will be used to access the Ceph Toolbox. Keep this session open for the rest of the workshop.

## Deploy Ceph Toolbox

Rook deploys containers with minimal images, we will need a *toolbox* container to have familiars CLI tools like `ceph`, `rbd` and `rados` commonly used for testing and debugging:

Startup the Ceph Toolbox in the new terminal session.

```
#  Create toolbox
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/toolbox.yaml

# Wait for the toolbox to be Running
kubectl --namespace rook-ceph get pod -l app=rook-ceph-tools
```

## Use Ceph Toolbox

### Open a terminal on the toolbox
Run a bash shell in the Ceph Toolbox pod.
```
kubectl --namespace rook-ceph exec -it $(kubectl --namespace rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
```

Set a custom prompt to help track that this terminal session is in the toolbox.
```
export PS1="ceph-toolbox# "
```

### Execute toolbox commands within the toolbox

Run some sample Ceph commands within the toolbox to see how it works.

```
ceph status
ceph osd status
ceph df
rados df
```

Keep this toolbox window open for use in later steps. Switch back to your other terminal session for regular Kubernetes command.

## Next Steps

Once you're done, proceed to [Lab14](Lab14.md)
