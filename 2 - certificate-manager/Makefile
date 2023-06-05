namespace=cert-manager

add-repo:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update

install:
	helm upgrade --install \
		cert-manager jetstack/cert-manager \
		--namespace $(namespace) \
		--create-namespace \
		--version v1.10.1 \
		--set installCRDs=true

# to install self signed certificates issuer
	# kubectl apply -f https://gist.githubusercontent.com/t83714/51440e2ed212991655959f45d8d037cc/raw/7b16949f95e2dd61e522e247749d77bc697fd63c/selfsigned-issuer.yaml
	kubectl apply -n $(namespace) -f self-signed-issuer.yml


remove:
	-helm uninstall -n $(namespace) cert-manager
	-kubectl delete -n $(namespace) -f self-signed-issuer.yml


create-secret:
	openssl genrsa -out ca.key 2048
	openssl req -x509 \
		-new -nodes  \
		-days 365 \
		-key ca.key \
		-out ca.crt \
		-subj "/CN=brimdataservices.com.br"
	
	kubectl create secret tls brimdataservices \
		--key ca.key \
		--cert ca.crt