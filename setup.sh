#!/bin/sh
#  Colors
green=$'\e[0;92;40m'
green_b=$'\e[0;30;102m'
green_d=$'\e[0;2;92;40m'
red=$'\e[0;92;31m'
green_b=$'\e[0;92;102m'
blue=$'\e[0;34;40m'
cyan=$'\e[0;1;36;40m'
magenta=$'\e[0;1;95;40m'
nc=$'\e[0m'

clean (){
	echo "${red}Cleaning Services...."
	if [[ $(kubectl get pod) ]]
	then
		kubectl delete pod --all
	fi
	if [[ $(kubectl get services) ]]
        then
                kubectl delete service --all
     fi
     kubectl delete deployment --all
     kubectl delete ingress --all
     kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
 	 docker system prune -af
	 echo "${nc}${green_b}-Cleaned-${nc}"

}

if [[ $1 = "clean" ]]
then
	eval $(minikube docker-env)
	clean
	exit
fi

if [[ $(minikube status | grep -c "Running") = 0 ]]
then
	echo "${green}Starting minikube....${nc}"
	minikube start --driver=virtualbox
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
fi

eval $(minikube docker-env)

echo "${blue}Starting MetalLB...${nc}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> logs.txt
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> logs.txt
kubectl apply -f srcs/metallb.yaml >> logs.txt
echo "${green}MetalLB OK${nc}"

docker build -t nginx       ./srcs/nginx
#docker build -t phpmyadmin  ./srcs/phpmyadmin

docker build -t mysql       ./srcs/mysql

echo "${blue}Deploying nginx${nc}"
#kubectl apply -f srcs/phpmyadmin.xyaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
echo "${green}Nginx OK${nc}"
sleep 7
kubectl get services
kubectl get pod