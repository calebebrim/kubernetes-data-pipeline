/ := /

#SO definition 

ifdef OS
   RM = del /Q
   FixPath = $(subst /,\,$1)
	/ := \
else
   ifeq ($(shell uname), Linux)
	  @echo running at Linux
      RM = rm -f
      FixPath = $(subst \,/,$1)
	  / := /
   endif
endif

curr_dir = $(shell pwd)


# clean:
#     $(RM) $(call FixPath,objs/*)


#volume mount configuration
volume=k3dmount
volume-mount-path = $(curr_dir)$(/)mount
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

	
test:
	echo $(/)
	echo $(curr_dir)
	echo $(volume-mount-path)

create: create-mount create-cluster 

remove: delete-cluster 

create-mount:
	@echo mounting volume at: $(volume-mount-path)
	-@docker volume create $(volume) \
		--driver local \
		--opt type=none \
		--opt device=$(volume-mount-path) \
		--opt o=bind 


delete-cluster: 
	k3d cluster delete $(cluster-name)

stop: 
	k3d cluster stop $(cluster-name)

start: 
	k3d cluster start $(cluster-name)
	
# volume-agent-mount-path=/var/lib/rancher/k3s/storage/
create-cluster: 
	k3d cluster create $(cluster-name) \
		--verbose \
		--api-port $(api-port) \
		--volume "$(volume):$(volume-agent-mount-path)@agent:*" \
		--port "$(http-port):80@loadbalancer" \
		--port "$(https-port):443@loadbalancer" \
		--k3s-arg "--disable=traefik@server:*" \
		--servers $(servers) \
		--agents $(agents) \
		--image rancher/k3s:v1.21.2-k3s1 \
		--registry-config "./registries.yaml"
#		--k3s-server-arg "--no-deploy=traefik" \
#		--registry-use http://k3d-dev-repo.localhost:5000
#		--registry-create \

	kubectl create namespace $(default-namespace)
	kubectl config use-context k3d-$(cluster-name)
	kubectl cluster-info



checkport:
	Get-Process -Id (Get-NetTCPConnection -LocalPort $(portnumber)).OwningProcess

checkport-UDP: 
	Get-Process -Id (Get-NetUDPEndpoint -LocalPort $(portnumber)).OwningProcess
