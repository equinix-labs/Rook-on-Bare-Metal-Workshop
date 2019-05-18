# Lab 70 - Defining a PersistentVolumeClaim

## Goals

* Write your own persistentVolumeClaim manifest

## Write a manifest

So far we've been using pre built YAML manifests, but it's time for you to give it a go.

Take a reference file and use it as the base to make you own.
```
wget https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/pvc.yml
vi pvc.yml
```

Once you've made the changes, go ahead and apply it. Check that it has bound and that the volumes are created.

```
kubectl apply -f pvc.yml
kubectl get pvc --all-namespaces
```

Things to change:
* Size of the volume
* Volume name
* App label

## Next Steps

Once you're done, proceed to [Lab80](Lab80.md)
