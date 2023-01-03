

add-repo:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update

install:
	helm install \
		cert-manager jetstack/cert-manager \
		--namespace cert-manager \
		--create-namespace \
		--version v1.10.1 \
		--set installCRDs=true

# to install self signed certificates issuer
	# kubectl apply -f https://gist.githubusercontent.com/t83714/51440e2ed212991655959f45d8d037cc/raw/7b16949f95e2dd61e522e247749d77bc697fd63c/selfsigned-issuer.yaml
	kubectl apply -f self-signed-issuer.yml


remove:
	helm uninstall -n cert-manager cert-manager
	