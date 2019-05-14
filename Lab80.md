# Lab 80 - Monitoring Rook with Prometheus & Grafana

## Goals

* Setup Prometheus and Grafana for Ceph monitoring with Rook

# Deploy and configure Prometheus

We will use the Prometheus Operator for monitoring, let's first install that with:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/v0.26.0/bundle.yaml
```
Then we need to configure the Ceph specific configuration: monitoring endpoints, alarm levels etc...
```
kubectl apply -f https://raw.githubusercontent.com/packet-labs/Rook-on-Bare-Metal-Workshop/master/configs/ceph-monitoring.yml
```

At this point we should be able to reach the Prometheus UI at:
```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl -n rook-ceph get svc rook-prometheus -o jsonpath='{.spec.ports[].nodePort}')
echo "Your Prometheus UI is available at: http://$IP:$PORT/"
```

Head over to `Status > Target` and make sure that the ceph-mgr target is `UP`, then go to `Graph` and graph following query:
`ceph_cluster_total_used_bytes/(1024^3)` to show the total space used in gigabyte over time.
Finally you can check the `Alerts` tab.

Prometheus has a lot of metrics, but its UI is very basic. For more complex dashboards we will need Grafana.

## Deploy and configure Grafana

First let's install Grafana.

```
helm install stable/grafana --name grafana --set service.type=NodePort
```
Then we will need to find the `admin` password for Grafana with:
```
kubectl get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Now let's find the Grafana URL with
```
IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[].address}')
PORT=$(kubectl get svc grafana -o jsonpath='{.spec.ports[].nodePort}')
echo "Your Grafana UI is available at: http://$IP:$PORT/"
```
Head over to that URL and login with `admin` and the password previously identified.

Once in Grafana you will need to click on *Add a data source* of type *Prometheus* with the URL: http://rook-prometheus.rook-ceph:9090/

Once your data source saved click on the `+` on the left side and select `Import`.
The dashboard IDs to import are: 2842, 5336 and 5342.
You will need to select the Prometheus data source when importing each dashboard.

Explore the available dashboards.


## Next Steps

Once you're done, proceed to [Lab90](Lab90.md)
