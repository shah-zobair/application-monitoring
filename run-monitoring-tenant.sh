#!/bin/bash


NS=`cat monitoring-tenant/values.yaml  | grep "^monitoring_namespace:" | awk {' print $2 '} | sed s/\"//g`

helm upgrade -i --debug monitoring-tenant --namespace $NS ./monitoring-tenant

echo "Please create routes using certs"

echo "Example:"

echo "For testing: oc expose service grafana-service"
echo "oc create route edge --service=grafana-service --cert=tls.crt --key=tls.key --hostname=grafana-route-[NAMESPACE].apps.example.com"

