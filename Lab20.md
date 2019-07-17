# Lab 20 - Running an Application with Stateful Storage

## Goals

* Installing an stateful application in the cluster
* Setup storage for the application

## Disable unsupported Ceph features

The Ubuntu 14.04 kernel being used in this workshop doesn't support the latest CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING so we'll use the Hammer protocol instead. Test this configuration using the Ceph Toolbox.

```
ceph osd crush tunables hammer
```

## Download and Examine Application Config Files

On the `node1` run the following commands:

```
wget https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/wordpress.yaml
wget https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/mysql.yaml
```

### Wordpress Description

Examine the Wordpress application descriptions. Take note of:

* PersistentVolumeClaim (wp-pv-claim)
* volumeMounts (wordpress-persistent-storage)
```
more wordpress.yaml
```

How much storage was allocated for Wordpress?
What type of storage was allocated?
Where in the container in the storage mounted?
What does "accessModes: ReadWriteOnce" mean?

### MySQL Description

Examine the MySQL application descriptions. Take note of:

* PersistentVolumeClaim (mysql-pv-claim)
* volumeMounts (mysql-persistent-storage)

```
more mysql.yaml
```

How much storage was allocated for Wordpress?
What type of storage was allocated?
Why is this claim labeled with "app: wordpress"?


## Create Applications

Go ahead and start up the applications which in turn will also allocate the storage through Rook.
```
kubectl create -f mysql.yaml
kubectl create -f wordpress.yaml
```

## Volume Claims

The PVCs (Persistent Volume Claims) will be allocated as part of this deployment. Watch as Rook allocates these storage resources.

```
watch -n1 -d kubectl get PersistentVolumeClaim
```

Once the storage is allocated, "ctrl-c" out of this watch and verify that the rest of the deployment has started.

## Examine the created resources

Validate that all the Wordpress and MySQL pods are running.

```
watch -n1 -d kubectl get pods
```

Once all the pods are started, "ctrl-c" out of this watch and verify that the full deployment and services are running OK.

```
kubectl get Deployments
kubectl get Services
```

## Examine Ceph setup via Toolbox

Let's take a deeper look at has been setup in Ceph.


You should already have started up the Ceph Toolbox in an earlier lab running in another terminal session. Run the following commands on the Ceph Toolbox container.

List out all the created pools created in an earlier lab.
```
rados df
```

List the images associated with the pool "replicapool" listed above.
```
rbd -p replicapool ls -l
```

Get the details on each image (volume claim) from the listing above.
```
rbd -p replicapool info <YOUR_PVC_IMAGE_NAME>
```

Leave the toolbox running so you can use it in later lab steps.

## Examine Ceph setup via Dashboard

Through the Ceph dashboard (web), examine the same items that were examined via the toolbox. This information is under the "Pool" and "Block" menu items.

If you need the Ceph dashboard details, the following will get you the dashboard URL:
```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-ceph get svc ceph-dashboard-external -o jsonpath='{.spec.ports[].nodePort}')
echo "Your dashboard is available at: https://$IP:$PORT/"
```

The default username is "admin" and the login password can be retrieve with the following command.
```
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode | sed 's/$/\n/'
```

## Access the application

You can validate that the Wordpress server is indeed running by pulling up the login page.

```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl get svc wordpress -o jsonpath='{.spec.ports[].nodePort}')
echo "Your wordpress is available at: http://$IP:$PORT/"
```

Don't tear down this environment just yet. We're going to use it in later labs.

## Next Steps

Once you're done, proceed to [Lab21](Lab21.md)
