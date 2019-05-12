# Lab 02 - Verifying Kubernetes

## Goals

* Verify that Kubernetes is properly setup and running
* Deploy and destroy a simple application

## Verify your Kubernetes Cluster

```
kubectl apply -f https://k8s.io/examples/application/deployment.yaml
kubectl expose deploy nginx-deployment
kubectl get pods --watch
```

Watch all the pods start up. You'll see "Ready 1/1" when all the pods are running.
When the pods are all started, escape the watch command with a ctrl-c.

## Verify Networking

```
kubectl get services
curl <CLUSTER_IP>
```

## Tear down

```
kubectl delete deployment nginx-deployment
kubectl delete service nginx-deployment
```

Verify that all the pods and services shut down OK.
```
kubectl get pods
kubectl get services
```
All the nginx pods and deployments should be gone and all you will see is the Kubernetes services.

Once you've verified that your cluster works correctly, please move to the next lab.

## Next Steps

Once you're done, proceed to [Lab10](Lab10.md)
