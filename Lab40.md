# Lab E - Increasing Bare Metal Storage

## Goals

* Understand how to grow the cluster to include additional hosts that are automatically assigned to the anycast and have traffic balanced across.


## Lab Master Access

With your assigned lab username (i.e. lab03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Increate the host count

The number of workers is defined in the Terraform variables configuration file `~/cluster.tfvars` with the variable `number_of_k8s_nodes`. Increase it from the current count of 2 to 3.

```
vi cluster.tfvars
```

## Examine Terraform Plan

Before applying this change to the network, let's examine what Terraform is planning to do.
```
terraform plan ...
```

## Increasing Bare Metal Storage

```
terraform apply ...
```

## Next Steps

Once you're done, proceed to [Lab-F](Lab-F.md)
