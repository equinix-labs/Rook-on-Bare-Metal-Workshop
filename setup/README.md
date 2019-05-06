# Master hosts

## Requirements
```
# Install requirements
apt-get install -y git python-pip
git clone https://github.com/packet-labs/Rook-on-Bare-Metal-Workshop.git
cd Rook-on-Bare-Metal-Workshop/setup
pip install -r requirements.txt

# Put Packet env vars (PACKET_AUTH_TOKEN and PACKET_PROJECT_ID) in ~/.packet.sh
vi ~/.packet.sh
chmod 700 ~/.packet.sh
source ~/.packet.sh
```


## Usage
The following usage assumes that you are in the `~/Rook-on-Bare-Metal-Workshop/setup/` directory.

In `labs.ini` configure the labs as desired, then run `ansible-playbook -i labs.ini  main.yml`

### Configure the Packet facility
In `labs.ini` you can set a default `packet_facility` option in the `[labs:vars]` section and then override on a per lab basis by appending `packet_facility=example` at the end of the line describing a given lab.

### Limit to a specific lab
To (re)setup the lab1 and lab4 use the `--limit` option as follows: `ansible-playbook -i labs.ini  main.yml --limit lab1,lab4`

### Destroy labs

:warning: this will run a `terraform destroy` and will delete all data in the labs.
To destroy **all** labs use the `-e terraform_state=absent` option as follows: `ansible-playbook -i labs.ini  main.yml -e terraform_state=absent`.

You can also delete a specific lab by combining it with the `--limit` option like so: `ansible-playbook -i labs.ini  main.yml --limit lab1,lab4 -e terraforn_state=absent` will delete only lab1 and lab4 without doing anything with other labs.

### Excluding certain task

The Kubespray install can take a long time (~15min), you can use `--skip-tags  kubespray` to skip the Kubespray/Kubernetes install (useful for tests).
