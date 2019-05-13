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

## Access your CockroachDB cluster

```
kubectl -n rook-cockroachdb-system exec -it $(kubectl -n rook-cockroachdb-system get pod -l app=rook-cockroachdb-operator -o jsonpath='{.items[0].metadata.name}') -- /cockroach/cockroach sql --insecure --host=cockroachdb-public.rook-cockroachdb
```
Then you will reach an SQL prompt where you can run SQL commands. CockroachDB is compatible with PostgresQL commands and protocol, so let's give it a try with the following example:
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

## Access the CockroachDB UI

Just like the Ceph dashboard we will expose the CockroachDB dashboard on a random port number with the `kubectl expose` command:
```
kubectl -n rook-cockroachdb expose svc --port 8080 --type NodePort --name cockroachdb-admin cockroachdb-public
```

Then we find the URL with:
```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-cockroachdb get svc cockroachdb-admin -o jsonpath='{.spec.ports[].nodePort}')
echo "Your dashboard is available at: https://$IP:$PORT/"
```

Explore the CockroachDB dashboard you will find SQL cluster health, SQL metrics and DB information.

## Next Steps

Once you're done, proceed to [Lab40](Lab40.md)
