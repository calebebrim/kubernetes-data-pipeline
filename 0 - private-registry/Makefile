cluster-name = development
container-name = k3d-dev-repo.localhost
# register cluster network on registry container
register:
	-@ docker network create -d bridge k3d-$(cluster-name)
	-docker network connect k3d-$(cluster-name) $(container-name)