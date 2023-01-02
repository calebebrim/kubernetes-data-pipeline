

1:
	openssl genrsa -out ca.key 2048
2: 
	openssl req -x509 \
		-new -nodes  \
		-days 365 \
		-key ca.key \
		-out ca.crt \
		-subj "/CN=brimdataservices.com.br"


create: 1 2

deploy:
	kubectl create secret tls brimdataservices \
		--key ca.key \
		--cert ca.crt
run: create deploy
	