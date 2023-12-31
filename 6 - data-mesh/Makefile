
operator-namespace = strimzi-kafka
kafka-namespace = data-mesh

bridge-domain = datamesh.brimdataservices.com.br

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


#prefer using helm install
install-operator-helm:
	-kubectl apply -f ./strimzi-kafka-operator/strimzi.ns.yaml
	helm upgrade --install strimzi-kafka-operator ./strimzi-kafka-operator -n $(operator-namespace) --values ./strimzi-kafka-operator/values.customized.yaml






# ============================= #
#         kafka-cluster         # 
# ============================= #

deploy-kafka-cluster: install-kafka-cluster show-kafka-cluster

install-kafka-cluster:
	kubectl apply -f ./configuration/kafka/data-mesh.ns.yaml
	kubectl apply -n $(kafka-namespace) -f ./configuration/kafka
	kubectl apply -n $(kafka-namespace) -f ./configuration/monitors/kafka-resources-metrics.yaml

#	kubectl wait kafka -n $(operator-namespace) kafka-cluster --for condition=Available=True --timeout=90s
	




show-kafka-cluster:
	-kubectl get pods -n $(kafka-namespace)
	-kubectl get kafka -n $(kafka-namespace)
	-kubectl get services -n $(kafka-namespace)
	-kubectl get Deployment -n $(kafka-namespace)

describe-kafka-cluster:
	kubectl describe kafka kafka-cluster -n $(kafka-namespace)
	kubectl get Deployment -n $(kafka-namespace)


delete-kafka-cluster:
	-kubectl delete -n $(kafka-namespace) -f ./configuration/kafka
#	-kubectl delete -f ./configuration/kafka/data-mesh.ns.yaml


# ============================= #
#           others              # 
# ============================= #


install-kafka-tools: install-schema-registry
	kubectl apply -n $(kafka-namespace) -f ./configuration/ksql
	kubectl apply -n $(kafka-namespace) -f ./configuration/connect
	kubectl apply -n $(kafka-namespace) -f ./configuration/bridge

remove-kafka-tools: remove-schema-registry
	-kubectl delete -n $(kafka-namespace) -f ./configuration/ksql
	-kubectl delete -n $(kafka-namespace) -f ./configuration/connect
	-kubectl delete -n $(kafka-namespace) -f ./configuration/bridge


install-schema-registry:
# https://bitnami.com/stack/schema-registry/helm
	helm upgrade --install schema-registry oci://registry-1.docker.io/bitnamicharts/schema-registry -n $(kafka-namespace) --values ./configuration/schema-registry/schema-registry.bitnami.values.yaml 

remove-schema-registry:
	-helm delete schema-registry



# ============================= #
#           topics              # 
# ============================= #

create-topics:
	kubectl apply -f ./topics -n $(kafka-namespace)

list-topics:
	kubectl get kafkatopic -n $(kafka-namespace)


producing-bridge-messages:
	curl -X POST \
		--insecure https://$(bridge-domain)/topics/movies \
		-H 'content-type: application/vnd.kafka.json.v2+json' \
		-d '{ 
			"records": [ 
				{ 
					"key": "key-1", 
					"value": "TOP-Gun,10,1989" 
				}, 
				{ 
					"key": "key-2", 
					"value": "cableguy,5,1988" 
				} 
			] 
		}' 


#
#
#... I need to continue here: https://www.infoq.com/articles/strimzi-the-gitops-way/
#
#
