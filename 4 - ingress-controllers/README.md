# Kubernetes Ingress Controller


## Requirements

- openssl
- curl
- kubectl
- healm
- makefile


## Install

run make file to install nginx ingress: 

``` shell
make install
```
## Testing
To test the ngins installation we use the following command to install a simple quote service

``` shell
make deploy-quote
```

After install, run curl to test the quote service; curl command should be executed with -k parameter to ignore the self signed certificate.

```
curl -k https://quote.brimdataservices.com.br/
```