namespace=argocd
getconfig:
	mkdir config
	wget https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -O ./config/install.yaml

install:
	-kubectl create namespace $(namespace)
	kubectl apply -n $(namespace) -f ./config/install.yaml
	kubectl patch svc argocd-server -n $(namespace) -p '{"spec": {"type": "NodePort"}}'

adminPass:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
