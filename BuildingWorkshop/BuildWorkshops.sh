git clone https://github.com/kubernetes-sigs/kubespray

# need to do this once and it'll be good for all accounts
#sudo pip install -r kubespray/requirements.txt

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -q -N ""
fi

mkdir -p kubespray/inventory/alpha
cp cluster.tf kubespray/inventory/alpha/cluster.tf

cd kubespray
cp -LRp contrib/terraform/packet/sample-inventory/ inventory/alpha
cd inventory/alpha

ln -s ../../contrib/terraform/packet/hosts

# export PACKET_AUTH_TOKEN="XYZ"

terraform init ../../contrib/terraform/packet/
terraform apply --auto-approve --var-file=cluster.tf ../../contrib/terraform/packet/

cd ../..
ansible-playbook --become -i inventory/alpha/hosts cluster.yml

# once you're done with the lab
#cd kubespray/inventory/alpha
#terraform destroy --auto-approve -var-file=cluster.tf ../../contrib/terraform/packet/

