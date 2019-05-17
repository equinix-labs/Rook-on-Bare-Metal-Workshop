# Lab 21 - Single Node Failure Handling

## Goals

* Simulate failures and examine how the Rook Operator resolves them

## Simulate Ceph OSD Failure

Open two terminal windows on `node1`.

Monitor your cluster with the first terminal.
```
watch -n1 -d kubectl -n rook-ceph get pods
```

Using the second terminal session, kill the Ceph OSD process to simulate a failure such as a hardware node failure or a software fault.
```
pkill -9 ceph-osd
```

Rook will notice that the Ceph OSD is no longer running. Rook start a new OSD process to match the requirements in the cluster configuration file and bring your cluster back to healthy status.

## Simulate Application Failure

The same failure scenario can be simulate at the database (MySQL) and application (Wordpress) layer. Failures with Persistent Volume Claims are a little more tricky since Kubernetes may decide to schedule the workload on a different node. Rook needs to monitor when this happens and reconfigure as necessary.

Since our cluster only consists of a single node right now, we won't see Rook in action but we can watch Kubernetes handle the failure.

In the first window now run `watch -n1 -d kubectl get pods` to monitor your wordpress setup, and in the second window run `kubectl delete pod -l tier=mysql` to delete the mysql pod.
Kubernetes will detect that and rectify.

## Next Steps

Once you're done, proceed to [Lab22](Lab22.md)
