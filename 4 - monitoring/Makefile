
releasename = prometheus-stack
namespace = monitoring

add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

install:
	-@kubectl create namespace ${namespace}
	helm upgrade --install ${releasename} -n ${namespace} prometheus-community/kube-prometheus-stack -f ./config/values.yaml
# 	kubectl apply -f ./config -n ${namespace} --force-conflicts=true --server-side
# 	kubectl apply -f ./config/grafana/grafana.yaml -n ${namespace} --force-conflicts=true --server-side



	
remove:
	helm uninstall ${releasename} -n ${namespace}
	kubectl delete crd alertmanagerconfigs.monitoring.coreos.com -n ${namespace}
	kubectl delete crd alertmanagers.monitoring.coreos.com -n ${namespace}
	kubectl delete crd podmonitors.monitoring.coreos.com -n ${namespace}
	kubectl delete crd probes.monitoring.coreos.com -n ${namespace}
	kubectl delete crd prometheuses.monitoring.coreos.com -n ${namespace}
	kubectl delete crd prometheusrules.monitoring.coreos.com -n ${namespace}
	kubectl delete crd servicemonitors.monitoring.coreos.com -n ${namespace}
	kubectl delete crd thanosrulers.monitoring.coreos.com -n ${namespace}
# 	kubectl delete -f ./config/grafana/grafana.yaml -n ${namespace}
# 	kubectl delete -f ./config -n ${namespace}
	-@kubectl delete namespace ${namespace}