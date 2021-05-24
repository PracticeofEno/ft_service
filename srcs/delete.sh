#!/bin/bash
mini_k=$(minikube ip)
echo $mini_k
kubectl delete -f ftps/ftps.yaml
kubectl delete -f grafana/grafana.yaml
kubectl delete -f influx/influx.yaml
kubectl delete -f mysql/mysql.yaml
kubectl delete -f wordpress/wordpress.yaml
kubectl delete -f phpmyadmin/phpmyadmin.yaml
kubectl delete -f nginx/nginx.yaml
