git clone https://github.com/kubernetes-sigs/kubespray

# need to do this once and it'll be good for all accounts
sudo pip install -r kubespray/requirements.txt

ssh-keygen -t ed25519 -q -N ""

cp -LRp kubespray/contrib/terraform/packet/sample-inventory/ kubespray/inventory/alpha
ln -s kubespray/contrib/terraform/packet/hosts kubespray/inventory/alpha
cp cluster.tf kubespray/inventory/alpha/cluster.tf

# export PACKET_AUTH_TOKEN="XYZ"

terraform init kubespray/contrib/terraform/packet/
terraform apply --var-file=cluster.tf kubespray/contrib/terraform/packet/
