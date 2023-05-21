
releasename = prometheus
namespace = monitoring

add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

namespace:
	-kubectl create namespace ${namespace}


install-kubestack: namespace
	-helm upgrade --install ${releasename}-stack \
		-n ${namespace} prometheus-community/kube-prometheus-stack \
		--values ./values.yaml
	

install-crds: namespace
	-helm upgrade --install ${releasename}-crds -n ${namespace} prometheus-community/prometheus-operator-crds

 
install-prometheus: install-crds
# install: 
# - prometheus server
# - prometheus alert manager
# - kube state metrics
# - prometheus node exporter
	-helm upgrade --install $(releasename) -n ${namespace} prometheus-community/prometheus 

delete-prometheus: 
	-helm uninstall $(releasename) -n ${namespace}
	
	
remove-crds:
	-helm uninstall ${releasename}-crds -n ${namespace}

remove: delete-prometheus remove-crds
	-kubectl delete crd alertmanagerconfigs.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd alertmanagers.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd podmonitors.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd probes.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd prometheuses.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd prometheusrules.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd servicemonitors.monitoring.coreos.com -n ${namespace}
	-kubectl delete crd thanosrulers.monitoring.coreos.com -n ${namespace}


podmonitors:
	kubectl apply -R -f service/monitor -n ${namespace}

rmpodmonitors:
	kubectl delete -R -f service/monitor -n ${namespace}



