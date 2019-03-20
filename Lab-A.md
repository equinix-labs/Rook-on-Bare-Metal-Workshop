# Lab A - Logging In

## Background

We've taken the liberty of spinning up some bare metal infrastructure for you to use in this lab.
Each student has been allocated a number of bare metal hosts with Kubernetes and Rook already installed.
In this first lab, you'll be verifying that you can log into all the physical bare metal, the
Kubernetes environment, and the Rook/Ceph management interface.

## Laptop setup
Before get started we need to install a couple of dependencies.
Open a terminal window and head to your desired workshop directory:
```
mkdir ~/cephalocon
cd ~/cephalocon
```

Then [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
```
# Mac
curl https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_darwin_amd64.zip > terraform.zip
unzip terraform.zip
cp terraform /usr/local/bin/
chmod +x /usr/local/bin/terraform
terraform --version

# Linux
wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
unzip terraform.zip
cp terraform /usr/local/bin/
chmod +x /usr/local/bin/terraform
terraform --version
```

Then clone the Kubespray repository
```
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
```

And finally, install the Python dependencies (Ansible etc...):
```
pip install -r requirements.txt
ansible --version
```

## Packet API
Fetch your Packet API token from the [Packet UI](https://support.packet.com/kb/articles/api-integrations) and export it as the `PACKET_AUTH_TOKEN` environment variable.
```
export PACKET_AUTH_TOKEN="Example-API-Token"
```

## Getting things started
From the root of your Kubespray repository, set your `CLUSTER` name and prepare your cluster inventory
```
export CLUSTER=cephalocon-1234
cp -LRp contrib/terraform/packet/sample-inventory inventory/$CLUSTER
cd inventory/$CLUSTER
ln -s ../../contrib/terraform/packet/hosts
```

Then edit the `inventory/$CLUSTER/cluster.tf` file as follows:
TBD


## Logging In



## Next Steps

Once you're done, proceed to [Lab-B](Lab-B.md)
