# Lab 60 - Object Storage with RadosGW

## Goals

* Deploy and use RadosGW with Rook
* Enable public access to a bucket

## Create a CephObjectStore

To deploy Ceph RadosGW we need to create a `CephObjectStore`:
```
kubectl create -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/ceph-object-store.yml
```
This will deploy 3 RGWs configured with a metadata pool of `size=2` and an erasure coded pool of (3,1).

We'll wait for Rook to deploy the rgw:
```
watch -n 1 -d kubectl get CephClusters,deployments,pods,svc,cephobjectstore -n rook-ceph -l app=rook-ceph-rgw
```

We can then inspect the pools created via the toolbox container with `rados lspools` or use the Ceph UI as you prefer.
You should see a pool `.rgw.root` and a couple of pools starting with `my-store.rgw`.

## Create an Object Store User

To use the object storage we'll need a object store use.
```
kubectl create -f https://raw.githubusercontent.com/rook/rook/release-1.0/cluster/examples/kubernetes/ceph/object-user.yaml
```
Rook will generate access keys for that user and store them as Kubernetes secrets. These keys can be decoded:
```
AWS_ACCESS_KEY_ID=$(kubectl -n rook-ceph get secret rook-ceph-object-user-my-store-my-user -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)
AWS_SECRET_ACCESS_KEY=$(kubectl -n rook-ceph get secret rook-ceph-object-user-my-store-my-user -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)
echo "Your access key is: $AWS_ACCESS_KEY_ID"
echo "Your secret key is: $AWS_SECRET_ACCESS_KEY"
```

## Install S3 client
To test RGW we need `mc`, an S3 CLI client.
```
wget -O /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x /usr/local/bin/mc
mc --version
```

Connecting requires the endpoint to be defined.
```
AWS_ENDPOINT=$(kubectl -n rook-ceph get svc rook-ceph-rgw-my-store -o jsonpath='{.spec.clusterIP}'):80
mc config host add my-store http://$AWS_ENDPOINT $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
```

The S3 client can then be used to manipulate the bucket storage.
```
mc mb my-store/my-bucket --region :default-placement
mc ls my-store
mc cp --recursive /tmp/releases/ my-store/my-bucket
mc ls my-store/my-bucket
```

## Expose RadosGW and bucket

With the newly created bucket, public read-only access can be enabled.

```
mc policy set download my-store/my-bucket/
mc policy list my-store/my-bucket
```


But currently our RadosGWs are exposed with an internal `ClusterIP`, you can verify this with `kubectl -n rook-ceph get service -l app=rook-ceph-rgw`

Just like for the Ceph dashboard we will expose the RGWs with a NodePort:
```
kubectl -n rook-ceph expose service rook-ceph-rgw-my-store --name rook-ceph-rgw-my-store-external --type=NodePort
```
We can then verify that the new service is available with `kubectl -n rook-ceph get service -l app=rook-ceph-rgw`. Two services are now deployed: a ClusterIP and a NodePort.

We can find out the external URL with the following command:
```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-ceph get svc rook-ceph-rgw-my-store-external -o jsonpath='{.spec.ports[].nodePort}')
echo "Your RadosGW bucket is available at: http://$IP:$PORT/my-bucket/"
```

## Next Steps

Once you're done, proceed to [Lab70](Lab70.md)
