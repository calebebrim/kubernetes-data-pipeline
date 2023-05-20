export namespace=data-mesh
export ksqlpodname="$(kubectl get pods -n $namespace -o jsonpath='{.items[0].metadata.name}' --selector=app=ksqldb-server)"

kubectl exec $ksqlpodname -n $namespace -i -t -- bash ksql