

namespace=default


add-repo:
	helm repo add nginx-stable https://helm.nginx.com/stable	 
	helm repo update

install:
#https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/
	helm upgrade --install ingress-nginx nginx-stable/nginx-ingress -n $(namespace) -f ./config/values.yaml

remove:
	helm delete ingress-nginx -n $(namespace)


# test with http
# the domain should be added to the hosts file
deploy-quote:
	kubectl apply -n $(namespace) -f ./config/quote-all.yaml

delete-quote:
	kubectl delete -n $(namespace) -f ./config/quote-all.yaml