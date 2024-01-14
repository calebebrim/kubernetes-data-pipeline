# kubernetes-data-pipeline
A kubernetes based data pipeline

# requirements
Before run this tutorial make sure you have the required programs installed

- Docker
- Docker Compose
- K3d
- Helm
- makefile

# steps to deploy

## Private image repository

See __0 - private-registry__ folder for details.
## K3d Cluster

To deploy a k3d cluster enter on __1-cluster__ and run the following command:

``` shell
    make create-cluster
```

The k3d cli will reuse the already created network and create the kubernetes cluster. 

Just in case you want to deploy the cluster with more than one agent or server, you can use the command with the following parameters:

``` shell	
make create-cluster agents=3 servers=3

```


# cluster ingress

To make the cluster cluster to receive traffic over http, we will need to install a kubernetes ingres. 
The one I like more is nginx. To install nginx ingress on kubernetes server open __2-ingress-controlles__ and run the following command:


``` shell	
make add-repo
make install
```

if this is not the first time you install nginx ingress on kubernetes server, you can skip the add-repo command make command.

to make sure nginx is installed correctly run the following command:

``` shell	
kubectl get pods -n default
```
It must show the services deployed in the default namespace.

# test private repository
