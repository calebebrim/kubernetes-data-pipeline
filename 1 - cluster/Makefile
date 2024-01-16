# clean:
#     $(RM) $(call FixPath,objs/*)


#volume mount configuration
volume=k3dmount
# volume-mount-path = E:/workspace/kubernetes/0-cluster/mount
volume-mount-path = /mnt/d/workspace/kubernetes/0-cluster/mount

volume-agent-mount-path=/persistent

#cluster config
cluster-name=development
servers=1
agents=1
http-port=80
https-port=443
api-port=6445




# other
portnumber=55145


# repository config
repository-name=dev-repo.localhost

# other configurations
default-namespace=development




dir:
	pwd

download-folder:
	-mkdir downloads
	

k3d-install:
	cd downloads
	wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

helm-install:
	cd downloads
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh

jq-install:
	snap install jq

install-binaries: download-folder k3d-install helm-install jq-install


create: create-cluster 

remove: delete-cluster 

create-mount:
	@echo mounting volume at: $(volume-mount-path)
	-@docker volume create --name $(volume) --opt type=none --opt device=$(volume-mount-path) --opt o=bind


delete-cluster: 
	k3d cluster delete $(cluster-name)

stop: 
	k3d cluster stop $(cluster-name)

start: 
	k3d cluster start $(cluster-name)
	

create-repo:
	k3d registry create myregistry.localhost --port 5000


create-cluster:  
	k3d cluster create $(cluster-name) \
		--servers $(servers) \
		--agents $(agents) \
		--kubeconfig-update-default \
		--port "$(http-port):80@loadbalancer" \
		--port "$(https-port):443@loadbalancer" \
		--api-port $(api-port) \
		--volume "$(volume-mount-path):$(volume-agent-mount-path)@agent:*" \
		--registry-use k3d-myregistry.localhost:5000 \
		--k3s-arg "--disable=traefik@server:*" \
		--wait 
		

#		--no-lb 
#	k3d cluster create $(cluster-name) \
#		--api-port $(api-port) \
#		--volume "$(volume):$(volume-agent-mount-path)@agent[*]" \
#		--port "$(http-port):80@loadbalancer" \
#		--port "$(https-port):443@loadbalancer" \
#		--k3s-server-arg "--no-deploy=traefik" \
#		--servers $(servers) \
#		--agents $(agents) \
#		--image rancher/k3s:v1.21.2-k3s1 \
#		--registry-config "./registries.yaml"
#		--registry-use http://k3d-dev-repo.localhost:5000
#		--registry-create \

	kubectl create namespace $(default-namespace)
	kubectl config use-context k3d-$(cluster-name)
	kubectl cluster-info

	
