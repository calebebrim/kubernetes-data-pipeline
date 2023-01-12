operatorRelease = strimzi-kafka
clusterRelease = kafka-cluster

# should match the helm values files
clusterNs = datamesh
operatorNs = kafka

# add helm chart repo for Strimzi
add-repo:
	helm repo add strimzi https://strimzi.io/charts/
	helm repo update
	

# install it! (I have used strimzi-kafka as the release name)
# >>>>>> https://dzone.com/articles/grafana-and-prometheus-setup-with-strimzi-aka-kafk

op:
	helm upgrade --install $(operatorRelease) -n $(operatorNs) --create-namespace helm/strimzi-operator-installer/ 

op-validation:
	helm upgrade --install $(operatorRelease) -n $(operatorNs) --create-namespace helm/strimzi-operator-installer/ --dry-run

rmop:
	helm delete $(operatorRelease) -n $(operatorNs)
	- kubectl delete namespace $(operatorNs)


install:
	helm upgrade --install $(clusterRelease) --create-namespace -n $(clusterNs) helm/kafka-cluster


validation:
	helm upgrade --install $(clusterRelease) --create-namespace -n $(clusterNs) helm/kafka-cluster --dry-run --debug


delete:
	helm delete $(clusterRelease) -n $(clusterNs)
	kubectl delete namespace -n $(clusterNs)

show-kafka-cluster:
	kubectl get pods -n $(clusterNs)
	kubectl get kafka -n $(clusterNs)
	kubectl get services -n $(clusterNs)

describe-kafka-cluster:
	kubectl describe kafka my-cluster -n $(clusterNs)


create-topics:
	kubectl apply -f ./topics -n $(clusterNs)

list-topics:
	kubectl get kafkatopic -n $(clusterNs)


#
#
#... I need to continue here: https://www.infoq.com/articles/strimzi-the-gitops-way/
#
#