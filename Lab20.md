# Lab 20 - Running an Application with Stateful Storage

## Goals

* Installing an example application in the cluster


## Lab Master Access

With your assigned lab username (i.e. lab03), log into the lab master server using your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Download and Examine Application Config Files


```
wget https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/wordpress.yaml
wget https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/mysql.yaml
```


## Create Applications

```
kubectl create -f mysql.yaml
kubectl create -f wordpress.yaml
```

```
kubectl get svc wordpress --watch
```

## Examine the created resources

```
kubectl get Deployments
kubectl get PersistentVolumeClaim
kubectl get Services
```

## Access the application

```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl get svc wordpress -o jsonpath='{.spec.ports[].nodePort}')
echo "Your wordpress is available at: http://$IP:$PORT/"
```

## Next Steps

Once you're done, proceed to [Lab21](Lab21.md)
