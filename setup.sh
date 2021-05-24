#!/bin/bash
echo "minikube start"
minikube start

clear
echo "minikube-docker connect start"
eval $(minikube docker-env)

clear
mini_k=$(minikube ip)
echo "my minikube ip is $mini_k, convert MY_MINI_IP to minikube ip"
sleep 1
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/ftps/vsftpd.conf
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/ftps/ftps.yaml
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/grafana/grafana.yaml
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/mysql/wordpress.sql
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/nginx/default
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/nginx/nginx.yaml
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/phpmyadmin/phpmyadmin.yaml
sed -i "s/MY_MINI_IP/$mini_k/g" ./srcs/wordpress/wordpress.yaml
sleep 1

clear
echo "metallb in minikube setting"
minikube addons enable metallb
sleep 1
kubectl apply -f ./srcs/metallb-cm.yml
sleep 1

clear
echo "create pv-pvc"
kubectl apply -f ./srcs/pv-volume.yaml
kubectl apply -f ./srcs/pv-claim.yaml
sleep 1

clear
echo "docker build start"
sleep 1

docker build -t ftps ./srcs/ftps/.
docker build -t grafana ./srcs/grafana/.
docker build -t mysql ./srcs/mysql/.
docker build -t influxdb ./srcs/influx/.
docker build -t nginx ./srcs/nginx/.
docker build -t phpmyadmin ./srcs/phpmyadmin/.
docker build -t wordpress ./srcs/wordpress/.

clear
echo "kubernetes apply images.yaml"
sleep 1

kubectl apply -f ./srcs/influx/influx.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl apply -f ./srcs/dashboard-adminuser.yaml
kubectl apply -f ./srcs/rollbinding.yaml
#kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
#http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
kubectl proxy
