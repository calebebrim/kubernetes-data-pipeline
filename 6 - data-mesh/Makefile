
namespace = data-mesh

# add helm chart repo for Strimzi
add-repo:
	helm repo add strimzi https://strimzi.io/charts/
	helm repo update
	

#install it! (I have used strimzi-kafka as the release name)
install-operator:
#	-kubectl create namespace $(namespace)
	-kubectl apply -f strimzi.ns.yaml
# Installation with helm
# 	helm install -n $(namespace) strimzi-kafka strimzi/strimzi-kafka-operator
# 	kubectl get pods -l=name=strimzi-cluster-operator
# 	kubectl get crd | grep strimzi
# Instalation with kubectl
	kubectl create -f 'https://strimzi.io/install/latest?namespace=$(namespace)' -n $(namespace)
	kubectl wait deployment -n $(namespace) strimzi-cluster-operator --for condition=Available=True --timeout=90s

uninstall-operator:
# Uninstalls with helm
#	helm uninstall -n $(namespace) strimzi-kafka
# Uninstalls with kubectl
	-kubectl delete -f 'https://strimzi.io/install/latest?namespace=$(namespace)' -n $(namespace)
	-kubectl delete namespace $(namespace)



deploy-kafka-cluster:
	kubectl apply -n $(namespace) -f ./configuration/kafka
	kubectl apply -n $(namespace) -f ./configuration/ksql
	kubectl get kafka -n $(namespace)
# other deployments as ksql
	kubectl get Deployment -n $(namespace)

delete-kafka-cluster:
	-kubectl delete -n $(namespace) -f ./configuration/kafka
	-kubectl delete -n $(namespace) -f ./configuration/ksql

show-kafka-cluster:
	-kubectl get pods -n $(namespace)
	-kubectl get kafka -n $(namespace)
	-kubectl get services -n $(namespace)
	-kubectl get Deployment -n $(namespace)

describe-kafka-cluster:
	kubectl describe kafka data-mesh -n $(namespace)


create-topics:
	kubectl apply -f ./topics -n $(namespace)

list-topics:
	kubectl get kafkatopic -n $(namespace)


#
#
#... I need to continue here: https://www.infoq.com/articles/strimzi-the-gitops-way/
#
#

helm-install: 
	-kubectl create namespace $(namespace)
	helm upgrade --install kafka-operator ./strimzi-kafka-operator -n $(namespace) --values ./helm/values.yaml

helm-uninstall: delete-kafka-cluster
	helm uninstall kafka-ecosystem -n $(namespace)
	kubectl delete namespace $(namespace)