# Lab 01 - Lab Assignment and Verification

## Lab Assignment & Credentials

On the whiteboard/projector, there will be a link to an etherpad listing all the available lab environments along with the default password. Follow the link and write your name alongside a lab number (i.e. lab03 - John Doe).

Take note of the name of the "lab master" server on the whiteboard/projector. This will be the jump server from where you will access

If you ever need a new lab environment, return to this page and simply assign yourself a new one. Mark any old/broken lab environments as "broken/recycle" and it will be rebuilt.


## Background

We've taken the liberty of spinning up some bare metal infrastructure for you to use in this lab.
Each student has been allocated a number of bare metal hosts with Kubernetes already installed.
In this first lab, you'll be verifying that you can log into all the physical bare metal, the
Kubernetes environment, and the Rook/Ceph management interface.

## Deployed Bare Metal per Lab

| Node     | CPU cores      | Memory (GB) | Boot (GB SSD) | Storage (GB SSD) | Details
|----------|----------------|-------------|---------------|------------------|---------
| Master   | 4 x 2.4 GHz    | 8 GB        | 1 x 80        | None             |[t1.small.x86](https://www.packet.com/cloud/servers/t1-small/)
| Node     | 24 x 2.2 GHz   | 64 GB       | 2 x 120       | 2 x 480          |[c2.medium.x86](https://www.packet.com/cloud/servers/c2-medium-epyc/)


Boot drives are formatted with an file system while storage drives are unallocated and available as raw devices.

## Layout

```
                                     +--------------------+
                                     |                    |
                                     |                    |
+----------------------+   SSH       |                 +--v-----------------------+
|                      +-------------+                 |                          |
| Lab Master           |                               | node1                    |
| Terraform            |                               | Kubernetes master+worker |
| shared by students   |                               | login: root              |
| login: labXX         +---v                           | student dedicated        |
+----------------------+   |                           +--------------------------+
                           |
                           |                           +----------------------+
                           |                           |                      |
                           |                           | node2                |
                           |                           | Kubernetes worker    |
                           +-------------------------->+ login: root          |
                                    SSH                | student dedicated    |
                                                       +----------------------+
```


## Lab Master Access

With your assigned lab username (i.e. lab03), log into the lab master server using the your assigned lab and the password. You'll need to use a SSH client (i.e. PuTTy).

```
ssh <your_lab_username>@<lab_master_server>
```

## Verify Lab Hosts

Do a quick check that all your assigned host are availabline. These Ansible commands are to be run on the lab master.

### List Lab Hosts

You should have a total of three hosts assigned to you.
```
ansible-inventory -i inventory.ini --list
```

### Verify Lab Host Networking

Verify that all machines return a ping OK.
```
ansible -i inventory.ini all -m ping
```

### Verify SSH Access

Lookup the master node IP and verify that SSH works.
```
ansible-inventory -i inventory.ini --host=node1 | jq '.ansible_host' | cut -d "\"" -f 2
ssh root@$(ansible-inventory -i inventory.ini --host=node1 | jq '.ansible_host' | cut -d "\"" -f 2)
```

## Moving Forward

If you have a correct number of hosts and all are responding to ping, please proceed to the next lab. If you are missing machines or they are not responding correctly, please mark this lab as broken on the etherpad, pick another lab from the etherpad, and repeat the lab verification steps.

## Next Steps

Once you're done, proceed to [Lab02](Lab02.md)
