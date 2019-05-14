# Lab 70 - Defining a PersistentVolumeClaim

## Goals

* Write your own persistentVolumeClaim manifest

## Write a manifest

So far we've been using pre built YAML manifests, but it's time for you to give it a go.  Take [this example](config/pvc.yml) and make it your own, then use `kubectl apply -f <your file>` to create it and use `kubectl get pvc --all-namespaces` to verify that it reached `Bound` state.

## Next Steps

Once you're done, proceed to [Lab80](Lab80.md)
