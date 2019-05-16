# Lab 22 - Tear Down the Wordpress/MySQL Application

## Goals

* Clean up the resources started with this application
* Release the assigned storage


## Monitor the PVCs

As we deprovision this environment, we're going to watch the PVCs (Persistent Volume Claims) and see that Rook deallocates the storage. You'll need two shell sessions on the Kubernetes master (node1). The first will watch the PVCs and in the second you'll deprovision the application.

Start watching the PVCs
```
watch -n1 -d kubectl get pvc
```

## Delete the Application

The YAML files used to deploy the applications and provision the storage can be used to deprovision the environmne. This is more efficient than deprovisioning each resource (container, storage, etc) manually.


Go ahead and deprovision the database and watch the PVC deallocate in the first shell session.
```
kubectl delete -f mysql.yaml
```

And now deallocate the Wordpress application.
```
kubectl delete -f wordpress.yaml
```

## Manual Validation

Through the Ceph Toolbox and/or the Ceph Dashboard, verify that all the PVCs have been released.

## Next Steps

Once you're done, proceed to [Lab30](Lab30.md)
