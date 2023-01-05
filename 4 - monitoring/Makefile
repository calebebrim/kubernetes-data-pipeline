
releasename = prometheus-stack

add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

install:
	helm upgrade --install ${releasename} prometheus-community/kube-prometheus-stack -f ./config/values.yaml


	
remove:
	helm uninstall ${releasename}
	kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
	kubectl delete crd alertmanagers.monitoring.coreos.com
	kubectl delete crd podmonitors.monitoring.coreos.com
	kubectl delete crd probes.monitoring.coreos.com
	kubectl delete crd prometheuses.monitoring.coreos.com
	kubectl delete crd prometheusrules.monitoring.coreos.com
	kubectl delete crd servicemonitors.monitoring.coreos.com
	kubectl delete crd thanosrulers.monitoring.coreos.com
