ksqlpodname = "$(kubectl get pods -n kafka -o jsonpath='{.items[0].metadata.name}' --selector=app=ksqldb-server)"


kubectl exec $ksqlpodname -n kafka -i -t -- bash ksql