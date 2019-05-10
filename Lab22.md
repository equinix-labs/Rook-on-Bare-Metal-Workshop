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

## Next Steps

Once you're done, proceed to [Lab30](Lab30.md)
