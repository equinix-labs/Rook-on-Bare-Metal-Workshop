# Lab 22 - Tear Down the Wordpress/MySQL Application

## Goals

* Clean up the resources started with this application
* Release the assigned storage


## Delete the Application


```
kubectl delete -f wordpress.yaml
kubectl delete -f mysql.yaml
```

## Check that Storage is Released

Wait for the `PersistentVolume` to be deleted with:
```
watch -n1 -d kubectl get pv
```

And then verify that they are gone from the pool in the toolbox container `rbd ls -p replicapool`

## Next Steps

Once you're done, proceed to [Lab30](Lab30.md)
