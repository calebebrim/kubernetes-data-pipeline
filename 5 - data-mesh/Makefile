
namespace = default

# add helm chart repo for Strimzi
add-repo:
	helm repo add strimzi https://strimzi.io/charts/
	helm repo update
	

#install it! (I have used strimzi-kafka as the release name)
install:
	helm install -n $(namespace) strimzi-kafka strimzi/strimzi-kafka-operator
	kubectl wait deployment -n $(namespace) strimzi-cluster-operator --for condition=Available=True --timeout=90s
	kubectl get pods -l=name=strimzi-cluster-operator
	kubectl get crd | grep strimzi


uninstall:
	helm uninstall -n $(namespace) strimzi-kafka


deploy-kafka-cluster:
	kubectl apply -n $(namespace) -f ./configuration
	kubectl get kafka

delete-kafka-cluster:
	kubectl delete -n $(namespace) -f ./configuration
