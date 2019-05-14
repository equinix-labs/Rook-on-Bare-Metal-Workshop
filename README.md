# Rook-on-Bare-Metal Workshop

Welcome to the "Rook on Bare Metal Workshop"! This hands on workshop takes you through using Rook to provide stateful storage atop bare metal physical services to containerized workloads. You'll be provided with dedicated bare metal infrastructure (physical hosts) installed as Kubernetes nodes, lab instructions, and an instructor to follow through all the steps.

If at anytime you break your environment or otherwise get yourself stuck, don't panic. Simply take another unassigned lab environment and pick up where you left off. We'll rebuild the broken environment and make it available for someone else.

## Student Prerequisites

For this workshop, you'll be using a remote Kubernetes cluster so there is no need to install any software on your laptop. When attending, please be sure to bring and have preinstalled:

* Wifi equipped laptop
* SSH client (PuTTY)
* Web browser

While you can be a Kubernetes and Rook beginner to take this workshop, we do expect you to have some basic familiarity with Linux and command line execution including running a text editor such as 'vi'.


## Agenda


- Lab Assignments and Verifying Cluster Setup [Lab01](Lab01.md)
- Installing and Using Rook with Ceph [Lab10](Lab10.md)
- Deploying an Application with Stateful Storage [Lab20](Lab20.md)
- Using Rook with CockroachDB [Lab30](Lab30.md)
- Growing your Storage Cluster [Lab40](Lab40.md)
- Simulating and Recovering from a Storage Node Failure [Lab50](Lab50.md)
- Object Storage with RadosGW [Lab60](Lab60.md)
- Defining a PersistentVolumeClaim [Lab70](Lab70.md)
- Monitoring Rook with Prometheus & Grafana [Lab80](Lab80.md)
- Rolling upgrading of Ceph Cluster [Lab90](Lab90.md)

## Student Instructions

### Requirements

Before starting you will need SSH on your laptop.

Students at an in-person workshop, please start at [Lab01](Lab01.md)




## Running your own Workshop

You are welcome to take this workshop and run it at your own event! If you're interested in running this workshop, please feel free to read the instructions on how to setup students lab environments in the setup [README](setup/README.md).
