#!/bin/bash
set -euxo pipefail
apt-get update -y
apt-get install -y git python-pip python-netaddr
git clone https://github.com/packet-labs/Rook-on-Bare-Metal-Workshop.git
cd Rook-on-Bare-Metal-Workshop/setup
pip install -r requirements.txt
cp labs.ini.sample labs.ini
