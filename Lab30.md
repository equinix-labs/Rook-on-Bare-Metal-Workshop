# Lab 30 - Cockroach DB

## Goals

* Examine another use case for Rook
* Deploy and use CockroachDB operator
* Allocate storage via Rook for CockroachDB

## Background

While our previous use case (Wordpress) utilized MySQL, there are other open source database techologies that can utilize Rook deployed storage.  CockroachDB is one such other technology that can be deployed and utilize Rook managed storage. CockroachDB is a distributed SQL (“NewSQL”) database built on a transactional and strongly-consistent key-value store.  We're going to run through just such a deployment.

## Disable unsupported Ceph features

The Ubuntu 16.04 kernel being used in this workshop doesn't support the latest CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING so we'll use the Hammer protocol instead.

IF you haven't already, enable this setting using the Ceph Toolbox.

```
ceph osd crush tunables hammer
```


## Install the CockroachDB operator

Much like we deployed the Ceph Rook operator, we'll deploy the CockroachDB operator into our cluster. This operator will handle the deployment and operations of CockroachDB (making sure all the pods are running).

```
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/cockroachdb/operator.yaml
```

Wait for all pods to be `Running`
```
watch -n 1 -d kubectl -n rook-cockroachdb-system get pods
```
Once all are running, `ctrl+c` out of the watch to continue.

## Examine the CockroachDB Cluster Configuration

We will use Rook to install a 3 nodes CockroachDB cluster. Each node will have a 1 GB Ceph volume.

Download our CockroachDB Cluster description and examine the components.

```
wget https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/cockroachdb-cluster.yml
more cockroachdb-cluster.yml
```

Take note of:
* How much storage is being allocated?
* What is the underlying storage class for the database?

## Deploy the CockroachDB Cluster

Go ahead and deploy the CockroachDB cluster. This will startup the pods and allocate the PVCs.
```
kubectl create -f cockroachdb-cluster.yml
```

You can observe the configuration of the cluster with the following command:
```
kubectl -n rook-cockroachdb describe clusters.cockroachdb.rook.io
```

Wait for all pods to be `Running`:
```
watch -n1 -d kubectl -n rook-cockroachdb get pods,pvc
```

And ctrl-c to exit the watch.

## Access your CockroachDB cluster

The CockroachDB SQL command line can be accessed with the following command:

```
kubectl -n rook-cockroachdb-system exec -it $(kubectl -n rook-cockroachdb-system get pod -l app=rook-cockroachdb-operator -o jsonpath='{.items[0].metadata.name}') -- /cockroach/cockroach sql --insecure --host=cockroachdb-public.rook-cockroachdb
```

You will reach an SQL prompt where you can run SQL commands. CockroachDB is compatible with PostgresQL commands and protocol, so let's give it a try with the following example:
```
show databases;
create database example;
use example;
create table customers (id INT, first_name VARCHAR(64) NOT NULL, last_name VARCHAR(64) NOT NULL, PRIMARY KEY (id));
insert into customers VALUES (1, 'John', 'Smith');
insert into customers VALUES (2, 'John', 'Snow');
insert into customers VALUES (3, 'Jane', 'Smith');
insert into customers VALUES (4, 'Samwell', 'Tarly');
insert into customers VALUES (5, 'Donnel', 'Hill');
insert into customers VALUES (6, 'Jafer', 'Flowers');
select * from customers;
select first_name, count(*) from customers group by first_name;
```

You can exit the SQL shell with a "\q".

## Access the CockroachDB UI

Just like the Ceph dashboard, the CockroachDB dashboard can be exposed with the `kubectl expose` command:
```
kubectl -n rook-cockroachdb expose svc --port 8080 --type NodePort --name cockroachdb-admin cockroachdb-public
```

Then we find the URL with:
```
CRDB_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
CRDB_PORT=$(kubectl -n rook-cockroachdb get svc cockroachdb-admin -o jsonpath='{.spec.ports[].nodePort}')
echo "Your CockroachDB dashboard is available at: http://$CRDB_IP:$CRDB_PORT/"
```

Explore the CockroachDB dashboard where you will find SQL cluster health, SQL metrics and DB information.

## Next Steps

Once you're done, proceed to [Lab40](Lab40.md)
