#!/bin/bash


NS=`cat monitoring-tenant/values.yaml  | grep "^monitoring_namespace:" | awk {' print $2 '} | sed s/\"//g`

helm upgrade -i --debug monitoring-rbac --namespace $NS ./monitoring-rbac


#MONITORING_NAMESPACE=`cat ./monitoring-rbac/values.yaml | grep ^monitoring_namespace | awk {' print $2 '} `
#PROMETHEUS_CSV=`oc get csv -n $MONITORING_NAMESPACE -o=custom-columns="NAME:.metadata.name" | grep -i prometheus`
#GRAFANA_CSV=`oc get csv -n $MONITORING_NAMESPACE -o=custom-columns="NAME:.metadata.name" | grep -i grafana`

#n=0
#max=20
#delay=10
#  while true; do
#      if [[ $n -lt $max ]]; then
#        ((n++))
#P_STAT=`oc get csv -n $MONITORING_NAMESPACE -o=custom-columns="NAME:.metadata.name,STATUS:.status.phase" | grep -i prometheus | awk {' print $2 '}`
#G_STAT=`oc get csv -n $MONITORING_NAMESPACE -o=custom-columns="NAME:.metadata.name,STATUS:.status.phase" | grep -i grafana | awk {' print $2 '}`
#        if [[ $P_STAT != "Succeeded" ]] || [[ $G_STAT != "Succeeded" ]];then
#           echo "Operarors are not ready yet. Attempt $n/$max"
#           sleep $delay;
#        else
#           echo "Operators are ready. Applying the CSV patch"
#	   sleep 3
#	   oc patch ClusterServiceVersion $PROMETHEUS_CSV -p "$(cat ./monitoring-rbac/csv-patch.yaml)" --type=merge -n $MONITORING_NAMESPACE
#           oc patch ClusterServiceVersion $GRAFANA_CSV -p "$(cat ./monitoring-rbac/csv-patch.yaml)" --type=merge -n $MONITORING_NAMESPACE
#	   break
#        fi
#
#      else
#        echo "The Operators are not ready yet after $n attemps. Please apply CSV patch manually."
#	break
#      fi
#  done
