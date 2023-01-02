# Instalado a partir de:
#  choco install apache-httpd -y
# 
# Instalado em:
# 	C:\Users\Calebe Brim\AppData\Roaming\Apache24\bin
#
# É necessário registrar essa pasta no path do windows 

create-login:
	htpasswd -cBb registry.password admin admin

login:
# k3d-dev-repo.localhost must be registered on the windows hosts file. 
	docker login $(host)

