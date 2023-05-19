# Kubernetes Self signed Certificate Issuer

## Sources: 

- https://phoenixnap.com/kb/kubernetes-ssl-certificates
- https://cert-manager.io/docs/usage/ingress/
- https://devopscube.com/configure-ingress-tls-kubernetes/
- https://github.com/cert-manager/cert-manager
- https://cert-manager.io/docs/installation/helm/

## installation

fist add the repository of certificate manager helm. and then install the certificate manager. 

``` shell
    make add-repo
    make install
```

Onde you have the repository of certificate manager added, you don't need to add it again.