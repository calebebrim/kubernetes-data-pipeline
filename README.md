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

## private image repository
K3d cluster should deploy private images from a public or private repository, here we will deploy a private one to use with k3d cluster. Open __0-private-registry__ folder and run the following commands:

use the following command to create repository credentials
``` shell
cd auth && make create-login

```

use this command to create repository container
``` shell
docker compose up -d

```

wait for the container up... the container should produce the following logs:

``` log
time="2022-12-31T03:43:22.4082266Z" level=warning msg="No HTTP secret provided - generated random secret. This may cause problems with uploads if multiple registries are behind a load-balancer. To provide a shared secret, fill in http.secret in the configuration file or set the REGISTRY_HTTP_SECRET environment variable." go.version=go1.16.15 instance.id=5482d24a-c04b-487c-a87a-eb6ab7e84ad6 service=registry version="v2.8.1+unknown" 
time="2022-12-31T03:43:22.4082941Z" level=info msg="redis not configured" go.version=go1.16.15 instance.id=5482d24a-c04b-487c-a87a-eb6ab7e84ad6 service=registry version="v2.8.1+unknown" 
time="2022-12-31T03:43:22.4084511Z" level=info msg="Starting upload purge in 58m0s" go.version=go1.16.15 instance.id=5482d24a-c04b-487c-a87a-eb6ab7e84ad6 service=registry version="v2.8.1+unknown" 
time="2022-12-31T03:43:22.4150913Z" level=info msg="using inmemory blob descriptor cache" go.version=go1.16.15 instance.id=5482d24a-c04b-487c-a87a-eb6ab7e84ad6 service=registry version="v2.8.1+unknown" 
time="2022-12-31T03:43:22.4153017Z" level=info msg="listening on [::]:5000" go.version=go1.16.15 instance.id=5482d24a-c04b-487c-a87a-eb6ab7e84ad6 service=registry version="v2.8.1+unknown" 
```

Then bind the future k3d networking with the current container:

``` shell
make register
```

## K3d Cluster

To deploy a k3d cluster enter on __1-cluster__ and run the following command:

``` shell
    make create
```

The k3d cli will reuse the already created network and create the kubernetes cluster. 

Just in case you want to deploy the cluster with more than one agent or server, you can use the command with the following parameters:

``` shell	
make create agents=3 servers=3

```


# cluster ingress

To make the cluster cluster to receive traffic over http, we will need to install a kubernetes ingres. 
The one I like more is nginx. To install nginx ingress on kubernetes server open __2-ingress-controlles__ and run the following command:


``` shell	
make add-repo
make install
```

if this is not the first time you install nginx ingress on kubernetes server, you can skip the add-repo command make command.

to make sure iginx is installed correctly run the following command:

``` shell	
kubectl get pods -n default
```
It must show the services deployed in the default namespace.

# test private repository
