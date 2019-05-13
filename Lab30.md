# Lab 30 - Cockroach DB

## Goals

*

## Install the CockroachDB operator


```
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/cockroachdb/operator.yaml
```

Waitf for all pods to be `Running`
```
watch -n 1 -d kubectl -n rook-cockroachdb-system get pods
```
Then `ctrl+c` out to continue.

## Your first CockroachDB cluster

We will use tell Rook to install a 3 nodes CockroachDB cluster. Each node will have a 1 GB Ceph volume.
```
kubectl create -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/cockroachdb-cluster.yml
```

You can observe the configuration of the cluster with the following command:
```
kubectl -n rook-cockroachdb describe clusters.cockroachdb.rook.io
```

Then wait for all pods to be `Running`:
```
watch -n1 -d kubectl -n rook-cockroachdb get pods,pvc
```

## Use your CockroachDB cluster

```
kubectl -n rook-cockroachdb-system exec -it $(kubectl -n rook-cockroachdb-system get pod -l app=rook-cockroachdb-operator -o jsonpath='{.items[0].metadata.name}') -- /cockroach/cockroach sql --insecure --host=cockroachdb-public.rook-cockroachdb -d test -e 'select * from kv'
```

## Next Steps

Once you're done, proceed to [Lab40](Lab40.md)
