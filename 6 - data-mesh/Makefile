
operator-namespace = strimzi-kafka
kafka-namespace = strimzi-kafka

# add helm chart repo for Strimzi
add-repo:
	helm repo add strimzi https://strimzi.io/charts/
	helm repo update
	

# ============================= #
#           operator            # 
# ============================= #


install-operator:
	kubectl apply -f ./strimzi-kafka-operator/strimzi.ns.yaml
	kubectl create -f 'https://strimzi.io/install/latest?namespace=$(operator-namespace)' -n $(operator-namespace)
	kubectl wait deployment -n $(operator-namespace) strimzi-cluster-operator --for condition=Available=True --timeout=90s

uninstall-operator:
	-kubectl delete -f 'https://strimzi.io/install/latest?namespace=$(operator-namespace)' -n $(operator-namespace)
	-kubectl delete -f ./strimzi-kafka-operator/strimzi.ns.yaml







# ============================= #
#         kafka-cluster         # 
# ============================= #

deploy-kafka-cluster: install-kafka-cluster show-kafka-cluster

install-kafka-cluster:
#	kubectl apply -f ./configuration/kafka/data-mesh.ns.yaml
	kubectl apply -n $(kafka-namespace) -f ./configuration/kafka
	kubectl apply -n $(kafka-namespace) -f ./configuration/monitors/kafka-resources-metrics.yaml

#	kubectl wait kafka -n $(operator-namespace) kafka-cluster --for condition=Available=True --timeout=90s
	




show-kafka-cluster:
	-kubectl get pods -n $(kafka-namespace)
	-kubectl get kafka -n $(kafka-namespace)
	-kubectl get services -n $(kafka-namespace)
	-kubectl get Deployment -n $(kafka-namespace)

describe-kafka-cluster:
	kubectl describe kafka data-mesh -n $(kafka-namespace)
	kubectl get Deployment -n $(kafka-namespace)


delete-kafka-cluster:
	-kubectl delete -n $(kafka-namespace) -f ./configuration/kafka
#	-kubectl delete -f ./configuration/kafka/data-mesh.ns.yaml


# ============================= #
#           others              # 
# ============================= #


install-kafka-tools:
	kubectl apply -n $(kafka-namespace) -f ./configuration/ksql

remote-kafka-tools:
	-kubectl delete -n $(kafka-namespace) -f ./configuration/ksql



# ============================= #
#           topics              # 
# ============================= #

create-topics:
	kubectl apply -f ./topics -n $(kafka-namespace)

list-topics:
	kubectl get kafkatopic -n $(kafka-namespace)


#
#
#... I need to continue here: https://www.infoq.com/articles/strimzi-the-gitops-way/
#
#
