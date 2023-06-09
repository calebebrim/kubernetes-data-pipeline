
releasename = prometheus
# do not change the namespace
namespace = monitoring

add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

create-namespace:
	-kubectl apply -f ./prometheus/namespace.yaml

delete-namespace:
	-kubectl delete -f ./prometheus/namespace.yaml


install-crds:
	kubectl apply --server-side -f ./prometheus/prometheus-operator-crd-full -n ${namespace}
	kubectl get crds -n $(namespace)

remove-crds:
	kubectl delete -f ./prometheus/prometheus-operator-crd-full -n ${namespace}
	
install-rbac:
	kubectl apply --server-side -R -f ./prometheus/rbac -n ${namespace}
	
remove-rbac:
	kubectl delete -f ./prometheus/rbac -n ${namespace}


install-operator:
	kubectl apply --server-side -R -f ./prometheus/prometheus-operator -n ${namespace}

remove-operator:
	kubectl delete --server-side -R -f ./prometheus/prometheus-operator -n ${namespace}

install-prometheus:
	kubectl apply --server-side -R -f ./prometheus/prometheus -n ${namespace}
	echo "To add prometheus in the grafana use http://prometheus-operated.monitoring.svc.cluster.local:9090 url"

remove-prometheus:
	kubectl delete --server-side -R -f ./prometheus/prometheus -n ${namespace}






install: create-namespace install-crds install-rbac install-operator install-prometheus
remove: remove-prometheus remove-operator remove-rbac remove-crds delete-namespace  
	

install-demoapp:
	kubectl apply -R --server-side -f ./prometheus/test/staging.ns.yaml
	kubectl apply -R --server-side -f ./prometheus/test
	
remove-demoapp:
	kubectl delete -R -f ./prometheus/test
	kubectl delete -R -f ./prometheus/test/staging.ns.yaml
	



forward-prometheus: 
	kubectl port-forward pods/prometheus-main-0 9090:9090 -n monitoring

