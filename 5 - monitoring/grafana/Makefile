version=6.56.4
release=grafana
namespace=monitoring
addrepo:
	helm repo add grafana https://grafana.github.io/helm-charts


get-values:
	helm show values grafana/grafana --version $(version) > values.$(version).yaml

install:
	helm upgrade --install $(release) grafana/grafana \
		-n $(namespace) \
		--version $(version) \
		--values values.$(version).yaml

	

get-password:
	   kubectl get secret --namespace $(namespace) $(release) -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

uninstall:
	helm uninstall $(release) -n $(namespace)


create-secret:
	openssl genrsa -out ca.key 2048
	openssl req -x509 \
		-new -nodes  \
		-days 365 \
		-key ca.key \
		-out ca.crt \
		-subj "/CN=$(release).brimdataservices.com.br"
	
	kubectl create secret tls $(release)-ingress \
		--key ca.key \
		--cert ca.crt \
		-n $(namespace)

remove-secret:
	kubectl delete secret $(release) -n $(namespace)