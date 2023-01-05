# Private repository creation

## Requirements

- apache2-utils: https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-apache-on-ubuntu-18-04-quickstart-pt
- Makefile
- Docker compose

## Directories
- /auth: authentication configuration.
- /data: where repository images will be stored. 

## Install

### Passord creation
First we need to generate the autentication for the private repository. 

``` shell
cd ./auth && make create-login && make login
```
The terminal will prompt user and password. You should use the user and password defined in the __Makefile__ file.

### Docker compose repository deployment

Deploy the repository using the following command:

``` shell
docker compose up -d
```

### Associating the repository with the kubernetes

To use this repository with kubernetes server, you need to bind the kubernetes network with the deployed cluster.

``` shell
make register
```

